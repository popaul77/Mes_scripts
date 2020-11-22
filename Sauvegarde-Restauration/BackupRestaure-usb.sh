#!/bin/bash
# http://www.gulliver77.org
# Description : Archive un r  pertoire
# puis le copie dans la cle usb SAUVEGARDE avec rsync
# le 28/11/2017
# Le 07/11/2020 modification du texte pour essai github de sublim-texte et sublime-merge
#######################

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

#### MAIN ###############################################
# cas 1 SAUVEGARDE
sauvegarde ()

#verifie si la cle est branchée
if [ ! -d $USB ]
	then
		echo  "Dernier avertissement !!! branches ta clé de sauvegarde !!!!"
		exit 0
	else

		if dpkg -s rsync | grep -q Status #verifie si le logiciel rsync est installé
			then
        		rsync $OPTION_S $SOURCE_S $DIRBAK_S #Copie rsync dans la cle sauvegarde
		else
			echo "rsync est necessaire pour réaliser cette operation"
			exit 0

		fi
fi


# Cas 2 RESTAURATION
restauration ()

#verifie si la cle est branchée
if [ ! -d $USB ]
	then
		echo  "Sans la clé ça va pas bien fonctionner cette restauration !!!"
		exit 0

	else

#verifie si le logiciel rsync est installé
		if dpkg -s rsync | grep -q Status
			then
	        	rsync $OPTION_R $SOURCE_R $DIRBAK_R #Restauration rsync vers le disque dur

			else
				echo "rsync est necessaire pour réaliser cette operation"
				exit 0

		fi

fi

### MAIN MENU   ####################
# ------------------------
if [ $choix = "1" ] ; then
	sauvegarde
elif [ $choix = "2" ] ; then
	restauration
elif [ $choix = "3" ] ; then
	exit 0
fi
