resource "aws_eip" "ubuntu" {
  instance                  = module.ec2_instance.id
  associate_with_private_ip = module.ec2_instance.private_ip
  vpc                       = true

  tags = merge(local.common_tags, { Name = local.eip_name })
}