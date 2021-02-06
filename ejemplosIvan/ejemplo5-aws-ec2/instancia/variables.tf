
variable "nombre_instancia" {
    description = "Nombre de la instancia que voy a generar"
    type        = string
}

variable "tipo_instancia" {
    description = "Tipo de instancia que voy a generar"
    type        = string
    default     = "t2.micro"
#    sensitive   = True
}

variable "ami" {
    description = "Nombre de la imagen que voy a instalar"
    type        = string
}
