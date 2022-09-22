
variable "vpc_name" {
  description = "name of the VPC"
  type        = string
}

variable "cidr-vpc" {
  description = "VPC cidr"
  type        = string
}

variable "cidr-subnets" {
  description = "CIDR for public subnets"
  type        = list(any)
}

variable "subnet_ids" {
  description = "list of public subnets"
  type        = list(any)
}

variable "aws_igw_var" {
  type        = string
  description = "variables for internet gateway"
}

variable "aws_rt_var" {
  description = "variables for route table"
  type        = list(any)
  default     = ["axyya-internet", "0.0.0.0/0"]
}

variable "aws_sg1_in_var" {
  type    = list(any)
  default = ["axyya-sg-group1", "all traffic", "tcp", ]
}

variable "aws_sg_out_var" {
  description = "variables for full access outbound rule rule"
  type        = list(any)
  default     = ["Outbound rule responding to all traffic", "-1"]
}

variable "aws_sg2_in_var" {
  type    = list(any)
  default = ["axyya-sg-group2", "all traffic", "tcp", ]

}
