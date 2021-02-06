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
resource "docker_container" "contenedor" {
  name  = "mi_contenedor"
  image = docker_image.imagen.latest
  
  # local-exec.  remote-exec.    file
  provisioner "local-exec" {
    command = "echo ${self.ip_address} >> miip.txt"
#    command = "ansible-playbook -f XXX  ${self.ip_address} "
  }
  connection {
    type      = "ssh" # winrm
    host      = self.ip_address
    user      = "root"
    password  = "root"
    port      = 22
  }
  provisioner "remote-exec" {
    inline     = [ "echo ${self.ip_address} >> miip.txt" , "echo ADIOS" ]
  }
  provisioner "remote-exec" {
    script     = "./miscript.sh"
#    scripts     = ["./miscript.sh" , ]
    on_failure = continue
#    when       = destroy
  }
}


resource "docker_image" "imagen" {
  name = "${var.nombre_imagen}:${var.version_imagen}"
}
