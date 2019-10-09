#!/bin/sh

# ######
# #BAAC#   Pieces:
# #BAAC#
# #DFFE#   AA  B  C  D  E
# #DGHE#   AA  B  C  D  E
# #I__J#
# ##--##   FF  G  H  I  J

start="
######
#BAAC#
#BAAC#
#DFFE#
#DGHE#
#_IJ_#
##--##
"
win="#AA#"

moves='h;p;s/[-_][-_]\(....\)AA\(....\)AA/AA\1AA\2__/;p;g;p;s/AA_\(...\)AA_/_AA\1_AA/;p;g;p;s/AA\(....\)AA\(....\)[_-][_-]/__\1AA\2AA/;p;g;p;s/_AA\(...\)_AA/AA_\1AA_/;p;g;p;s/_\(.....\)B\(.....\)B/B\1B\2_/;p;g;p;s/B_\(....\)B_/_B\1_B/;p;g;p;s/B\(.....\)B\(.....\)_/_\1B\2B/;p;g;p;s/_B\(....\)_B/B_\1B_/;p;g;p;s/_\(.....\)C\(.....\)C/C\1C\2_/;p;g;p;s/C_\(....\)C_/_C\1_C/;p;g;p;s/C\(.....\)C\(.....\)_/_\1C\2C/;p;g;p;s/_C\(....\)_C/C_\1C_/;p;g;p;s/_\(.....\)D\(.....\)D/D\1D\2_/;p;g;p;s/D_\(....\)D_/_D\1_D/;p;g;p;s/D\(.....\)D\(.....\)_/_\1D\2D/;p;g;p;s/_D\(....\)_D/D_\1D_/;p;g;p;s/_\(.....\)E\(.....\)E/E\1E\2_/;p;g;p;s/E_\(....\)E_/_E\1_E/;p;g;p;s/E\(.....\)E\(.....\)_/_\1E\2E/;p;g;p;s/_E\(....\)_E/E_\1E_/;p;g;p;s/__\(....\)FF/FF\1__/;p;g;p;s/FF_/_FF/;p;g;p;s/FF\(....\)__/__\1FF/;p;g;p;s/_FF/FF_/;p;g;p;s/_\(.....\)G/G\1_/;p;g;p;s/G_/_G/;p;g;p;s/G\(.....\)_/_\1G/;p;g;p;s/_G/G_/;p;g;p;s/_\(.....\)H/H\1_/;p;g;p;s/H_/_H/;p;g;p;s/H\(.....\)_/_\1H/;p;g;p;s/_H/H_/;p;g;p;s/_\(.....\)I/I\1_/;p;g;p;s/I_/_I/;p;g;p;s/I\(.....\)_/_\1I/;p;g;p;s/_I/I_/;p;g;p;s/_\(.....\)J/J\1_/;p;g;p;s/J_/_J/;p;g;p;s/J\(.....\)_/_\1J/;p;g;p;s/_J/J_/;p'

db="/tmp/data.db"
td="/tmp/temp.db"
tr="/tmp/temp.res"
sbf=4G # Sort Buffer Size

case "$1" in
  solve)
    # Initialize data
    echo "0 Start $(echo $start|tr -cd 'A-J#_-')" > $db 

    i=0
    until grep "$win" $db > /dev/null; do
      l=$i
      i=$(( $i + 1 ))
      echo -n "### $i: "
      # For all patterns in last run, try all moves | keep those who make a change
      grep "^$l " $db | cut -d' ' -f3 | sed -n $moves | awk '{a=$0;getline;b=$0;if(a!=b){print '$i',a,b}}' > $td
      if [ \! -s $td ];then echo "No new moves?";exit 255;fi
      # Save only results that doesn't already exist in db 
      cat $db $td | sort -S$sbf -u -k3,3 | sort -S$sbf -n -k1 > $tr
      mv -f $tr $db

      # Show db size (Just to see if anything is happening)
      wc -l $db | cut -d' ' -f1
    done
    ;;
  show)
    # Do not remove this. Very important.
    ;;
  *)
    echo "$0 solve|show"
    exit
esac

# Display all the steps
echo "Solution:"
b=$(grep "$win" $db|head -1)
(until (echo $b | grep ^0 > /dev/null); do
  # Print board
  echo $b | cut -d' ' -f3 | sed 's/\(......\)/\1\n/g' | tac
  echo $b | cut -d' ' -f1
  # Find source of this board
  b=$(grep -- "$(grep -- "$b\$" $db | cut -d' ' -f2)\$" $db)
done
echo;echo $start | tr -cd 'A-J#_-' | sed 's/\(......\)/\1\n/g' | tac;echo 0) | tac
