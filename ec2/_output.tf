# output "ec2_context" {
#   value = local.ec2_context
# }

# output "config_network" {
#   value = local.config.network
# }

output "remote_state_context" {
  value = local.remote_state_context
}

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
    security_group_vpc_id = module.sg__ssh.security_group_vpc_id
    sg_ssh_id             = module.sg__ssh.security_group_id
    sg_openvpn_id         = module.sg__openvpn.security_group_id
  }
}

output "public_ubuntu" {
  value = {
    instance_id = module.public_ubuntu.id
    public_ip   = module.public_ubuntu.public_ip
    private_ip  = module.public_ubuntu.private_ip
  }
}

output "private_ubuntu" {
  value = {
    instance_id = module.private_ubuntu.id
    public_ip   = module.private_ubuntu.public_ip
    private_ip  = module.private_ubuntu.private_ip
  }
}

output "eip_ubuntu" {
  value = {
    id         = aws_eip.ubuntu.id
    instance   = aws_eip.ubuntu.instance
    public_ip  = aws_eip.ubuntu.public_ip
    private_ip = aws_eip.ubuntu.private_ip
  }
}

# output "user_data" {
#   value = local.openvpn_userdata
# }