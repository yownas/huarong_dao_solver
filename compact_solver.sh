#!/bin/bash

start=" Klotski/huarong dao solver
######                                           Usage:
#BAAC#  https://en.wikipedia.org/wiki/Klotski    solver.sh solve|show
#BAAC#                                             solve:
#DFFE#  Would probably be quicker if it              Solve and show result
#DGHE#  was written in a proper language.          show:
#I__J#                                               show result from
##--##  jonst@nsc.liu.se                             previous run
"
w=#AA#
cm='sA^.*#AA;sSaSU;p;g;p;sUSg;sSbS\\(.....Sg;sScS\\(....Sg;sSdS_.....\\)Sg;sSeS\\)Sg;sSfS_U_Sg;sS\([1-3]\)S\\\1Sg#sU.* UU;h;p;sU__ceAAceAAUAA1AA2__aAA_\(...eAAfAA1_AAaAAceAAce[_-][_-]U__1AA2AAa_AA\(...e_AAUAA_1AA_aAAceAAce__ce--U__1__2AA3AAa_AA\(...e_AA\(...e--U___1AA_2AAaAA_\(...eAA_ce--U___1_AA2AAa_beBbeBUB1B2_aB_ceBfB1_BaBbeBbef1B2Ba_Bce_BUB_1B_a_be_beBbeBUB1B2_3_aBbeBbe_bef1_2B3Ba_beCbeCUC1C2_aC_ceCfC1_CaCbeCbef1C2Ca_Cce_CUC_1C_a_be_beCbeCUC1C2_3_aCbeCbe_bef1_2C3Ca_beDbeDUD1D2_aD_ceDfD1_DaDbeDbef1D2Da_Dce_DUD_1D_a_be_beDbeDUD1D2_3_aDbeDbe_bef1_2D3Da_beEbeEUE1E2_aE_ceEfE1_EaEbeEbef1E2Ea_Ece_EUE_1E_a_be_beEbeEUE1E2_3_aEbeEbe_bef1_2E3Ea__ceFFUFF1__aFFfFFaFFce_f_1FFa_FFUFF_a__FFUFF__aFF_f_FFa_beGUG1_aGfGaGbef1Ga_GUG_a_bdGUG1_aGbdf1Ga__beGUG_1_aG_bef_1Ga_Gcef_1Ga__ceGU_G1_aG_f_Ga__GUG__aGce_f1_Ga_ce_GUG1__aGbe_f1_Ga_be_GUG1__a_beHUH1_aHfHaHbef1Ha_HUH_a_bdHUH1_aHbdf1Ha__beHUH_1_aH_bef_1Ha_Hcef_1Ha__ceHU_H1_aH_f_Ha__HUH__aHce_f1_Ha_ce_HUH1__aHbe_f1_Ha_be_HUH1__a_beIUI1_aIfIaIbef1Ia_IUI_a_bdIUI1_aIbdf1Ia__beIUI_1_aI_bef_1Ia_Icef_1Ia__ceIU_I1_aI_f_Ia__IUI__aIce_f1_Ia_ce_IUI1__aIbe_f1_Ia_be_IUI1__a_beJUJ1_aJfJaJbef1Ja_JUJ_a_bdJUJ1_aJbdf1Ja__beJUJ_1_aJ_bef_1Ja_Jcef_1Ja__ceJU_J1_aJ_f_Ja__JUJ__aJce_f1_Ja_ce_JUJ1__aJbe_f1_Ja_be_JUJ1__U;p'
db=/dev/shm/data.db
s=4G # Sort Buffer Size

case "$1" in
  solve)
    echo "0 Start $(echo $start|tr -cd 'A-J#_-')" > $db
    m=$(echo "$cm"|sed "$cm")
    until grep -q $w $db; do # Are we there yet?
      l=$(( i++ ))
      echo -n "### $i: ";date -Is
      (cat $db;grep "^$l " $db | sed -n "$m" | awk '{a=$0;getline;if(a!=$0){print '$i',a,$0}}') | sort -S$s -uk3,3 | sort -S$s -nk1 > ${db}t
      mv ${db}t $db
    done
    ;;
  show)
    # Do not remove this. Very important.
    ;;
  *)
    echo "$0 solve|show"
    exit
esac
echo "Solution:"
tac $db | awk '/'$w'/{if(!p){p=$2;print $1,$3}}{if($3==p){print $1,p;p=$2}}' | rev | sed 'y/ /\n/;s/\(#....#\)/\n\1/g' | tac | rev
