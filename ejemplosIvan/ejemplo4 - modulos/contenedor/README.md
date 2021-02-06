# MODULE: Contenedor

Este módulo permite crear contenedores Docker facilmente.

## Usage
``` terraform
module "nginx" {
    source              = "./contenedor"
    nombre_imagen       = "nginx"
    nombre_contenedor   = "mi-nginx"
    puertos             = var.puertos_nginx
}
```
## Requirements

Ninguno

## Providers

## Input variables

| Variable | Descripcion | Obligatorio |
|-|-|-|
|nombre_contenedor|Nombre del contenedor que voy a generar|SI|
|puertos|Puertos del contenedor a mapear|SI|
|nombre_imagen|Nombre de la imagen que voy a descargar|SI|
|version_imagen|Versión de la imagen que voy a descargar|NO|

## Outputs

- ```direccion_ip```: ***Dirección IP*** del contenedor que se genera