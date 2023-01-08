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

################################
# MODULE - EC2 INSTANCE
################################
module "public_ubuntu" {
  ################################################
  # META DATA
  ################################################
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~>3.0"

  name                        = local.public_ubuntu_name
  instance_type               = local.ec2_context.instance_type
  key_name                    = local.ec2_context.key_name
  monitoring                  = local.ec2_context.monitoring
  associate_public_ip_address = local.ec2_context.associate_public_ip_address
   # user_data                   = local.openvpn_userdata

  ami = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [
    module.sg__ssh.security_group_id,
    module.sg__openvpn.security_group_id,
  ]
  subnet_id = local.public_subnets.subnets[0]
  tags      = merge(local.common_tags, { Name = local.public_ubuntu_name })

}

module "private_ubuntu" {
  ################################################
  # META DATA
  ################################################
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~>3.0"

  name                        = local.private_ubuntu_name
  instance_type               = local.ec2_context.instance_type
  key_name                    = local.ec2_context.key_name
  monitoring                  = local.ec2_context.monitoring
  associate_public_ip_address = local.ec2_context.associate_public_ip_address

  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [module.sg__ssh.security_group_id]
  subnet_id              = local.private_subnets.subnets[0]

  tags = merge(local.common_tags, { Name = local.private_ubuntu_name })

}

