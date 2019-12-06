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

m='s/.* //;s/B\(.....\)B/C\1C/;s/B\(.....\)B/D\1D/;s/B\(.....\)B/E\1E/;s/G/H/;s/G/I/;s/G/J/;h;p;s/__\(....\)AA\(....\)AA/AA\1AA\2__/;p;g;p;s/AA_\(...\)AA_/_AA\1_AA/;p;g;p;s/AA\(....\)AA\(....\)[_-][_-]/__\1AA\2AA/;p;g;p;s/_AA\(...\)_AA/AA_\1AA_/;p;g;p;s/AA\(....\)AA\(....\)__\(....\)--/__\1__\2AA\3AA/;p;g;p;s/_AA\(...\)_AA\(...\)--/___\1AA_\2AA/;p;g;p;s/AA_\(...\)AA_\(....\)--/___\1_AA\2AA/;p;g;p;s/_\(.....\)B\(.....\)B/B\1B\2_/;p;g;p;s/B_\(....\)B_/_B\1_B/;p;g;p;s/B\(.....\)B\(.....\)_/_\1B\2B/;p;g;p;s/_B\(....\)_B/B_\1B_/;p;g;p;s/_\(.....\)_\(.....\)B\(.....\)B/B\1B\2_\3_/;p;g;p;s/B\(.....\)B\(.....\)_\(.....\)_/_\1_\2B\3B/;p;g;p;s/_\(.....\)C\(.....\)C/C\1C\2_/;p;g;p;s/C_\(....\)C_/_C\1_C/;p;g;p;s/C\(.....\)C\(.....\)_/_\1C\2C/;p;g;p;s/_C\(....\)_C/C_\1C_/;p;g;p;s/_\(.....\)_\(.....\)C\(.....\)C/C\1C\2_\3_/;p;g;p;s/C\(.....\)C\(.....\)_\(.....\)_/_\1_\2C\3C/;p;g;p;s/_\(.....\)D\(.....\)D/D\1D\2_/;p;g;p;s/D_\(....\)D_/_D\1_D/;p;g;p;s/D\(.....\)D\(.....\)_/_\1D\2D/;p;g;p;s/_D\(....\)_D/D_\1D_/;p;g;p;s/_\(.....\)_\(.....\)D\(.....\)D/D\1D\2_\3_/;p;g;p;s/D\(.....\)D\(.....\)_\(.....\)_/_\1_\2D\3D/;p;g;p;s/_\(.....\)E\(.....\)E/E\1E\2_/;p;g;p;s/E_\(....\)E_/_E\1_E/;p;g;p;s/E\(.....\)E\(.....\)_/_\1E\2E/;p;g;p;s/_E\(....\)_E/E_\1E_/;p;g;p;s/_\(.....\)_\(.....\)E\(.....\)E/E\1E\2_\3_/;p;g;p;s/E\(.....\)E\(.....\)_\(.....\)_/_\1_\2E\3E/;p;g;p;s/__\(....\)FF/FF\1__/;p;g;p;s/FF_/_FF/;p;g;p;s/FF\(....\)__/__\1FF/;p;g;p;s/_FF/FF_/;p;g;p;s/__FF/FF__/;p;g;p;s/FF__/__FF/;p;g;p;s/_\(.....\)G/G\1_/;p;g;p;s/G_/_G/;p;g;p;s/G\(.....\)_/_\1G/;p;g;p;s/_G/G_/;p;g;p;s/_\(....._.....\)G/G\1_/;p;g;p;s/G\(....._.....\)_/_\1G/;p;g;p;s/__\(.....\)G/G_\1_/;p;g;p;s/G_\(.....\)_/__\1G/;p;g;p;s/_G\(....\)_/__\1G/;p;g;p;s/__\(....\)G/_G\1_/;p;g;p;s/G__/__G/;p;g;p;s/__G/G__/;p;g;p;s/G\(....\)__/_\1G_/;p;g;p;s/_\(....\)G_/G\1__/;p;g;p;s/G\(.....\)__/_\1_G/;p;g;p;s/_\(.....\)_G/G\1__/;p;g;p;s/_\(.....\)H/H\1_/;p;g;p;s/H_/_H/;p;g;p;s/H\(.....\)_/_\1H/;p;g;p;s/_H/H_/;p;g;p;s/_\(....._.....\)H/H\1_/;p;g;p;s/H\(....._.....\)_/_\1H/;p;g;p;s/__\(.....\)H/H_\1_/;p;g;p;s/H_\(.....\)_/__\1H/;p;g;p;s/_H\(....\)_/__\1H/;p;g;p;s/__\(....\)H/_H\1_/;p;g;p;s/H__/__H/;p;g;p;s/__H/H__/;p;g;p;s/H\(....\)__/_\1H_/;p;g;p;s/_\(....\)H_/H\1__/;p;g;p;s/H\(.....\)__/_\1_H/;p;g;p;s/_\(.....\)_H/H\1__/;p;g;p;s/_\(.....\)I/I\1_/;p;g;p;s/I_/_I/;p;g;p;s/I\(.....\)_/_\1I/;p;g;p;s/_I/I_/;p;g;p;s/_\(....._.....\)I/I\1_/;p;g;p;s/I\(....._.....\)_/_\1I/;p;g;p;s/__\(.....\)I/I_\1_/;p;g;p;s/I_\(.....\)_/__\1I/;p;g;p;s/_I\(....\)_/__\1I/;p;g;p;s/__\(....\)I/_I\1_/;p;g;p;s/I__/__I/;p;g;p;s/__I/I__/;p;g;p;s/I\(....\)__/_\1I_/;p;g;p;s/_\(....\)I_/I\1__/;p;g;p;s/I\(.....\)__/_\1_I/;p;g;p;s/_\(.....\)_I/I\1__/;p;g;p;s/_\(.....\)J/J\1_/;p;g;p;s/J_/_J/;p;g;p;s/J\(.....\)_/_\1J/;p;g;p;s/_J/J_/;p;g;p;s/_\(....._.....\)J/J\1_/;p;g;p;s/J\(....._.....\)_/_\1J/;p;g;p;s/__\(.....\)J/J_\1_/;p;g;p;s/J_\(.....\)_/__\1J/;p;g;p;s/_J\(....\)_/__\1J/;p;g;p;s/__\(....\)J/_J\1_/;p;g;p;s/J__/__J/;p;g;p;s/__J/J__/;p;g;p;s/J\(....\)__/_\1J_/;p;g;p;s/_\(....\)J_/J\1__/;p;g;p;s/J\(.....\)__/_\1_J/;p;g;p;s/_\(.....\)_J/J\1__/;p'

db="/tmp/data.db"

case "$1" in
  solve)
    # Initialize data
    (echo "0 Start $(tr -cd 'A-J#_-' <<< $start|tr CDEHIJ BBBGGG)" > $db ) > ${db}t

    i=0
    until grep -q "$win" ${db}t; do # Are we there yet?
      l=$(( i++ ))
      echo -n "### $i: "
      # Try all moves on the new board patterns | keep those who make a change
      grep "^$l " $db | sed -n "$m" | tr CDEHIJ BBBGGG | awk '{a=$0;getline;b=$0;if(a!=b){print '$i',a,b}}' > ${db}t
      if [ \! -s ${db}t ];then echo "No new moves?";exit 255;fi
      # Save only results that doesn't already exist in db 
      cat $db ${db}t | sort -uk3,3 > ${db}r
      mv -f ${db}r $db

      # Show db size (Just to see if anything is happening)
      wc -l $db
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
#sort -S$sbf -n -rk1 < $db | awk '/'$win'/{if(!p){p=$2;print $1,$3}}{if($3==p){print $1,p;p=$2}}' | rev | sed 's/B\(.....\)B/C\1C/;s/B\(.....\)B/D\1D/;s/B\(.....\)B/E\1E/;s/G/H/;s/G/I/;s/G/J/;y/ /\n/;s/\(#....#\)/\n\1/g' | tac | revi
sort -rnk1 < $db | awk '/'$win'/{if(!p){p=$2;print $1,$3}}{if($3==p){print $1,p;p=$2}}' | rev | sed 'y/ /\n/;s/\(#....#\)/\n\1/g' | tac | rev | sed 's/#/e[100m  /g;s/A/e[102m  /g;s/B/e[104m  /g;s/F/e[105m  /g;s/G/e[103m  /g;s/[_-]/e[49m  /g;s/$/e[49m/g' | tr 'e' '\033'
