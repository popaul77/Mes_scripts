#!/bin/bash

## Ensemble de fonction pour rechercher des fichier dans l'arboressence.
# Utilisons find voir son man (/-size)

Chercher dans un dossier (/tmp)
find /tmp
find  . (recherche dans le dossier courrant)

find . -name "nom du fichier rechercher"
find . -name "*.ogg"
find . -iname "nom du fichier rechercher sans la case"
find . -iname "Mon-Fichier.JPEG"
find . -iname "*csv*"
find . -type f -iname "*csv*"
find . -type d -iname "*csv*"

jpg@MyDell:~/test$ find . -name "*.txt*"
./Sid.txt
./Fichier1.txt
./Fichier2.txt
./Buster.txt

jpg@MyDell:~/test$ find . -type d -name "*ori*"
./original-images



Chercher par taille de Fichier
find /boot -size +10M
find /boot -size +10M -size -30M

jpg@MyDell:~/test$ find /boot -size +30M -size -50M -exec ls -lh {} \;
-rw-r--r-- 1 root root 40M févr. 11 16:47 /boot/initrd.img-4.19.0-14-amd64
-rw-r--r-- 1 root root 40M déc.   6 16:17 /boot/initrd.img-4.19.0-13-amd64


Chercher par date (-atime -ctime -mtime)(acces, creation, modification)
  find . -atime -30
  find . -ctime 0
  find . -mtime +90

jpg@MyDell:~/test$ touch test.txt
jpg@MyDell:~/test$ find . -atime -1
./test.txt


Chercher en minute (-amin -cmin -mmin)(acces, creation, modification)

jpg@MyDell:~/test$ find . -amin -1
./test.txt


Chercher par utilisateur
  find /tmp -user jpg
  find /tmp -uid 1000
  find /tmp -gid mongroupe

jpg@MyDell:~/test$ find /tmp -user jpg 2>/dev/null
/tmp/hsperfdata_jpg
/tmp/atom-916a9df93ae2.sock
/tmp/Atom Crashes



Chercher et executer une commande via find
  find . -name "*txt" -user jpg -exec rm -i {} \; (supprime les fichier.txt trouvé par find)
  find . -name "*txt" -user jpg -exec ls -lh {} \; (liste les fichier.txt trouvé par find avec leurs poids)
  find . -name "*txt" -user jpg -exec ls -lh {} \; 2> /dev/null

Chercher les fichiers vide
  find /tmp -empty 2> /dev/null
  find /tmp -type d -empty 2> /dev/null

jpg@MyDell:~/test$ find . -empty 2> /dev/null
./Fichier1.txt
./test.txt
./Fichier2.txt
./create-optimize-images
jpg@MyDell:~/test$ find . -type d -empty 2> /dev/null
./create-optimize-images


Chercher en fonction des permissions des dossiers/fichiers
  find /tmp -type f -perm 777
  find /tmp -type f ! -perm 777
  find /bin -perm 4755 -exec ls -l {} \; (cherche les fichiers aux permissions etendues)
  find /bin -perm /u=s -exec ls -l {} \;

  jpg@MyDell:~/test$ find /bin -perm 4755 -exec ls -l {} \;
  -rwsr-xr-x 1 root root 34888 janv. 10  2019 /bin/umount
  -rwsr-xr-x 1 root root 63568 janv. 10  2019 /bin/su
  -rwsr-xr-x 1 root root 154352 mars  22  2019 /bin/ntfs-3g
  -rwsr-xr-x 1 root root 51280 janv. 10  2019 /bin/mount
  -rwsr-xr-x 1 root root 34896 avril 22  2020 /bin/fusermount


  find /bin -perm /o=x -exec ls -l {} \;
  find /bin -type l -perm /o=x -exec ls -l {} \;

  jpg@MyDell:~/test$ find /bin -type l -perm /o=x -exec ls -l {} \;
lrwxrwxrwx 1 root root 4 janv. 14  2020 /bin/ping4 -> ping
lrwxrwxrwx 1 root root 8 sept. 27  2018 /bin/dnsdomainname -> hostname
lrwxrwxrwx 1 root root 20 oct.  24 20:44 /bin/systemd -> /lib/systemd/systemd
lrwxrwxrwx 1 root root 8 sept. 27  2018 /bin/nisdomainname -> hostname
