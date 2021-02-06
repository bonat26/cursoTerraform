terraform {
    required_providers {
        docker = {
            #  He actualizado el repo del provider de docker
            source = "kreuzwerker/docker"
        }
    }
}


module "nginx" {
    source              = "./contenedor"
    nombre_imagen       = "nginx"
    nombre_contenedor   = "mi-nginx"
    puertos             = var.puertos_nginx
# Puertos: 
    #  - Puede exponer varios puertos
    #  - Para cada puerto que exponga, voy a dar también el puerto en el que lo mapeo
    # 80  http  -> 8080
    # 443 https -> 8081
    #puertos             = [ [80,8080], [443,8081 ]]
    #puertos             = { "80" = "8080", "443" = "8081"}
   }

module "apache" {
    source              = "./contenedor"
    nombre_imagen       = "httpd"
    version_imagen      = "2.4.46"
    nombre_contenedor   = "mi-apache"
    puertos             = [
                            {
                              interno = 80
                              externo = 8081
                              protocolo = "tcp"
                            },
                            {
                              interno = 443
                              externo = 8444
                              protocolo = "tcp"
                            }
                        ]
}
