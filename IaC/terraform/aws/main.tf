module "ggorockee_vpc" {
  source = "./modules/vpc"
}

module "ggorockee_eks" {
  source = "./modules/eks"

  owner = "ggorockee"

  vpc_id = module.ggorockee_vpc.vpc_id
  private_subnets = module.ggorockee_vpc.private_subnets

  cluster_version = "1.29"

  private_access = true
  public_access = true

  capacity_type = "ON_DEMAND"
  instance_types = ["t3.medium"]

  depends_on = [module.ggorockee_vpc]
}