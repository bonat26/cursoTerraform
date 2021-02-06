
output "direccion_nginx" {
    value = module.nginx.direccion_ip
}
output "direccion_apache" {
    value = module.apache.direccion_ip
}
