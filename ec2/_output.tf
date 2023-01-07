# output "ec2_context" {
#   value = local.ec2_context
# }

# output "config_network" {
#   value = local.config.network
# }

# output "remote_state_context" {
#   value = local.remote_state_context
# }

# output "common_tags" {
#   value = local.common_tags
# }

output "vpc_id" {
  value = local.vpc_id
}

output "public_subnets" {
  value = local.public_subnets
}

output "private_subnets" {
  value = local.private_subnets
}

output "security_group" {
  value = {
    security_group_vpc_id = module.sg.security_group_vpc_id
    security_group_id     = module.sg.security_group_id
  }
}

output "ec2_instance_ubuntu" {
  value = {
    instance_id = module.ec2_instance.id
    public_ip   = module.ec2_instance.public_ip
    private_ip  = module.ec2_instance.private_ip
  }
}

output "eip_ubuntu" {
  value = {
    id = aws_eip.ubuntu.id
    instance = aws_eip.ubuntu.instance
    public_ip = aws_eip.ubuntu.public_ip
    private_ip = aws_eip.ubuntu.private_ip
  }
}

# output "ami_ubuntu" {
#   value = data.aws_ami.ubuntu
# }