output "ip_privada" {
    value = aws_instance.mi-maquina.private_ip
}

output "ip_publica" {
    value = aws_instance.mi-maquina.public_ip
}

output "tamano_disco" {
    value = [for disco in aws_instance.mi-maquina.root_block_device : disco.volume_size]
}
