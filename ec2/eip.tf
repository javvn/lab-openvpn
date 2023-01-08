resource "aws_eip" "ubuntu" {
  instance                  = module.public_ubuntu.id
  associate_with_private_ip = module.public_ubuntu.private_ip
  vpc                       = true

  tags = merge(local.common_tags, { Name = local.eip_name })
}