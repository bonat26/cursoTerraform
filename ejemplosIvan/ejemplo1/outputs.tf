
output "direccion_ip" {
    value = docker_container.contenedor-ubuntu.ip_address
}

output "id" {
    value = docker_container.contenedor-ubuntu.id
}

output "labels" {
    value = docker_container.contenedor-ubuntu.labels
}