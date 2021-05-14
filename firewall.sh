#!/bin/sh

iptables -F
iptables -X

# Default rules
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# lo connections are allowed
iptables -A INPUT -i lo -j ACCEPT
iptables -A FORWARD -i lo -j ACCEPT
iptables -A FORWARD -o lo -j ACCEPT

# Samba access but only in the LAN
iptables -A INPUT -s 192.168.0.0/24 -p udp -m udp --dport 137 -j ACCEPT
iptables -A INPUT -s 192.168.0.0/24 -p udp -m udp --dport 138 -j ACCEPT
iptables -A INPUT  -m state --state NEW -m tcp -p tcp -s 192.168.0.0/24 --dport 139 -j ACCEPT
iptables -A INPUT  -m state --state NEW -m tcp -p tcp -s 192.168.0.0/24 --dport 445 -j ACCEPT

# On accepte tout ce qui vient/va de la Freebox
iptables -A INPUT -s 212.27.38.253 -j ACCEPT

# We accept incoming connections on the torrent port
iptables -A INPUT -p tcp --dport 34567 -m state --state NEW -j ACCEPT

# ssh
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set --name
SSH -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m recent --update --seconds 60 --hitcount 4
 --rttl --name SSH -j DROP

# Ping
iptables -A INPUT -p icmp -m limit --limit 10/minute --limit-burst 15 -j ACCEPT
iptables -A INPUT -p icmp -j DROP


# PPTP VPN
iptables -A INPUT -j ACCEPT -p tcp --sport 1723
iptables -A INPUT -j ACCEPT -p gre

# rtsp only on LAN
iptables -A INPUT -s 192.168.0.0/24 -m tcp -p tcp --dport 554 -j ACCEPT
iptables -A INPUT -s 192.168.0.0/24 -m udp -p udp --dport 554 -j ACCEPT

# upnp A/V only on LAN
iptables -A INPUT -s 192.168.0.0/24 -m tcp -p tcp --dport 49200 -j ACCEPT
iptables -A INPUT -s 192.168.0.0/24 -m udp -p udp --dport 49200 -j ACCEPT
iptables -A INPUT -s 192.168.0.0/24 -m udp -p udp --dport 1900 -j ACCEPT

# FTP only on LAN
iptables -A INPUT  -m state --state NEW -m tcp -p tcp -s 192.168.0.0/24 --dport 21 -j ACCEPT
iptables -A INPUT  -m state --state NEW -m tcp -p tcp -s 192.168.0.0/24 --dport 20 -j ACCEPT

# We allow TCP and UDP connections already established to enter
iptables -A INPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT

echo "Use iptables-save to update /etc/firewall.conf"
