

	# Borrar tabla NAT y RST contadores
	iptables -t nat -F
	iptables -t nat -Z

	
	# Traducción de direcciones y puertos de la red Privada a la Dirección IP pública del router 
	iptables -t nat -A POSTROUTING -s 10.0.0.0/22 -j SNAT --to-source 100.0.1.100


	# Borrar la tabla filter
	iptables -F
	iptables -Z


	#Políticas por defecto
	iptables -t filter -P INPUT DROP
	iptables -t filter -P FORWARD DROP
	iptables -t filter -P OUTPUT ACCEPT


	#Permitir el tráfico dirigido al firewall desde la red interna
	iptables -t filter -A INPUT -s 10.0.0.0/22 -j ACCEPT


	# Permitir el tráfico saliente de la red interna
	iptables -t filter -A FORWARD -i eth0 -o eth2 -j ACCEPT 
	# Permitir el reenvio de paquetes entrantes que pertenezcan a conexiones ya existentes
	iptables -t filter -A FORWARD -i eth2 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT


	# Permitir conexiones entrantes a los puertos 13 y 7
	iptables -t filter -A FORWARD -d 100.0.0.40 -s ! 10.0.0.0/22 -p udp --dport 7 -j ACCEPT
	iptables -t filter -A FORWARD -d 100.0.0.50 -s ! 10.0.0.0/22 -p udp --dport 13 -j ACCEPT	


	# Permitir únicamente conexión telnet entre P1 y PC5 desde PC1 (Red interna)
	iptables -t filter -A FORWARD -s 10.0.0.10 -d 100.0.0.50 -p tcp --dport 23 -j ACCEPT 	
	iptables -t filter -A FORWARD -s 100.0.0.50 -d 10.0.0.10 -p tcp --sport 23 -m state --state RELATED,ESTABLISHED -j ACCEPT
	

	# Permitir únicamente la conexión al servidor de echo desde PC1 a PC4 al puerto 7 TCP servidor de echo
	iptables -t filter -A FORWARD -s 10.0.0.10 -d 100.0.0.40 -p tcp --dport 7 -j ACCEPT 	
	iptables -t filter -A FORWARD -s 100.0.0.50 -d 10.0.0.10 -p tcp --sport 7 -m state --state RELATED,ESTABLISHED -j ACCEPT



