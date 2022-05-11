#!/bin/sh
#Met en place les clé gpg dans /etc/apt/trusted.d/
#Remplace apt-key-add deprecated


name=""
url=""

read -p "Quel est le nom du projet ? " name
read -p "Où est l'URL de la clé GPG (à ajouter pour l'outil apt) ? " url

curl -fsSL "${url}" | gpg --dearmor | tee /usr/share/keyrings/"${name}".gpg > /dev/null

status="$?"

if [ "${status}" -eq 0 ]; then
	printf '%s : %s\n' "OK" "La clé GPG pour le projet '${name}' a bien été ajoutée."
else
	printf '%s : %s\n' "KO" "Il semble y avoir un soucis pour ajouter la clé GPG du projet '${name}' !"
	exit 0
fi
