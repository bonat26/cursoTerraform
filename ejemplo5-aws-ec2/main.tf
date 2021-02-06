terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }    
}

provider "aws" {
    profile = "default"
    region = "eu-west-1"
}

module "maquina-ec2" {
    source = "./maquina-ec2"
    
    ami = "ami-0176d5cc50152c509"
    nombre_maquina = "Bonat-EC2"
}
    