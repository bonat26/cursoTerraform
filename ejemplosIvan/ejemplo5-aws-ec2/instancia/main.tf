
resource "aws_instance" "mi-maquina" {
    ami           = var.ami
    instance_type = var.tipo_instancia
    tags          = {
        Name      = var.nombre_instancia
    }
}