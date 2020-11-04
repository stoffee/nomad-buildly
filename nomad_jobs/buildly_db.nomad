job "buildly-db" {
  datacenters = ["dc1"]
  group "buildly" {
    count = 1
    task "buildly-db" {
      driver = "docker"
      constraint {
        attribute = "${attr.os.name}"
        value = "ubuntu"
      }
      config {
        image = "postgres"
      }
      env {
          POSTGRES_USER="postgres"
          POSTGRES_PASSWORD="password"
          POSTGRES_DB="buildly"
      }
      logs {
        max_files     = 5
        max_file_size = 15
      }
      resources {
        network {
          port "db" {
            static = 5432
          }
        }
      }
      service {
        name = "buildly-db"
        port = "db"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }
  }
}