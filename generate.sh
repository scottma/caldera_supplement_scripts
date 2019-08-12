BASEDIR=~/caldera/plugins/stockpile
ABILITIESDIR=$BASEDIR/abilities/*
echo BaseDir=$BASEDIR
currentDate=`date +%m-%d-%Y_%H-%M`
sudo rm -rf $BASEDIR/adversaries/aaa*.yml

## generate for windows
loopcount=0
maxcount=50
cumulatedcount=100
phrase = 0
for Dir1 in `find $ABILITIESDIR -type d`
do
 
    if [ $cumulatedcount -gt $maxcount ]; then
        let loopcount=$(expr $loopcount + 1)
        UUID=$(cat /proc/sys/kernel/random/uuid| cut -c 4-1000)
        UUID=aaa$UUID
        OUTFILE=$BASEDIR/adversaries/$UUID.yml
        echo "" > $OUTFILE
        echo OUTFILE=$OUTFILE
        echo "- id: $UUID" >>  $OUTFILE
        echo "  name: $loopcount - All Windows Attacks $currentDate " >> $OUTFILE
        echo "  description: executing all windows attack $loopcount" >> $OUTFILE
        echo "  phases:" >> $OUTFILE
        phrase=1
        cumulatedcount=0
    fi
    echo adding $Dir1
    c=$(grep -iRl "Windows" $Dir1|wc -l)
    if [ $c -ne "0" ]; then
        echo "    $phrase:" >> $OUTFILE
        grep -iRl "Windows" $Dir1 | grep -v "c7434909-2463-47b9-be59-7c842dd9d676" | grep -v "4a4b97ad-3a88-44ee-883e-7e044832e57f" | grep -v "ecaa1a1b-e6e2-45f1-9483-feaf99bcb8af" | grep -v "1fdf3024-f54e-42b8-bfd3-25f632a172c5" | rev | cut -d"/" -f1 | rev | cut -d"." -f1 | sed 's/^/      - /'>> $OUTFILE 
        let phrase=$(expr $phrase+1)
    fi
    echo $c added.

    let cumulatedcount=$(expr $cumulatedcount + $c)
    echo cumuatedcount: $cumulatedcount

done


loopcount=0
cumulatedcount=100
for Dir1 in `find $ABILITIESDIR -type d`
do
 
    if [ $cumulatedcount -gt $maxcount ]; then
        let loopcount=$(expr $loopcount + 1)

        UUID=$(cat /proc/sys/kernel/random/uuid| cut -c 4-1000)
        UUID=aaa$UUID
        OUTFILE=$BASEDIR/adversaries/$UUID.yml
        echo OUTFILE=$OUTFILE
        echo "" > $OUTFILE
        echo "- id: $UUID" >>  $OUTFILE
        echo "  name: $loopcount - All Linux Attacks $currentDate" >> $OUTFILE
        echo "  description: executing all Linux attack $loopcount" >> $OUTFILE
        echo "  phases:" >> $OUTFILE
        phrase=1
        cumulatedcount=0
    fi

    ## generate for linux

    echo adding $Dir1
    c=$(grep -iRl "Linux" $Dir1|wc -l)
    if [ $c -ne "0" ]; then
            echo "    $phrase:" >> $OUTFILE
            grep -iRl "Linux" $Dir1 | grep -v "c7434909-2463-47b9-be59-7c842dd9d676" | grep -v "4a4b97ad-3a88-44ee-883e-7e044832e57f" | grep -v "ecaa1a1b-e6e2-45f1-9483-feaf99bcb8af" | grep -v "1fdf3024-f54e-42b8-bfd3-25f632a172c5" | rev | cut -d"/" -f1 | rev | cut -d"." -f1 | sed 's/^/      - /'>> $OUTFILE 
            let phrase=$(expr $phrase + 1)
    fi
    echo $c added.

    let cumulatedcount=$(expr $cumulatedcount + $c)
    echo cumuatedcount: $cumulatedcount
done
