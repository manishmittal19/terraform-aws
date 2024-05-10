module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  cluster_endpoint_public_access = false

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

  vpc_id                   = module.eks-vpc.vpc_id
  subnet_ids               = module.eks-vpc.private_subnets
  control_plane_subnet_ids = module.eks-vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    eks-demo = {
      min_size     = 1
      max_size     = 5
      desired_size = 3
      instance_types = ["t2.small"]
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}