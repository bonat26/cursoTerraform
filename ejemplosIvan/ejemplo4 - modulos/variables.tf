variable "puertos_nginx" {
    description = "Nombre de la imagen que voy a descargar"
    type        = list(map(string))
    default     = [
                    {
                      interno = 80
                      externo = 8085
                      protocolo = "tcp"
                    },
                    {
                      interno = 443
                      externo = 8445
                      protocolo = "tcp"
                    }
                ]
}