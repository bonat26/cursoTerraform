
output "direccion_ip" {
    value = aws_instance.mi-maquina.public_ip
}

output "disco" {
    #value = aws_instance.mi-maquina.root_block_device[0].volume_size
    value = [ for disco in aws_instance.mi-maquina.root_block_device : disco.volume_size ]
}

