variable "ami" {
    description = "Ami"
    type        = string
}

variable "tipo_instancia" {
    description = "Tipo de instancia de la maquina que voy a generar"
    type        = string
    default     = "t2.micro"
}

variable "nombre_maquina" {
    description = "Nombre de la maquina que voy a levantar"
    type        = string
}
