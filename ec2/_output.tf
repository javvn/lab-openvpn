# output "ec2_context" {
#   value = local.ec2_context
# }

# output "config_network" {
#   value = local.config.network
# }

# output "remote_state_context" {
#   value = local.remote_state_context
# 

output "vpc_id" {
  value = local.vpc_id
}


output "public_ubuntu" {
  value = {
    instance_id = aws_instance.public_ubuntu.id
    public_ip   = aws_instance.public_ubuntu.public_ip
    private_ip  = aws_instance.public_ubuntu.private_ip
  }
}

output "private_ubuntu" {
  value = {
    instance_id = aws_instance.private_ubuntu.id
    public_ip   = aws_instance.private_ubuntu.public_ip
    private_ip  = aws_instance.private_ubuntu.private_ip
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