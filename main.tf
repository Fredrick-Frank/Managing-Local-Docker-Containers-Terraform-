terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"   #define docker provider
      version = "~> 3.0"
    }
  }
}

provider "docker" {}


resource "docker_network" "app_network" { #add docker network
  name = "app_network"
}


resource "docker_container" "web" { #Deploy an Nginx container that serves web traffic.
  name  = "web_server"
  image = "nginx:latest"

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.app_network.name
  }
}

resource "docker_image" "mysql" { #Set up a MySQL container with environment variables for database credentials
  name = "mysql:latest"
}

resource "docker_container" "db" {
  name  = "mysql_db"
  image = docker_image.mysql.name
  restart = "always"

  env = [
    "MYSQL_ROOT_PASSWORD=rootpassword",
    "MYSQL_DATABASE=mydb",
    "MYSQL_USER=user",
    "MYSQL_PASSWORD=userpassword"
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }
}

