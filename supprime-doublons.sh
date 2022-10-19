#!/bin/bash

FICHIER=doublons-tri.txt
DOUBLONS="$(cat $FICHIER | sort | uniq -d)"
if [ "$DOUBLONS" != "" ]; then
for line in $(seq 1 $(echo "$DOUBLONS" | wc -l)); do
TXTASUPPRIMER=$(echo "$DOUBLONS" | sed $line!d)
LIGNESASUPPRIMER=$(grep -n "$TXTASUPPRIMER" $FICHIER | sed -e 1d -e 's/\([0-9]*\):.*/-e \1d/')
sed $LIGNESASUPPRIMER -i $FICHIER
done
fi
