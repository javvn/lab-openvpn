output "config" {
  value = {
    # region        = local.config.context.region
    # name          = local.config.context.name
    # vpc           = local.config.vpc
    # subnet_groups = local.config.subnet_groups
  }
}

output "context" {
  value = local.context
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnets" {
  value = {
    subnets = module.network.public_subnets
    cidr_block = module.network.public_subnets_cidr_blocks
  }
}

output "private_subnets" {
  value = {
    subnets = module.network.private_subnets
    cidr_block = module.network.private_subnets_cidr_blocks
  }
}