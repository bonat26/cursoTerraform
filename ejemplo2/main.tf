terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
    }
}

provider "docker" {}

resource "docker_image" "imagen-nginx" {
    name = "${var.nombre_imagen}:${var.version_imagen}"
}

# resource "docker_container" "contenedor-nginx" {
#     for_each = var.contenedores
#     name  = each.key
#     image = docker_image.imagen-nginx.latest
#     ports {
#         external = each.value["puerto"]
#         internal = 80
#     }
#     dynamic "volumes" {
#         for_each = var.contenedores
#         content {
#             host_path       = volumes.value["host_path"] 
#             container_path  = volumes.value["container_path"]
#         }
        
#     }
# }

# resource "docker_container" "contenedor-nginx" {
#     for_each = toset(var.contenedores)
#     name  = each.value
#     image = docker_image.imagen-nginx.latest
    # ports {
    #     external = each.value
    #     internal = 80
    # }
# }

resource "docker_container" "contenedor-nginx" {
    count = length(var.contenedores)
    name  = var.contenedores[count.index]["nombre"]
    image = docker_image.imagen-nginx.latest
    ports {
        external = var.contenedores[count.index]["puerto"]
        internal = 80
    }
     dynamic "volumes" {
        for_each = var.contenedores
        content {
            host_path       = var.contenedores[count.index]["host_path"] 
            container_path  = var.contenedores[count.index]["container_path"]
        }
    }
}