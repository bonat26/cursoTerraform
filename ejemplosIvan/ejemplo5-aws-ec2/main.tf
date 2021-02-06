
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

module "maquina" {
    source           = "./instancia"
    ami              = "ami-0176d5cc50152c509"
    nombre_instancia = "instancia-Ivan"
}
