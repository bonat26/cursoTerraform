
variable "nombre_imagen" {
    description = "Nombre de la imagen que voy a descargar"
    type        = string
    default     = "nginx"
}

variable "version_imagen" {
    description = "Versión de la imagen que voy a descargar"
    type        = string
    default     = "latest"
}

variable "contenedores" {
    description = "Contendores nginx"
    type        = map(string)
    default     = {
        contenedorA  = "8090"
        contenedorB  = "8091"
    }
}

variable "contenedores_muy_diferentes" {
    description = "Contendores nginx"
    type        = map(map(string))
    default     = {
        VERDE  = {
            puerto         = 8090    
            host_path      = "/home/ubuntu/environment/cursoTerraform"
            container_path = "/cursoTerraform"
        }
        AMARILLO  = {
            puerto         = 8091  
            container_path = "/ivan"
            host_path      = "/home/ubuntu/environment/ivan"
        }
    }
}

variable "nombre_contenedores" {
    description = "Contendores nginx"
    type        = list(string)
    default     = [ "Rojo", "Azul" ]
}

variable "lista_contenedores" {
    description = "Contendores nginx"
    type        = list(map(string))
    default     = [
        {
            nombre      = "ListaA"
            puerto      = "9090"
        },
        {
            nombre      = "ListaB"
            puerto      = "9091"
        }
    ]
}