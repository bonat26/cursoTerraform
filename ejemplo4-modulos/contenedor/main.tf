terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
    }
}

provider "docker" {}

resource "docker_container" "contenedor" {
    name = var.nombre_contenedor
    image = docker_image.imagen.latest
    dynamic "ports" {
        for_each = var.puertos_contenedor
        content {
            internal = ports.value["interno"]
            external = ports.value["externo"]
            protocol = ports.value["protocolo"]
        }
    }
}

resource "docker_image" "imagen" {
    name = "${var.nombre_imagen}:${var.version_imagen}"
}
