
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


resource "aws_instance" "mi-sonarqube" {
    ami           = "ami-0176d5cc50152c509"
    instance_type = "t2.micro"
    key_name      = aws_key_pair.mis_claves.key_name # Se genera la relacion de dependencia
#    key_name      = "claves_instancia_ivan"          # NO se genera la relacion de dependencia
    subnet_id   = aws_subnet.my_subnet.id

    security_groups = [
        aws_security_group.reglas_red_sonarqube2.name,
        aws_security_group.reglas_red_base_ivan.name
    ]
    tags          = {
        Name      = "Instancia_Ivan_Sonarqube"
    }
    
    provisioner "remote-exec" {
        inline = [
                    "sudo sysctl -w vm.max_map_count=262144",
                    "sudo sysctl -w fs.file-max=65536",
                    "docker run -p 9000:9000 -e SONARQUBE_JDBC_URL=jdbc:postgresql://${aws_instance.mi-postgresql.private_ip}:5432/sonar  -e SONARQUBE_JDBC_USERNAME=sonar -e SONARQUBE_JDBC_PASSWORD=sonar -d sonarqube"
                 ]
        
        connection {
            host            = aws_instance.mi-sonarqube.public_ip
            type            = "ssh"  # 22
            user            = "ubuntu"
            private_key     = tls_private_key.mi_clave_privada.private_key_pem 
            timeout         = "1m"
        }
    }
    
}
resource "aws_instance" "mi-postgresql" {
    ami           = "ami-0176d5cc50152c509"
    instance_type = "t2.micro"
    key_name      = aws_key_pair.mis_claves.key_name # Se genera la relacion de dependencia
#    key_name      = "claves_instancia_ivan"          # NO se genera la relacion de dependencia
    subnet_id   = aws_subnet.my_subnet.id

    security_groups = [
        aws_security_group.reglas_red_postgresql.name,
        aws_security_group.reglas_red_base_ivan.name
        ]
    tags          = {
        Name      = "Instancia_Ivan_PostgreSQL"
    }
    
    provisioner "remote-exec" {
        inline = [
                    "docker run -p 5432:5432 -e POSTGRES_USER=sonar  -e SONARQUBE_JDBC_USERNAME=sonar -e POSTGRES_PASSWORD=sonar -d postgres"
                 ]
        
        connection {
            host            = aws_instance.mi-postgresql.public_ip
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
  key_name   = "claves_instancia_ivan2"
  public_key = tls_private_key.mi_clave_privada.public_key_openssh
}


resource "aws_security_group" "reglas_red_sonarqube2" {
    name    = "reglas_red_sonarqube2"
    description    = "Permitir acceso a la maquinas"
      vpc_id            = aws_vpc.mi_red.id

    ingress {
        from_port = 9000
        to_port   = 9000
        protocol  = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_vpc" "mi_red" {
  cidr_block = "172.16.10.0/24"
}
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.mi_red.id
  cidr_block        = "172.16.10.0/24"
#  availability_zone = "eu-west-1"
}
resource "aws_security_group" "reglas_red_postgresql" {
    name    = "reglas_red_postgresql"
    description    = "Permitir acceso a la maquinas"
      vpc_id            = aws_vpc.mi_red.id

    ingress {
        from_port = 5432
        to_port   = 5432
        protocol  = "tcp"
        cidr_blocks = [ aws_vpc.mi_red.cidr_block ]
    }
}

resource "aws_security_group" "reglas_red_base_ivan" {
    name    = "reglas_red_base_ivan"
    description    = "Permitir acceso a la maquinas"
      vpc_id            = aws_vpc.mi_red.id

    ingress {
        from_port = 22
        to_port   = 22
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

