#!/bin/bash
# http://www.gulliver77.org
# Description : Archive un r  pertoire
# puis le copie dans la cle usb SAUVEGARDE avec rsync
# le 28/11/2017
#######################
## toutes les conneris que je veux
if [[ condition ]]; then
	#statements
fi


#### VARIABLES SAUVEGARDE ####
USB=/media/$USER/SAUVEGARDE
OPTION_S="-dirtoq --exclude=.* --include=*.mp3 --log-file="$USB/rsync.log""
DIRBAK_S=$USB/home-de-$USER/
SOURCE_S=$HOME/Documents/Documentations

#### VARIABLES RESTAURATION ####
USB=/media/$USER/SAUVEGARDE
OPTION_R="-dirtoq --exclude=.* --include=*.mp3 --log-file="$USB/rsync.log""
SOURCE_R=$USB/home-de-$USER/
DIRBAK_R=$HOME/Documents/Restauration

#### VERIFICATION DE L ENVIRONEMENT DE TRAVAIL ####
# Check si le support USB est branché
test -e $USB/
if [ "$?" != "0" ]; then
	echo "La clé $USB n'est pas branchée."
	exit 1
fi

# Check si rsync est installé
dpkg -s  rsync | grep -q Status
if [ "$?" != "0" ]; then
		echo " Le logiciel rsync n'est pas installé."
		exit 1
fi

###### INTERFACE GRAPHIQUE ###############

fichtemp=`tempfile 2>/dev/null` || fichtemp=/tmp/test$$
### Set a trap which, on shell error or shell exit, deletes a temporary file xyz$$.
trap "rm -f $fichtemp" 0 1 2 5 15


dialog --title " Sauvegarde-Restauration" \
        --menu "Gestion des sauvegardes et des restaurations  " 20 61 6 \
	 "1" "Sauvegarde du dossier utilisateur" \
	 "2" "Restauration de données" \
	 "3" "Quitter l'application" 2> $fichtemp

valret=$?
choix=`cat $fichtemp`
case $valret in
  0)
    echo "choix n°'$choix' " ;;
  1)
    exit 0 ;;
  255)
    echo "Box closed." ;;
esac


### MAIN MENU   ####################
# ------------------------
if [ $choix = "1" ] ; then
	rsync $OPTION_S $SOURCE_S $DIRBAK_S
elif [ $choix = "2" ] ; then
	rsync $OPTION_R $SOURCE_R $DIRBAK_R
elif [ $choix = "3" ] ; then
	exit 0
fi
