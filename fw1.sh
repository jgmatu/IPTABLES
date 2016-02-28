#! /bin/bash


	# Limpiar Tabla NAT
	
	iptables -t nat -F 
	iptables -t nat -Z
	


	# Traduccion de direcciones de la red privada a la dirección IP Pública del Firewall
	iptables -t nat -A POSTROUTING -s 10.0.0.0/22 -j SNAT --to-source 100.0.1.100



	#Visualización de la tabla NAT con contadores de conexión
	iptables -t nat  -L -v -n
