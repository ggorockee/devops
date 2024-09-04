terraform {
  required_version = ">=1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.26.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.32.0"
    }
  }
}

provider aws {}
provider "kubernetes" {
  host = module.ggorockee_eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.ggorockee_eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = ["eks", "get-token", "--cluster-name", module.ggorockee_eks.cluster_name]
  }
}