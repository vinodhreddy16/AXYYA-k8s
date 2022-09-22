resource "aws_iam_role" "axyya-workernodes" {
  name = format("axyya-eks-node-group-%s", var.env)

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.axyya-workernodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.axyya-workernodes.name
}

resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role       = aws_iam_role.axyya-workernodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.axyya-workernodes.name
}

resource "aws_eks_cluster" "axyya_eks_cluster" {
  name     = "${var.eks_cluster_name}-${var.env}"
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = "true"
    endpoint_public_access  = "false"
  }

  depends_on = [
    var.eks_cluster_create_depends_on
  ]
}

resource "aws_eks_node_group" "worker-node-group" {
  count           = var.instance_count
  cluster_name    = aws_eks_cluster.axyya_eks_cluster.name
  node_group_name = "axyya-workernodes-${count.index}"
  node_role_arn   = aws_iam_role.axyya-workernodes.arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_type

  scaling_config {
    desired_size = 1
    max_size     = var.instance_count
    min_size     = 1

  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
output "endpoint" {
  value = aws_eks_cluster.axyya_eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.axyya_eks_cluster.certificate_authority[0].data
}
