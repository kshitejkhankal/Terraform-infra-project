# resource "aws_iam_role" "this" {
#   for_each = var.iam_roles
#   name = each.key
#   assume_role_policy = each.value.assume_role_policy
#   tags = var.tags
# }

resource "aws_iam_role_policy_attachment" "cluster" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn =  var.cluster-policy-arn[0] 
}
resource "aws_iam_role_policy_attachment" "cluster1" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn =  var.cluster-policy-arn[1] 
}
resource "aws_iam_role_policy_attachment" "worker1" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = var.worker-policy-arn[0]  
}
resource "aws_iam_role_policy_attachment" "worker2" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = var.worker-policy-arn[1]  
}
resource "aws_iam_role_policy_attachment" "worker3" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = var.worker-policy-arn[2]  
}

# IAM Role specifically for EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
  tags = var.tags
}


resource "aws_iam_role" "eks_worker_role" {
  name = "eks-worker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })

  tags = var.tags
}



