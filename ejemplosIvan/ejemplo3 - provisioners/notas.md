

DEVOPS 

# Infraestructura

Jenkins | TravisCI, Bamboo, AzureDevops

Terraform
    Alquilar un servidor Redhat en Amazon

Vagrant
    Generar maquinas virtuales en automatico 
        10 maquinas virtuales
            3 - Centos
            6 - Windows
            1 - Redhat

Ansible     <<<<<    Puppet | Chef
    Tomar ese servidor y:
        Crear usuarios
        Crear grupos de usuarios
        Configurar politicas SELinux
        Reglar firewall
        Instalar software
        
    Beats
        AuditBeat
        WinlogBeat
        Filebeat
    
Kafka > Logstash > Elastic < Kibana
    Stack ELK
                                    <<< Prometheus + Grafana
