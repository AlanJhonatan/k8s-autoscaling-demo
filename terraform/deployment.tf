resource "kubernetes_deployment_v1" "app" {
  metadata {
    name = "k8s-demo"
    labels = {
      app = "k8s-demo"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "k8s-demo"
      }
    }

    template {
      metadata {
        labels = {
          app = "k8s-demo"
        }
      }

      spec {
        container {
          image = "k8s-demo:v1"
          name  = "k8s-demo"

          port {
            container_port = 3000
          }

          resources {
            requests = {
              cpu = "100m"
            }

            limits = {
              cpu = "200m"
            }
          }
        }
      }
    }
  }
}
