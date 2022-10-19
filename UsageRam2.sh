#!/bin/bash

## A tester avec la ligne suivante
## ps -ely |grep -v kworker |grep -v $$ |tr -s ' ' |cut -d " " -f3 |xargs UsageRam2.sh --pid
## Permet de trouver quel est le processus qui consomme le plus

OPTION=${1}
PROCESS="${@:2}" ## process commence au parametre n° 2

if [[ ${OPTION} = "--service" ]]
then
    if [[ -z ${PROCESS} ]]
    then
      echo "Vous devez donner un nom de processus ou de service en parametre"
    else
        for EXPRESSION in $(echo ${PROCESS})
            do
                RAMUSAGE=$(ps -ely |awk -v process=${EXPRESSION} '$13 == process' | awk '{ SUM += $8/1024 } END { print SUM }' | cut -d "." -f1)
    ## ps -ely | awk '$13 == "atom"' |awk '{SUM += $8/1024} END {print SUM}' |cut -d "." -f1
    ## ps -ely | awk -v process=$PROCESS '$13 == process'
                if [[ -z ${RAMUSAGE} ]]
                then
                    echo "Le processus ${EXPRESSION} n'éxiste pas."
                else
                    echo "RAM consommée pour ${EXPRESSION} : ${RAMUSAGE} MB"
                fi
            done
    fi

elif [[ ${OPTION} = "--pid" ]]
then
    if [[ -z ${PROCESS} ]]
    then
      echo "Vous devez donner le numèro d'un ou plusieurs pid en parametre."
    else
        for EXPRESSION in $(echo ${PROCESS})
            do
                RAMUSAGE=$(ps -ely |awk -v pid=${EXPRESSION} '$3 == pid' | awk '{ SUM += $8/1024 } END { print SUM }' | cut -d "." -f1)
    ## ps -ely | awk '$13 == "atom"' |awk '{SUM += $8/1024} END {print SUM}' |cut -d "." -f1
    ## ps -ely | awk -v process=$PROCESS '$13 == process'
                SERVICE=$(ps -ely |awk -v pid=${EXPRESSION} '$3 == pid' | awk '{print $13}')
                if [[ -z ${RAMUSAGE} ]]
                then
                    echo "Le pid ${EXPRESSION} n'éxiste pas."
                else
                    echo "RAM consommée pour le pid ${EXPRESSION} (${SERVICE}) : ${RAMUSAGE} MB"
                fi
            done
    fi
else
    echo "Vous devez indiquer comme premier parametre --service ou --pid"
fi
