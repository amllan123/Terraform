# resource "kubernetes_manifest" "deployment" {
#   manifest = yamldecode(file("/Users/amllan/Documents/new_eks/k82s/deployment.yaml"))
#   depends_on = [aws_eks_node_group.general]
# }

# resource "kubernetes_manifest" "service" {
#   manifest = yamldecode(file("/Users/amllan/Documents/new_eks/k82s/service.yaml"))
#   depends_on = [aws_eks_node_group.general]
# }

# resource "kubernetes_manifest" "cluster_issuer" {
#   manifest = yamldecode(file("/Users/amllan/Documents/new_eks/k82s/cluster-issuer.yaml"))
#   depends_on = [aws_eks_node_group.general]
# }

# resource "kubernetes_manifest" "ingress" {
#   manifest = yamldecode(file("/Users/amllan/Documents/new_eks/k82s/ingress.yaml"))
#   depends_on = [aws_eks_node_group.general]
# }

resource "helm_release" "my_app" {
  name       = "my-app"
  chart      = "/my-app"  # Path to your Helm chart
  namespace  = "default"

  depends_on = [aws_eks_node_group.general,helm_release.ingress,helm_release.cert_manager]
}


#please doo this kubectl delete ingress cm-acme-http-solver-945gh


