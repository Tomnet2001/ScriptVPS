#!/bin/bash

#Actualizar 

apt-get update -y
apt-get upgrade -y
clear
echo "INSTALANDO SCRIPT CONTROLADOR"
sleep 2s

#Instalar Nano
apt-get install nano -y

#Instalar Apache2
apt-get install apache2 -y

#Instalar Squad3
apt-get install squad3 -y

#Instalar Dropbear
apt-get install dropbear -y


#Configurando Dropbear

cd /etc/default/dropbear

echo 'NO_START=0' >>/etc/default/dropbear
echo 'DROPBEAR_EXTRA_ARGS="-p 90 -p 53"' >>/etc/default/dropbear
echo 'DROPBEAR_BANNER="/etc/dropbear/banner"' >>/etc/default/dropbear
echo 'DROPBEAR_RECEIVE_WINDOW=65536' >>/etc/default/dropbear

service dropbear start

cd /etc/ssh/
echo "Port 443" >> /etc/ssh/sshd_config

service ssh restart

#Fin de la configuracion del Dropbear

#Configurando Squad3
echo "DIRIGE SU IP: "
read ip 

echo "http_port 80" > /etc/squid3/squid.conf
echo "http_port 8080" > /etc/squid3/squid.conf
echo "http_port 3128" > /etc/squid3/squid.conf
echo "http_port 8799" >> /etc/squid3/squid.conf
echo "acl accept url_regex -i $ip" >> /etc/squid3/squid.conf
echo "acl y url_regex -i claro" >> /etc/squid3/squid.conf
echo "acl y1 url_regex -i .com.br" >> /etc/squid3/squid.conf
echo "acl all src 0.0.0.0/0.0.0.0" >> /etc/squid3/squid.conf
echo "http_access allow accept" >> /etc/squid3/squid.conf
echo "http_access allow y" >> /etc/squid3/squid.conf
echo "http_access allow y1" >> /etc/squid3/squid.conf
echo "http_access deny all" >> /etc/squid3/squid.conf

service ssh restart
service squid3 restart
#Fin de configuracion del Squad3
		
echo "Procedimiento realizado con exito. Crear un usuario y teste para ver si está funcionando corretamente!"
echo "Puertos configurados: "
echo "Squad3: 80 8080 3128 8799"
echo "Dropbear: 90 53"
echo "Sshd: 443"
read [Enter]

sleep 2s 
cd 
rm configvps.sh
