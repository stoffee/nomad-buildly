job "buildly" {
  datacenters = ["dc1"]

  group "buildly" {
    count = 1

    task "server" {
      env {
        PORT    = "${NOMAD_PORT_http}"
        NODE_IP = "${NOMAD_IP_http}"
      }

      driver = "docker"

      config {
        image = "buildly/buildly"
        command = "bash /code/scripts/run-standalone-dev.sh"
      }

      resources {
        cpu    = 20
        memory = 678

        network {
          mbits = 10
          port  "http"{}
        }
      }

      service {
        name = "core"
        port = "http"

        tags = [
          "traefik.tags=service",
#          "traefik.frontend.rule=PathPrefixStrip:/",
        ]

        check {
          type     = "http"
          path     = "/"
          interval = "2s"
          timeout  = "2s"
        }
      }
    }
  }
}