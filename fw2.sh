#!/bin/bash

	
	# Borrar reglas y contadores en la tabla NAT

	iptables -t nat -F
	iptables -t nat -Z


	# Apertura de puertos 

	
	# Abro el puero 5001 en el firewall para conectar con 10.0.0.10 : 5001
	iptables -t nat -A PREROUTING -i eth2 -d 100.0.1.100 -p udp --dport 5001 -j DNAT --to-destination 10.0.0.10:5001

	# Abro el puerto 5002 en el firewall para conectar cn 10.0.0.20 : 5001
	iptables -t nat -A PREROUTING -i eth2 -d 100.0.1.100 -p udp --dport 5002 -j DNAT --to-destination 10.0.0.20:5001



	# Abro el puerto 80 para PC3 puerto 80
	iptables -t nat -A PREROUTING -i eth2 -d 100.0.1.100 -p tcp --dport 80 -j DNAT --to-destination 10.0.2.30:80
