variable "nombre_imagen" {
    description = "Nombre de la imagen que voy a descargar"
    type        = string
    default     = "nginx"
}

variable "version_imagen" {
    description = "Version de la imagen que voy a descargar"
    type        = string
    default     = "stable-perl"
}

# variable "contenedores" {
#     description = "Contenedores Nginx"
#     type = map(map(string))
#     default = {
#         nginx_1 = {
#             puerto          = "8080"
#             host_path       = "/home/ubuntu/environment/cursoTerraform"
#             container_path  = "/cursoTerraform"
#         },
#         nginx_2 = {
#             puerto          = "8081"
#             host_path       = "/home/ubuntu/environment/ivan"
#             container_path  = "/ivan"
#         }
#     }
# }

# variable "contenedores" {
#     description = "Contenedores Nginx"
#     type = list(string)
#     default = ["nginx_a", "nginx_b"]
# }

variable "contenedores" {
    description = "Contendores nginx"
    type        = list(map(string))
    default     = [
        {
            nombre          = "contenedorA"
            puerto          = "8080"
            host_path       = "/home/ubuntu/environment/cursoTerraform"
            container_path  = "/cursoTerraform"
        },
        {
            nombre          = "contenedorB"
            puerto          = "8081"
            host_path       = "/home/ubuntu/environment/ivan"
            container_path  = "/ivan"
        }
    ]
}