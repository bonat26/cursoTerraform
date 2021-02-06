
terraform {
    required_providers {
        aws = {
            source ="hashicorp/aws"
        }
    }
}

provider "aws" {
    profile = "default"
    region  = "eu-west-1"
}


resource "aws_instance" "mi-maquina" {
    ami           = "ami-0176d5cc50152c509"
    instance_type = "t2.micro"
    key_name      = aws_key_pair.mis_claves.key_name # Se genera la relacion de dependencia
#    key_name      = "claves_instancia_ivan"          # NO se genera la relacion de dependencia
    
    security_groups = [
        aws_security_group.reglas_red.name
    ]
    tags          = {
        Name      = "Instancia_Ivan"
    }
    
    provisioner "remote-exec" {
        inline = [
#                    "sleep 20", 
                    "sudo apt update",
#                    "sudo apt install docker -y"
                    "docker run -p 8080:80 -d nginx"
                 ]
        
        connection {
            host            = aws_instance.mi-maquina.public_ip
            type            = "ssh"  # 22
            user            = "ubuntu"
            private_key     = tls_private_key.mi_clave_privada.private_key_pem 
            timeout         = "1m"
        }
    }
    
}

# Conectar ssh
    # usuario / contraseña (clave publica/privada)
    
resource "tls_private_key" "mi_clave_privada" {
  algorithm   = "RSA"
  rsa_bits    = 4096 
}

resource "aws_key_pair" "mis_claves" {
  key_name   = "claves_instancia_ivan"
  public_key = tls_private_key.mi_clave_privada.public_key_openssh
}


resource "aws_security_group" "reglas_red" {
    name    = "reglas_red_ivan"
    description    = "Permitir acceso a la maquinas"
    
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port = 8080
        to_port   = 8080
        protocol  = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}


output "clave_privada" {
    value = tls_private_key.mi_clave_privada.private_key_pem 
}
output "clave_publica" {
    value = tls_private_key.mi_clave_privada.public_key_pem 
}

