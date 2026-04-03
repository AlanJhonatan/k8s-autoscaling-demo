resource "kubernetes_service_v1" "app" {
    metadata {
        name = "k8s-demo"
    }

    spec {
        selector = {
            app = "k8s-demo"
        }

        port {
            port = 3000
            target_port = 3000
        }
    }
}