terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "monitoring" {
  name = "monitoring"
}

# -----------------
# FLASK APP CONTAINER
# -----------------
resource "docker_container" "flask_app" {
  name  = "flask_app"
  image = "python:3.10"

  ports {
    internal = 5000
    external = 5000
  }

  volumes {
    host_path      = "${path.module}/flask-app"
    container_path = "/app"
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }

  command = [
    "bash",
    "-c",
    "pip install flask prometheus-flask-exporter && python /app/run.py"
  ]
}

# -----------------
# PROMETHEUS
# -----------------
resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = "prom/prometheus"

  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    host_path      = "${path.module}/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}

# -----------------
# GRAFANA
# -----------------
resource "docker_container" "grafana" {
  name  = "grafana"
  image = "grafana/grafana"

  ports {
    internal = 3000
    external = 3000
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}

# -----------------
# NODE EXPORTER
# -----------------
resource "docker_container" "node_exporter" {
  name  = "node_exporter"
  image = "prom/node-exporter"

  ports {
    internal = 9100
    external = 9100
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}

