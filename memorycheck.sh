#!/bin/bash
SCRIPTNAME=`basename $0`

export LOCKSYNC="$dirlock/$SCRIPTNAME.lock"
PID=$$
echo "["$(date +"%Y/%m/%d %H:%M:%S")"] Trying to launch script $0"
if [ -f "$LOCKSYNC" ]
then
        echo "Wait: lockfile "$LOCKSYNC" is present. we must verify..."
        PIDLOCK=`cat $LOCKSYNC`
        if [ -f /proc/$PIDLOCK/exe ]
        then
                echo "The process is currently running. Launching $SCRIPTNAME aborted."
                exit
        else
                echo "The process isn't currently running anymore. Launching $SCRIPTNAME..."
                rm $LOCKSYNC
        fi
fi
echo "Lockingfile creation... "$LOCKSYNC
echo $PID > $LOCKSYNC

date=$(date)
log="/root/memoryclean.log"
memorythreshold=80

function restart()
{
/etc/init.d/php5.6-fpm reload
}

check=$(free | awk 'FNR == 2 {print 100-(($2-$3)/$2)*100}' |cut -d "." -f1)

if [[ "$check" -gt "$memorythreshold" ]]

then
    echo "Problem detected"
    restart
    echo "$date" >> $log
else
    echo "All is OK"
fi
