#!/bin/bash

function compare
{
      dossier1="$1"
      dossier2="$2"
      resultat="$3"


      while read fichier1
      do
        tee -a "${resultat}" <<< "${fichier1}"
        fichier2="${fichier1/${dossier1}/${dossier2}}"

        if [ -e "${fichier2}" ]; then
            taille1=$(stat -c%s "${fichier1}")
            taille2=$(stat -c%s "${fichier2}")

            if [ ${taille1} -ne ${taille2} ]; then
              tee -a "${resultat}" <<< "les fichiers ${fichier1} et ${fichier2} diffèrent."
              [ ! -d "${fichier2%/*}" ] && mkdir -p "${fichier2%/*}"
              cp "${fichier1}" "${fichier2}"
            fi
        else
            tee -a "${resultat}" <<< "Fichier ${fichier2} non trouvé."
            [ ! -d "${fichier2%/*}" ] && mkdir -p "${fichier2%/*}"
            cp "${fichier1}" "${fichier2}"
        fi
      done < <(find "${dossier1}" -type f)
}

[ -e "$3" ] && rm -f "$3"
compare "$1" "$2" "$3"

# au besoin, mais je ne pense pas dans ton cas :
#compare "$2" "$1" "$3"
