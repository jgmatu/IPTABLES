#!/bin/bash

# reiniciar las tablas
iptables -t filter -F
iptables -t filter -Z
iptables -t nat -F
iptables -t nat -Z

# comportamiento por defecto
iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT ACCEPT
