terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
    }
}

provider "docker" {}

resource "docker_image" "imagen" {
    name = "${var.nombre_imagen}:${var.version_imagen}"
}

resource "docker_container" "contenedor" {
    name = "mi_contenedor"
    image = docker_image.imagen.latest
    connection {
        type     = "ssh"
        host     = self.ip_address
        user     = "root"
        password = "root"
        port     = 22
    }
    
    provisioner "remote-exec" {
        inline = ["echo ${self.ip_address} >> miip.txt"]
    }
    
    provisioner "remote-exec" {
        script      = "./miscript.sh"
        on_failure  = continue
        # when        = destroy
    }
    # provisioner "remote-exec" {
    #     script = ["echo ${self.ip_address} >> miip.txt"]
    #     on_failure = continue
    #     when = destroy
    # }
}
