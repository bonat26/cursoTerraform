
variable "nombre_imagen" {
    description = "Nombre de la imagen que voy a descargar"
    type        = string
    default     = "ubuntu"
}

variable "version_imagen" {
    description = "Versión de la imagen que voy a descargar"
    type        = string
    default     = "21.04"
}

variable "volumenes" {
    description = "Volumenes que vamos a montar en el contenedor"
    type        = list(map(string))
    default     = [
        {
            host_path      = "/home/ubuntu/environment/cursoTerraform"
            container_path = "/cursoTerraform"
        },
        {
            volume_name    = "vol_ivan2"
            container_path = "/ivan"
            host_path      = "/home/ubuntu/environment/ivan"
        }
    ]
}