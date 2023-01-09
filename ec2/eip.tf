# resource "aws_eip" "ubuntu" {
#   instance                  = aws_instance.public_ubuntu.id
#   associate_with_private_ip = aws_instance.public_ubuntu.private_ip
#   vpc                       = true

#   # tags = merge(local.common_tags, { Name = local.eip_name })
# }

resource "aws_eip" "ubuntu" {
  tags = merge(local.common_tags, { Name = local.eip_name })
}

resource "aws_eip_association" "ubuntu" {
  instance_id   = aws_instance.public_ubuntu.id
  allocation_id = aws_eip.ubuntu.id
}