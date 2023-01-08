locals {
  ####################################################
  # LOCAL STATE
  ####################################################
  ec2_context = yamldecode(file(var.config_file)).context
  config      = yamldecode(file(var.config_file)).remote_states

  ####################################################
  # REMOTE STATE
  ####################################################
  remote_state         = data.terraform_remote_state.network.outputs
  remote_state_context = local.remote_state.context

  # openvpn_userdata = templatefile("${path.module}/files/openvpn-userdata.sh", {
  #   vpc_cidr  = local.remote_state_context.cidr.primary
  #   public_ip = aws_eip.ubuntu.public_ip
  # })

  vpc_id          = local.remote_state.vpc_id
  common_tags     = local.remote_state.common_tags
  private_subnets = local.remote_state.private_subnets
  public_subnets  = local.remote_state.public_subnets


  public_ubuntu_name  = "${local.remote_state_context.name}-public-ubuntu-openvpn"
  private_ubuntu_name = "${local.remote_state_context.name}-private-ubuntu"
  eip_name            = "${local.remote_state_context.name}-eip"
}