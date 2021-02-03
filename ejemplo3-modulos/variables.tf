variable "nombre_imagen" {
    description = "Nombre de la imagen que voy a descargar"
    type        = string
    default     = "rastasheep/ubuntu-sshd"
}

variable "version_imagen" {
    description = "Version de la imagen que voy a descargar"
    type        = string
    default     = "18.04"
}
