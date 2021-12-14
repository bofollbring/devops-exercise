esource "kubernetes_deployment" "time" {
  metadata {
    name = "terraform-time"
    labels = {
      test = "MyTimeApp"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "MyTimeApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyTimeApp"
        }
      }

      spec {
        container {
          image = "nginx:1.7.8"
          name  = "time"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
            env {
              name = "DB_URL"
              value = "postgresql://dbuser:secretpassword@database.server.com:3211/postgres"
            }
            env {
              name = "PORT"
              value = "9999"
            }
          }

          liveness_probe {
            http_get {
              path = "/nginx_status"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
