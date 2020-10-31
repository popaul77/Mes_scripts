#!/bin/bash

########################################################################
# http://www.gulliver77.org                                            #
# Description : Synchronise un dossier                                 #
# avec un support usb ici la cle usb SAUVEGARDE                        #
# le script utilise rsync pour executer le travail                     #
# pour l'adapter a une autre configuration il faut:                    #
# Modifier la variable USB ainsi que les chemins des sauvegardes       #
# Modifier la variable options de rsync pour ladapter a vos besoin.    #
# le script gere aussi la restauration des mêmes dossiers.             #
# le 01/12/2017                                                        #
# Jean-paul pour gulliver77                                            #
# http://www.gulliver77.org                                            #
#                                                                      #
########################################################################




### Variables Generales ###
USB=/media/jpg/SAUVEGARDE

#### VARIABLES SAUVEGARDE ###
#USB=/media/$USER/SAUVEGARDE
OPTION_S="-dirtoq --exclude=.* --include=*.mp3 --log-file="$USB/rsync.log""
DIRBAK_S=$USB/home-de-$USER/
SOURCE_S=$HOME/Documents/Documentations

#### VARIABLES RESTAURATION ###
#USB=/media/$USER/SAUVEGARDE
OPTION_R="-dirtoq --exclude=.* --include=*.mp3 --log-file="$USB/rsync.log""
SOURCE_R=$USB/home-de-$USER/
DIRBAK_R=$HOME/Documents/Restauration

############ FONCTION ################
zenity(){
    /usr/bin/zenity "$@" 2>/dev/null
}

#### VERIFICATION DE L ENVIRONEMENT DE TRAVAIL ####
# Check si le support USB est branché
test -e $USB/ 
if [ "$?" != "0" ]; then
	zenity --warning \
	--text="*** La clé $USB n'est pas accessible. Brancher la bonne clé. ***"
	exit 1
fi

# Check si rsync est installé
dpkg -s  rsync | grep -q Status
if [ "$?" != "0" ]; then
		zenity --warning \
		--text="*** rsync n'est pas installé. Procedé a l'installation. ***"
		exit 1
fi

#### INTERFACE GRAPHIQUE
choix="$(zenity --width=250 --height=200 \
	--list --column "Choix" --radiolist \
	--title="Que voulez-vous faire ?" \
    --column="Action" \
    FALSE Sauvegarder. \
    FALSE Restauration.)" 2>/dev/null

##### SAUVEGARDE
save ()

if zenity --width=250 --height=200 --question --text="Procéder à la sauvegarde.\nContinuer ?"
	then
		rsync $OPTION_S $SOURCE_S $DIRBAK_S | tee >(zenity --progress --pulsate)
	else
		exit 0
fi


##### RESTAURATION
restaure ()
if zenity --width=250 --height=200 --question --text="Procéder à la restauration.\nContinuer ?"
	then
		rsync $OPTION_R $SOURCE_R $DIRBAK_R | tee >(zenity --progress --pulsate)
	else
		exit 0
fi


### MAIN MENU   ####################
# ------------------------
if [ $choix = "Sauvegarder." ] ; then
	save
elif [ $choix = "Restauration." ] ; then
	restaure
fi
