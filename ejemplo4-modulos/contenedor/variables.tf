variable "nombre_imagen" {
    description = "Nombre de la imagen que voy a descargar"
    type        = string
}

variable "version_imagen" {
    description = "Version de la imagen que voy a descargar"
    type        = string
    default     = "latest"
}

variable "nombre_contenedor" {
    description = "Nombre del contenedor"
    type        = string
    validation {
        condition       = length(var.nombre_contenedor) > 4
        error_message   = "Debe de suministrar un nombre de contendor con al menos 5 caracteres."
    }
}

variable "puertos_contenedor" {
    description = "Puerto del contenedor"
    type        = list(map(string))
    # type        = list(object({
    #                 interno = number
    #                 externo = number
    #                 protocolo = string
    #                 }))
}
