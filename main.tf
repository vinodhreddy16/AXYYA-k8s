provider "aws" {
  region = var.region
}

module "vpc" {
  source       = "./modules/vpc"
  vpc_name     = var.vpc_name
  cidr-vpc     = var.cidr-vpc
  aws_igw_var  = var.aws_igw_var
  cidr-subnets = var.cidr-subnets
  subnet_ids   = var.subnet_ids
}

module "eks_cluster" {
  source                        = "./modules/eks"
  eks_cluster_name              = var.eks_cluster_name
  vpc_id                        = module.vpc.vpc_id
  subnet_ids                    = module.vpc.subnet_ids
  instance_count                = var.instance_count
  instance_type                 = var.instance_type
  ingress_rule                  = var.ingress_rule
}
