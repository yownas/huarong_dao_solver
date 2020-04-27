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
db="/tmp/data.db"
s="CDEHIJ BBBGGG"
c='s/.* #/#/;s#\(.\)\([0-9]*\)#s/\1/e[\2m  /g;#g; #100A102B104F105G103_49-49$49'
m='s/^.* #//;s/u/FF/g;s/t/_8/g;s/r/5l6be/g;s/q/B5BU/g;s/o/e_\\3f/g;s/n/b0/g;s/m/U;sU/g;s/l/_5/g;s/k/67/g;s/i/_a/g;s/j/6_7/g;s/f/_0/g;s/e/\\2/g;s/d/\\(...\\)/g;s/c/AA/g;s/b/7_/g;s/a/0_/g;s/9/\\(....._.4/g;s/8/\\(4/g;s/7/\\1/g;s/6/_U_/g;s/5/\\(.4/g;s/4/....\\)/g;s/0/U;p;g;p;sU/g; #sU.* UmqC7CmqD7DmqE7EmGUHmGUImGUJU;h;p;sU_tc8cUc7ce_fc_dc6cbc0c8c8[_-][_-]U__7cecacd_cUc_7cfc8c8_t--U__b_ec\3cacd_cd--U___7c_ec0c_dct--U___bceca5qB7BefBtB6BbB0B5B5kBeBaB8_BUB_7Bi5lqB7BoB5BrB\3Ba5C5CUC7CefCtC6CbC0C5C5kCeCaC8_CUC_7Ci5lC5CUC7CoC5CrC\3Ca5D5DUD7DefDtD6DbD0D5D5kDeDaD8_DUD_7Di5lD5DUD7DoD5DrD\3Da5E5EUE7EefEtE6EbE0E5E5kEeEaE8_EUE_7Ei5lE5EUE7EoE5ErE\3EatuUubfu6u0u8_juauUui_uUu_fu_6_ua5GUGnG6G0G5kGaGUGi9GUGnG9kGalGUG_nGljGaG8jGatGU_GnG_6_Ga_GUG_fG8_kGi8G_UGbfG5_6bGa5_GUGbi5HUHnH6H0H5kHaHUHi9HUHnH9kHalHUH_nHljHaH8jHatHU_HnH_6_Ha_HUH_fH8_kHi8H_UHbfH5_6bHa5_HUHbi5IUInI6I0I5kIaIUIi9IUInI9kIalIUI_nIljIaI8jIatIU_InI_6_Ia_IUI_fI8_kIi8I_UIbfI5_6bIa5_IUIbi5JUJnJ6J0J5kJaJUJi9JUJnJ9kJalJUJ_nJljJaJ8jJatJU_JnJ_6_Ja_JUJ_fJ8_kJi8J_UJbfJ5_6bJa5_JUJb_U;p'
m=$(sed "$m" <<< "$m")

case "$1" in
  solve)
    # Initialize database
    echo "0 # $(tr -cd A-J#_- <<< $start | tr $s)" > $db
    until grep -q "$win" $db; do # Are we there yet?
      echo -n "### $(( ++i )): "
      # Try all moves on the new board patterns | keep those who make a change
      (cat $db ; grep "^$(( --i )) " $db | sed -n "$m" | tr $s | awk '{a=$0;getline;if(a!=$0){print '$i',a,$0}}') | sort -uk3 > ${db}r
      mv -f ${db}r $db

      # Show db size (Just to see if anything is happening)
      wc -l < $db
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
sort -rnk1 < $db | awk -v p=$win '(index($3,p)){print $1,$3;p=$2}' | rev | sed 'y/ /\n/;s/\(#....#\)/\n\1/g' | tac | rev | sed "$(sed "$c" <<< $c)" | tr 'e' '\033'
