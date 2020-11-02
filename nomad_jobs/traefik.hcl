job "traefik" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "service"

  group "traefik" {
    count = 1

    task "traefik" {

      driver = "docker"
      config {
        image        = "traefik:1.7"
        network_mode = "host"

        volumes = [
          "local/traefik.toml:/etc/traefik/traefik.toml",
        ]
      }

      template {
        data = <<EOD
[entryPoints]
    [entryPoints.http]
    address = ":8080"
    [entryPoints.traefik]
    address = ":8081"

[api]

    dashboard = true

# Enable Consul Catalog configuration backend.
[consulCatalog]

endpoint = "127.0.0.1:8500"

domain = "consul.localhost"

prefix = "traefik"

constraints = ["tag==service"]
EOD

        destination = "local/traefik.toml"
      }

      resources {
        cpu    = 250
        memory = 128

        network {
          mbits = 10

          port "http" {
            static = 8080
          }

          port "api" {
            static = 8081
          }
        }
      }

      service {
        name = "traefik"

        check {
          name     = "alive"
          type     = "tcp"
          port     = "http"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
