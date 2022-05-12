#!/bin/sh
#Met en place les clé gpg dans /usr/share/keyrings/
#Remplace apt-key-add (deprecated)
# https://stackoverflow.com/questions/68992799/warning-apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-d-instead
#Il faut modifier le chemin dans le source.list concerné pour que apt
#prenne en compte la clé gpg en question
#ex:[arch=amd64 signed-by=/usr/share/keyrings/opera.gpg]
#arch=amd64 n'est pas obligatoire.

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
fi

## https://explainshell.com/explain?cmd=curl+-fsSL+example.org
## https://explainshell.com/gpg
