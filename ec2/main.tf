resource "local_file" "foo" {
  content  = "Hello World"
  filename = "${path.module}/foo.bar"
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = local.config.network.organization
    workspaces = {
      name = local.config.network.workspace
    }
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "public_ubuntu" {
  ami                         = data.aws_ami.ubuntu.image_id
  instance_type               = local.ec2_context.instance_type
  key_name                    = local.ec2_context.key_name
  monitoring                  = local.ec2_context.monitoring
  associate_public_ip_address = local.ec2_context.associate_public_ip_address
  subnet_id                   = local.public_subnets.subnets[0]
  user_data                   = local.openvpn_userdata

  vpc_security_group_ids = [module.sg__ssh.security_group_id, module.sg__openvpn.security_group_id]

  tags = merge(local.common_tags, { Name = local.public_ubuntu_name })
}

resource "aws_instance" "private_ubuntu" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = local.ec2_context.instance_type
  key_name                    = local.ec2_context.key_name
  monitoring                  = local.ec2_context.monitoring
  associate_public_ip_address = local.ec2_context.associate_public_ip_address
  subnet_id                   = local.private_subnets.subnets[0]

  vpc_security_group_ids = [module.sg__ssh.security_group_id]

  tags = merge(local.common_tags, { Name = local.private_ubuntu_name })
}