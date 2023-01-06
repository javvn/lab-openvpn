locals {
  ################################
  # CONTEXT AND CONFIG
  ################################
  context = yamldecode(file(var.config_file)).context
  config  = yamldecode(templatefile(var.config_file, local.context))


  ################################
  # TAGS
  ################################
  common_tags = {
    Terraform   = local.context.terraform
    Environment = local.context.env
    Owner       = local.context.owner
    Project     = local.context.project
  }

  vpc_tags = merge(local.common_tags, { Name = "${local.context.name}-vpc" })
  igw_tags = merge(local.common_tags, { Name = "${local.context.name}-igw" })

  public_subnet_tags      = merge(local.common_tags, { Name = "${local.context.name}-public-sb" })
  public_route_table_tags = merge(local.common_tags, { Name = "${local.context.name}-publuc-rt" })

  private_subnet_tags      = merge(local.common_tags, { Name = "${local.context.name}-private-sb" })
  private_route_table_tags = merge(local.common_tags, { Name = "${local.context.name}-private-rt" })


}