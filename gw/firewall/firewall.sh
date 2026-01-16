#!/bin/bash
set -x
# Activar el IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Limpiar reglas previas
iptables -F
iptables -t nat -F
iptables -Z
iptables -t nat -Z
# ANTI-LOCK rule: Permitir ssh a través de ETH0 para acceder con vagrant
iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 22 -j ACCEPT

# POLÍTICAS POR DEFECTO
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

############################
# Reglas de protección local
############################
# 1. Permitir tráfico de loopback



#############################
# Reglas de protección de red
#############################

##### Logs para depurar
iptables -A INPUT -j LOG --log-prefix "PES-INPUT: "
iptables -A OUTPUT -j LOG --log-prefix "PES-OUTPUT: "
iptables -A FORWARD -j LOG --log-prefix "PES-FORWARD: "