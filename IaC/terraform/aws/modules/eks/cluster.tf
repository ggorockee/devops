module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name = "${local.owner}-cluster"
  cluster_version = local.cluster_version

  cluster_endpoint_private_access = var.private_access
  cluster_endpoint_public_access = var.public_access

  cluster_encryption_config = {}

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id = local.vpc_id
  subnet_ids = local.private_subnets

  eks_managed_node_groups = {
    ggorockee-node = {
      name = "${local.owner}-nodegroup"
      use_name_prefix =  true

      subnet_ids = local.private_subnets

      min_size = 1
      max_size = 2
      desired_size = 1

      ami_id = data.aws_ami.ggorockee_eks_ami.id
      enable_bootstrap_user_data = true

      capacity_type = local.capacity_type
      instance_types = local.instance_types

      create_iam_role = true
      iam_role_name = "${local.owner}-nodegroup-role"
      iam_role_name_prefix = true
    }
  }
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "cluster_name" {
  value = module.eks.cluster_name
}

module "eks-auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "~> 20.0"

  manage_aws_auth_configmap = true

  depends_on = [module.eks]

#  aws_auth_roles = [
#    {
#      rolearn  = "arn:aws:iam::66666666666:role/role1"
#      username = "role1"
#      groups   = ["system:masters"]
#    },
#  ]
#
#  aws_auth_users = [
#    {
#      userarn  = "arn:aws:iam::66666666666:user/user1"
#      username = "user1"
#      groups   = ["system:masters"]
#    },
#    {
#      userarn  = "arn:aws:iam::66666666666:user/user2"
#      username = "user2"
#      groups   = ["system:masters"]
#    },
#  ]

#  aws_auth_accounts = [
#    "777777777777",
#    "888888888888",
#  ]
}