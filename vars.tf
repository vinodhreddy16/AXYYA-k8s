variable "region" {
}

variable "subnet_ids" {
  type = list(any)
}

variable "vpc_name" {
  description = "name of the VPC."
  type        = string
}


variable "cidr-vpc" {
  type = string
}

variable "aws_igw_var" {
  type = string
}

variable "cidr-subnets" {
  description = "CIDR for public subnets."
  type        = list(any)
}

variable "eks_cluster_name" {}

variable "aws_account_id" {}

variable "instance_type" {
  description = "Instance types for EKS cluster"
}

variable "instance_count" {
  description = "Instance count for EKS cluster"
}

