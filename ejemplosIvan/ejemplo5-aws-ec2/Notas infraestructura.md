Outsourcing
------------------------
Infraestructura
    Los cloud tienen ZONAS GEOGRAFICAS
        Latencia
        LEY DE PROTECCION DE DATOS
Contratación de hardware
    Máquinas    EC2
        Configuración : RAM, CPUs, GPUs... 
            No son tan a la carta: Modelos CIENTOS
            S.O.   <<<< IMAGEN BASE (SO + software)
                Redhat + Openshift
                    Tenemos un catálogo de imágenes
    Servicios Web, BBDD, Mensajería, Serv. Aplicaciones: RED PUERTO
        Rutas acceso a servicios de la red privada desde Internet
            IP(publica):puerto
    Entorno de producción: Cluster: Aplicación => Sistemas 
        1 aplicación - 5 servidores 
    Balanceador de carga: HTTP: nginx, apache
    Servidor Web (PROXY)
    Firewall
    Almacenamiento
    Red Virtuales     
        Entrada desde Internet
