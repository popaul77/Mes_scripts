#!/bin/bash

PROCESS="${@}"

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
