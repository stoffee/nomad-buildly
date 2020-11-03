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
      env {
        DJANGO_SETTINGS_MODULE="buildly.settings.production"
        ALLOWED_HOSTS="*"
        CORS_ORIGIN_WHITELIST="*"
        DATABASE_ENGINE="postgresql"
        DATABASE_NAME="buildly"
        DATABASE_USER="postgres"
        DATABASE_PASSWORD="password"
        DATABASE_HOST="buildly-db"
        DATABASE_PORT="5432"
        DEFAULT_ORG="Default Organization"
        JWT_ISSUER="buildly"
        SOCIAL_AUTH_GITHUB_REDIRECT_URL="https://localhost:8000/complete/github"
        SOCIAL_AUTH_GOOGLE_OAUTH2_REDIRECT_URL="https://localhost:8000/complete/google-oauth2"
        SOCIAL_AUTH_LOGIN_REDIRECT_URL="http://localhost:8080/"
        SOCIAL_AUTH_MICROSOFT_GRAPH_REDIRECT_URL="https://localhost:8000/complete/microsoft-graph"
        ACCESS_TOKEN_EXPIRE_SECONDS="86400"
        SECRET_KEY="ek*)b=mtcc7q1cym@oox(lyrz1ncz-(w+(#&u7l-&)7a8wv#_k"
        OAUTH_CLIENT_ID="wkXLlC9h3k0jxIx7oLllxpFVU89Dxgi7O8FYZyfX"
        OAUTH_CLIENT_SECRET="KiKRft8MajLabQId7pjSsa3OfvJAXN9NENi0tVRTX3Vbthr6iClEDZZtbyGuD9M8UbKpK2E8R4xJYUolZxg1nVa1iZwhQPi5ionOKdpIs4de2bmUaZ0qWi4MdBmdwDvF"
        USE_PASSWORD_USER_ATTRIBUTE_SIMILARITY_VALIDATOR="True"
        USE_PASSWORD_MINIMUM_LENGTH_VALIDATOR="True"
        PASSWORD_MINIMUM_LENGTH="6"
        USE_PASSWORD_COMMON_VALIDATOR="True"
        USE_PASSWORD_NUMERIC_VALIDATOR="True"
        FRONTEND_URL="http://localhost:3000/login/"
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
        name = "buildly-core"
        port = "http"

        tags = [
          "traefik.tags=service",
          "traefik.frontend.rule=PathPrefixStrip:/",
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