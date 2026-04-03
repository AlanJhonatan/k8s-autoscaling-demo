resource "kubernetes_horizontal_pod_autoscaler_v2" "app" {
    metadata {
        name = "k8s-demo-hpa"
    }

    spec {
        min_replicas = 1
        max_replicas = 5

        scale_target_ref {
            api_version = "apps/v1"
            kind = "Deployment"
            name = "k8s-demo"
        }

        metric {
            type = "Resource"

            resource {
                name = "cpu"

                target {
                    type = "Utilization"
                    average_utilization = 50
                }
            }
        }
    }
}