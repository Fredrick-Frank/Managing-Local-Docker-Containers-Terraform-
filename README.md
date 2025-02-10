Terraform Project: Managing Local Docker Containers On Prem! 

***This project simply illustrates how to deploy docker containers without using cloud platform***

Steps: 
1. Install Prerequisites ------ Install terraform & docker on the OS
2. Initialize terraform project ----------- mkdir terraform-docker-project && cd terraform-docker-project
3. touch main.tf ---------------- this is the terraform configuration file (it is where the providers are added)
4. Define the docker provider(s) ------------- for this project I used "kreuzwerker/docker"
5. Create a docker network
6. Define a web server (Nginx) container
7. Deploy a database (Mysql) container
8. Initialize and apply the terraform configuration file (main.tf)

Basic commands: 
* terraform init ------------- initialize terraform to download providers
* terraform validate ------------------- validate the configuration file
* terraform apply --auto-approve ----------------------- apply terraform config to deploy the containers.
* terraform destroy -auto-approve ---------------------- to destory the infrastructure.


***To scale up the web server to a replica of 2:***
resource "docker_container" "web" {
  count = 2
  name  = "web_server-${count.index}"
  image = "nginx:latest"

  ports {
    internal = 80
    external = 8080 + count.index
  }

  networks_advanced {
    name = docker_network.app_network.name
  }
}

