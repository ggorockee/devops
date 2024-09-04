locals {
  vpc_id = var.vpc_id
  private_subnets = var.private_subnets
  owner = var.owner
  cluster_version = var.cluster_version

  capacity_type = var.capacity_type
  instance_types = var.instance_types
}