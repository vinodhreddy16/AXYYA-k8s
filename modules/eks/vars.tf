variable "eks_cluster_role_arn" {
}

variable "eks_cluster_name" {}
variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {}
variable "instance_type" {}
variable "instance_count" {
  description = "instance count for EKS cluster"
}

variable "eks_cluster_create_depends_on" {}
variable "env" {}
