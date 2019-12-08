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
i=0
win="#AA#"
db="/tmp/data.db"
s="CDEHIJ BBBGGG"
c='s/.* #/#/;s#\(.\)\([0-9]*\)#s/\1/e[\2m  /g;#g; #100A102B104F105G103_49-49$49'
m='sS.*#SS;sSaSU;p;g;p;sUSg;sSbS\\(.....Sg;sScS\\(....Sg;sSdS_.....\\)Sg;sSeS\\)Sg;sSfS_U_Sg;sS\([1-3]\)S\\\1Sg#sU.* UU;sUBbeBUC1CU;sUBbeBUD1DU;sUBbeBUE1EU;sUGUHU;sUGUIU;sUGUJU;h;p;sU__ceAAceAAUAA1AA2__aAA_\(...eAAfAA1_AAaAAceAAce[_-][_-]U__1AA2AAa_AA\(...e_AAUAA_1AA_aAAceAAce__ce--U__1__2AA3AAa_AA\(...e_AA\(...e--U___1AA_2AAaAA_\(...eAA_ce--U___1_AA2AAa_beBbeBUB1B2_aB_ceBfB1_BaBbeBbef1B2Ba_Bce_BUB_1B_a_be_beBbeBUB1B2_3_aBbeBbe_bef1_2B3Ba_beCbeCUC1C2_aC_ceCfC1_CaCbeCbef1C2Ca_Cce_CUC_1C_a_be_beCbeCUC1C2_3_aCbeCbe_bef1_2C3Ca_beDbeDUD1D2_aD_ceDfD1_DaDbeDbef1D2Da_Dce_DUD_1D_a_be_beDbeDUD1D2_3_aDbeDbe_bef1_2D3Da_beEbeEUE1E2_aE_ceEfE1_EaEbeEbef1E2Ea_Ece_EUE_1E_a_be_beEbeEUE1E2_3_aEbeEbe_bef1_2E3Ea__ceFFUFF1__aFFfFFaFFce_f_1FFa_FFUFF_a__FFUFF__aFF_f_FFa_beGUG1_aGfGaGbef1Ga_GUG_a_bdGUG1_aGbdf1Ga__beGUG_1_aG_bef_1Ga_Gcef_1Ga__ceGU_G1_aG_f_Ga__GUG__aGce_f1G_a_ceG_UG1__aGbe_f1_Ga_be_GUG1__a_beHUH1_aHfHaHbef1Ha_HUH_a_bdHUH1_aHbdf1Ha__beHUH_1_aH_bef_1Ha_Hcef_1Ha__ceHU_H1_aH_f_Ha__HUH__aHce_f1H_a_ceH_UH1__aHbe_f1_Ha_be_HUH1__a_beIUI1_aIfIaIbef1Ia_IUI_a_bdIUI1_aIbdf1Ia__beIUI_1_aI_bef_1Ia_Icef_1Ia__ceIU_I1_aI_f_Ia__IUI__aIce_f1I_a_ceI_UI1__aIbe_f1_Ia_be_IUI1__a_beJUJ1_aJfJaJbef1Ja_JUJ_a_bdJUJ1_aJbdf1Ja__beJUJ_1_aJ_bef_1Ja_Jcef_1Ja__ceJU_J1_aJ_f_Ja__JUJ__aJce_f1J_a_ceJ_UJ1__aJbe_f1_Ja_be_JUJ1__U;p'
m=$(sed "$m" <<< "$m")

case "$1" in
  solve)
    # Initialize database
    echo "0 # $(tr -cd 'A-J#_-' <<< $start | tr $s)" > $db
    until grep -q "$win" $db; do # Are we there yet?
      l=$(( i++ ))
      echo -n "### $i: "
      # Try all moves on the new board patterns | keep those who make a change
      (cat $db ; grep "^$l " $db | sed -n "$m" | tr $s | awk '{a=$0;getline;if(a!=$0){print '$i',a,$0}}') | sort -uk3,3 > ${db}r
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
sort -rnk1 < $db | awk '/'$win'/{if(!p){p=$2;print $1,$3}}{if($3==p){print $1,p;p=$2}}' | rev | sed 'y/ /\n/;s/\(#....#\)/\n\1/g' | tac | rev | sed "$(sed "$c" <<< $c)" | tr 'e' '\033'
