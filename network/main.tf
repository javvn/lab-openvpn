##############################
# STATE CHECK
##############################
resource "local_file" "foo" {
  content  = "Hello World"
  filename = "${path.module}/foo.bar"
}


##############################
# MODULE
##############################
module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = local.config.vpc.name
  cidr = local.config.vpc.cidr
  azs  = local.context.azs

  ################################
  # SUBNETS
  ################################
  public_subnets  = local.config.subnet_groups.public.subnets
  private_subnets = local.config.subnet_groups.private.subnets

  enable_ipv6        = false
  enable_vpn_gateway = false
  enable_nat_gateway = false
  single_nat_gateway = false

  ################################
  # TAGS
  ################################
  tags     = local.common_tags
  vpc_tags = local.vpc_tags
  igw_tags = local.igw_tags

  public_subnet_tags      = local.public_subnet_tags
  public_route_table_tags = local.public_route_table_tags

  private_subnet_tags      = local.private_subnet_tags
  private_route_table_tags = local.private_route_table_tags
}
