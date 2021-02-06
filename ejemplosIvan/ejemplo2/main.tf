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
resource "docker_container" "contenedor-nginx-solo" {
  name  = "mi_contenedor_nginx"
  image = docker_image.imagen-nginx.latest
  ports {
    internal = 80
    external = 8085
  }
}

resource "docker_container" "contenedores-nginx-iguales" {
  count = 3
  name  = "mi_contenedor_nginx_${count.index}"
  image = docker_image.imagen-nginx.latest
  ports {
    internal = 80
    external = 8080 + count.index
  }
}


resource "docker_container" "contenedores-nginx-diferentes" {
  for_each = var.contenedores
  # La variable each me da: each.key y un each.value
  name  = each.key
  image = docker_image.imagen-nginx.latest
  ports {
    internal = 80
    external = each.value 
  }
}


resource "docker_container" "contenedores-nginx-muy-diferentes" {
  for_each = var.contenedores_muy_diferentes
  # La variable each me da: each.key y un each.value
  name  = each.key
  image = docker_image.imagen-nginx.latest
  ports {
    internal = 80
    external = each.value["puerto"]
  }
  volumes {
    host_path      = each.value["host_path"]
    container_path = each.value["container_path"]
  }
}


resource "docker_container" "contenedores-nginx-diferentes-nombres" {
  for_each = toset(var.nombre_contenedores)
  # La variable each me da: each.key y un each.value
  name  = each.key
  image = docker_image.imagen-nginx.latest
}


resource "docker_container" "contenedores-nginx-lista" {
  count = length(var.lista_contenedores)
  name  = var.lista_contenedores[count.index]["nombre"]
  image = docker_image.imagen-nginx.latest
  ports {
    internal = 80
    external = var.lista_contenedores[count.index].puerto
  }
}


resource "docker_image" "imagen-nginx" {
  name = "${var.nombre_imagen}:${var.version_imagen}"
}
