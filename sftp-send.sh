#! /bin/bash

if [[ "$1" == "help" ]]
then
	echo "Utilisation sftp-send.sh USER PASS HOST FICHIER"
	exit 0
fi

if [[ $# -ne 4 ]]
then
	echo "Toutes les options n'ont pas été passées correctement"
	exit 40
fi

SFUSER=$1
SFPASS=$2
SFHOST=$3
SFFILE=$4

if [[ $(ping -c 1 -W 1 $SFHOST | grep -c "time=") -eq 0 ]]
then
	echo "Le serveur $SFHOST ne répond pas"
	exit 41
fi

if [[ -f $SFFILE ]]
then
	sshpass -p $SFPASS sftp $SFUSER@$SFHOST << ENDSFTP
	cd data
	put $SFFILE
	exit
ENDSFTP
else
	echo "Le fichier $SFFILE n'existe pas"
fi
