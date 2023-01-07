module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"

  name        = "${local.remote_state_context.name}-sg"
  description = "Security Group for Open-vpn"
  vpc_id      = local.vpc_id

  ingress_with_cidr_blocks = [
    {
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = "0.0.0.0/0"
      description = "SSH"
    },
    {
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = "0.0.0.0/0"
      description = "HTTP"
    },
  ]

  egress_with_cidr_blocks = [
    {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = merge(local.common_tags, { Name = "${local.remote_state_context.name}-sg" })
}