#!/bin/sh

# ########   Cars: (use lower-case if placed vertically!)
# #______#
# #______#   AAA  BBB  CCC  DDD
# #______-
# #______#   GG HH II JJ KK LL
# #______#
# #______#   MM NN OO PP QQ RR
# ########

start="
########
#HH___d#
#a__b_d#
#aRRb_d-
#a__b__#
#g___JJ#
#g_CCC_#
########
"
win="#.......R.......#"

moves='h;p;s/AAA_/_AAA/;p;g;p;s/_AAA/AAA_/;p;g;p;s/_\(.......\)a\(.......\)a\(.......\)a/a\1a\2a\3_/;p;g;p;s/a\(.......\)a\(.......\)a\(.......\)_/_\1a\2a\3a/;p;g;p;s/BBB_/_BBB/;p;g;p;s/_BBB/BBB_/;p;g;p;s/_\(.......\)b\(.......\)b\(.......\)b/b\1b\2b\3_/;p;g;p;s/b\(.......\)b\(.......\)b\(.......\)_/_\1b\2b\3b/;p;g;p;s/CCC_/_CCC/;p;g;p;s/_CCC/CCC_/;p;g;p;s/_\(.......\)c\(.......\)c\(.......\)c/c\1c\2c\3_/;p;g;p;s/c\(.......\)c\(.......\)c\(.......\)_/_\1c\2c\3c/;p;g;p;s/DDD_/_DDD/;p;g;p;s/_DDD/DDD_/;p;g;p;s/_\(.......\)d\(.......\)d\(.......\)d/d\1d\2d\3_/;p;g;p;s/d\(.......\)d\(.......\)d\(.......\)_/_\1d\2d\3d/;p;g;p;s/GG_/_GG/;p;g;p;s/_GG/GG_/;p;g;p;s/_\(.......\)g\(.......\)g/g\1g\2_/;p;g;p;s/g\(.......\)g\(.......\)_/_\1g\2g/;p;g;p;s/HH_/_HH/;p;g;p;s/_HH/HH_/;p;g;p;s/_\(.......\)h\(.......\)h/h\1h\2_/;p;g;p;s/h\(.......\)h\(.......\)_/_\1h\2h/;p;g;p;s/II_/_II/;p;g;p;s/_II/II_/;p;g;p;s/_\(.......\)i\(.......\)i/i\1i\2_/;p;g;p;s/i\(.......\)i\(.......\)_/_\1i\2i/;p;g;p;s/JJ_/_JJ/;p;g;p;s/_JJ/JJ_/;p;g;p;s/_\(.......\)j\(.......\)j/j\1j\2_/;p;g;p;s/j\(.......\)j\(.......\)_/_\1j\2j/;p;g;p;s/KK_/_KK/;p;g;p;s/_KK/KK_/;p;g;p;s/_\(.......\)k\(.......\)k/k\1k\2_/;p;g;p;s/k\(.......\)k\(.......\)_/_\1k\2k/;p;g;p;s/LL_/_LL/;p;g;p;s/_LL/LL_/;p;g;p;s/_\(.......\)l\(.......\)l/l\1l\2_/;p;g;p;s/l\(.......\)l\(.......\)_/_\1l\2l/;p;g;p;s/MM_/_MM/;p;g;p;s/_MM/MM_/;p;g;p;s/_\(.......\)m\(.......\)m/m\1m\2_/;p;g;p;s/m\(.......\)m\(.......\)_/_\1m\2m/;p;g;p;s/NN_/_NN/;p;g;p;s/_NN/NN_/;p;g;p;s/_\(.......\)n\(.......\)n/n\1n\2_/;p;g;p;s/n\(.......\)n\(.......\)_/_\1n\2n/;p;g;p;s/OO_/_OO/;p;g;p;s/_OO/OO_/;p;g;p;s/_\(.......\)o\(.......\)o/o\1o\2_/;p;g;p;s/o\(.......\)o\(.......\)_/_\1o\2o/;p;g;p;s/PP_/_PP/;p;g;p;s/_PP/PP_/;p;g;p;s/_\(.......\)p\(.......\)p/p\1p\2_/;p;g;p;s/p\(.......\)p\(.......\)_/_\1p\2p/;p;g;p;s/QQ_/_QQ/;p;g;p;s/_QQ/QQ_/;p;g;p;s/_\(.......\)q\(.......\)q/q\1q\2_/;p;g;p;s/q\(.......\)q\(.......\)_/_\1q\2q/;p;g;p;s/RR[-_]/_RR/;p;g;p;s/[-_]RR/RR_/;p;g;p;s/[-_]\(.......\)r\(.......\)r/r\1r\2_/;p;g;p;s/r\(.......\)r\(.......\)[-_]/_\1r\2r/;p;g;'

db="/tmp/rush.db"
td="/tmp/trush.db"
tr="/tmp/trush.res"
sbf=4G # Sort Buffer Size

case "$1" in
  solve)
    # Initialize data
    echo "0 Start $(echo $start|tr -cd 'A-Ra-r#_-')" > $db 

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
until (echo $b | grep ^0 > /dev/null); do
  # Print board
  echo $b | cut -d' ' -f1
  echo $b | cut -d' ' -f3 | sed 's/\(........\)/\1\n/g'
  # Find source of this board
  b=$(grep -- "$(grep -- "$b\$" $db | cut -d' ' -f2)\$" $db)
done
echo 0
echo $start | tr -cd 'A-Ra-r#_-' | sed 's/\(........\)/\1\n/g'
