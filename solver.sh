#!/bin/bash

start="
######  Klotski/huarong dao solver           Usage:   
#BAAC#                                       solver.sh solve|show
#BAAC#  Would probably be quicker if it        solve:
#DFFE#  was written in a proper language.        Solve and show result
#DGHE#                                         show:
#I__J#  jonst@nsc.liu.se                         Show result from
##--##                                           previous run
"
win="#AA#"

m='s/.* //;h;p;s/[-_][-_]\(....\)AA\(....\)AA/AA\1AA\2__/;p;g;p;s/AA_\(...\)AA_/_AA\1_AA/;p;g;p;s/AA\(....\)AA\(....\)[_-][_-]/__\1AA\2AA/;p;g;p;s/_AA\(...\)_AA/AA_\1AA_/;p;g;p;s/_\(.....\)B\(.....\)B/B\1B\2_/;p;g;p;s/B_\(....\)B_/_B\1_B/;p;g;p;s/B\(.....\)B\(.....\)_/_\1B\2B/;p;g;p;s/_B\(....\)_B/B_\1B_/;p;g;p;s/_\(.....\)C\(.....\)C/C\1C\2_/;p;g;p;s/C_\(....\)C_/_C\1_C/;p;g;p;s/C\(.....\)C\(.....\)_/_\1C\2C/;p;g;p;s/_C\(....\)_C/C_\1C_/;p;g;p;s/_\(.....\)D\(.....\)D/D\1D\2_/;p;g;p;s/D_\(....\)D_/_D\1_D/;p;g;p;s/D\(.....\)D\(.....\)_/_\1D\2D/;p;g;p;s/_D\(....\)_D/D_\1D_/;p;g;p;s/_\(.....\)E\(.....\)E/E\1E\2_/;p;g;p;s/E_\(....\)E_/_E\1_E/;p;g;p;s/E\(.....\)E\(.....\)_/_\1E\2E/;p;g;p;s/_E\(....\)_E/E_\1E_/;p;g;p;s/__\(....\)FF/FF\1__/;p;g;p;s/FF_/_FF/;p;g;p;s/FF\(....\)__/__\1FF/;p;g;p;s/_FF/FF_/;p;g;p;s/_\(.....\)G/G\1_/;p;g;p;s/G_/_G/;p;g;p;s/G\(.....\)_/_\1G/;p;g;p;s/_G/G_/;p;g;p;s/_\(.....\)H/H\1_/;p;g;p;s/H_/_H/;p;g;p;s/H\(.....\)_/_\1H/;p;g;p;s/_H/H_/;p;g;p;s/_\(.....\)I/I\1_/;p;g;p;s/I_/_I/;p;g;p;s/I\(.....\)_/_\1I/;p;g;p;s/_I/I_/;p;g;p;s/_\(.....\)J/J\1_/;p;g;p;s/J_/_J/;p;g;p;s/J\(.....\)_/_\1J/;p;g;p;s/_J/J_/;p'

db="/tmp/data.db"
sbf=4G # Sort Buffer Size

case "$1" in
  solve)
    # Initialize data
    echo "0 Start $(echo $start|tr -cd 'A-J#_-')" > $db 
    echo "" > ${db}t

    i=0
    until grep "$win" ${db}t > /dev/null; do # Are we there yet?
      l=$(( i++ ))
      echo -n "### $i: "
      # Try all moves on the new board patterns | keep those who make a change
      grep "^$l " $db | sed -n "$m" | awk '{a=$0;getline;b=$0;if(a!=b){print '$i',a,b}}' > ${db}t
      if [ \! -s ${db}t ];then echo "No new moves?";exit 255;fi
      # Save only results that doesn't already exist in db 
      cat $db ${db}t | sort -S$sbf -u -k3,3 | sort -S$sbf -n -k1 > ${db}r
      mv -f ${db}r $db

      # Show db size (Just to see if anything is happening)
      wc -c $db | cut -d' ' -f1
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
f='/'$win'/{if(!p){p=$2;print $1,$3}}{if($3==p){print $1,p;p=$2}}'
tac $db | awk $f | rev | sed 'y/ /\n/;s/\(#....#\)/\n\1/g' | tac | rev
