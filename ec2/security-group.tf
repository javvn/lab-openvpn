module "sg__ssh" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"

  name        = "${local.remote_state_context.name}-ssh"
  description = "Security Group for SSH"
  vpc_id      = local.vpc_id

  ingress_with_cidr_blocks = [
    {
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = "0.0.0.0/0"
      description = "SSH"
    },
    # {
    #   protocol    = "tcp"
    #   from_port   = 80
    #   to_port     = 80
    #   cidr_blocks = "0.0.0.0/0"
    #   description = "HTTP"
    # },
  ]

  # egress_with_cidr_blocks = [
  #   {
  #     protocol    = "-1"
  #     from_port   = 0
  #     to_port     = 0
  #     cidr_blocks = "0.0.0.0/0"
  #   }
  # ]

  tags = merge(local.common_tags, { Name = "${local.remote_state_context.name}-ssh" })
}

module "sg__openvpn" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"

  name        = "${local.remote_state_context.name}-openvpn"
  description = "Security Group for OpenVPN"
  vpc_id      = local.vpc_id

  ingress_with_cidr_blocks = [
    {
      id          = "openvpn/all"
      protocol    = "udp"
      from_port   = 1194
      to_port     = 1194
      cidr_blocks = "0.0.0.0/0"
      description = "Allow OpenVPN from anywhere."
    }
  ]
  egress_with_cidr_blocks = [
    {
      id          = "all/all"
      description = "Allow to communicate to the Internet."
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = merge(local.common_tags, { Name = "${local.remote_state_context.name}-openvpn" })
}