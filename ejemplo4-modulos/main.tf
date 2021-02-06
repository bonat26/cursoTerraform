terraform {

}

module "nginx" {
    source             = "./contenedor"
    nombre_imagen      = "nginx"
    nombre_contenedor  = "mi-nginx"
    puertos_contenedor  = var.puertos_nginx
}

module "apache" {
    source             = "./contenedor"
    nombre_imagen      = "httpd"
    nombre_contenedor  = "mi-apache"
    puertos_contenedor = [
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
