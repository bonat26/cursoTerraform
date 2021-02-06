terraform {
    required_providers {
        docker = {
            #  He actualizado el repo del provider de docker
            source = "kreuzwerker/docker"
        }
    }
}

provider "docker" { }

/*
    Me estoy creando un contenedor
*/
resource "docker_container" "contenedor-ubuntu" {
  name  = "mi_contenedor_ubuntu"
  image = docker_image.imagen-ubuntu.latest
  command = ["bash","-c","sleep 600"]
  
  dynamic "volumes" {
    for_each = var.volumenes
    content {
        volume_name    = contains( keys(volumes.value), "volume_name") ? volumes.value["volume_name"] : null
        # volume_name    = lookup(volumes.value, "volume_name", null)
        host_path      = volumes.value["host_path"]
        container_path = volumes.value["container_path"]
    }
  }
  
}

resource "docker_image" "imagen-ubuntu" {
//  OJO, tomo el último UBUNTU ¿?
#  name = "ubuntu:21.04"
#  name = var.nombre_imagen
  name = "${var.nombre_imagen}:${var.version_imagen}"
}

