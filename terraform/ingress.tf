resource "kubernetes_ingress_v1" "app" {
    metadata {
        name = "k8s-demo-ingress"
    }

    spec {
        rule {
          host = "k8s-demo.local"

            http {
              path {
                path = "/"
                path_type = "Prefix"

                backend {
                  service {
                    name = "k8s-demo"

                    port {
                      number = 3000
                    }
                  }
                }
              }
            }
        }
    }
}