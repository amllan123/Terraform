# data "aws_eks_cluster" "eks2" {
#   name = aws_eks_cluster.eks.name
# }

# data "aws_eks_cluster_auth" "eks2" {
#   name = aws_eks_cluster.eks.name

# }

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.eks2.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks2.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.eks2.token
  
# }