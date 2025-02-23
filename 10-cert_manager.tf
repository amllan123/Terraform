resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"
  version    = "v1.17.0"

  create_namespace = true

  set {
    name  = "crds.enabled"
    value = "true"
  }
  depends_on = [aws_eks_node_group.general]
}
