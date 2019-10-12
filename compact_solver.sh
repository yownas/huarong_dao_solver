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
w="#AA#"

cm='sA^.*#AA;sSaSU;p;g;p;sUSg;sSbS\\(\.\.\.\.\.Sg;sScS\\(\.\.\.\.Sg;sSdS_\.\.\.\.\.\\)Sg;sSeS\\)Sg;sS\([1-3]\)S\\\1Sg#sU.* UU;h;p;sU__ceAAceAAUAA1AA2__aAA_\(...eAA_U_AA1_AAaAAceAAce[_-][_-]U__1AA2AAa_AA\(...e_AAUAA_1AA_aAAceAAce__ce--U__1__2AA3AAa_AA\(...e_AA\(...e--U___1AA_2AAaAA_\(...eAA_ce--U___1_AA2AAa_beBbeBUB1B2_aB_ceB_U_B1_BaBbeBbe_U_1B2Ba_Bce_BUB_1B_a_be_beBbeBUB1B2_3_aBbeBbe_be_U_1_2B3Ba_beCbeCUC1C2_aC_ceC_U_C1_CaCbeCbe_U_1C2Ca_Cce_CUC_1C_a_be_beCbeCUC1C2_3_aCbeCbe_be_U_1_2C3Ca_beDbeDUD1D2_aD_ceD_U_D1_DaDbeDbe_U_1D2Da_Dce_DUD_1D_a_be_beDbeDUD1D2_3_aDbeDbe_be_U_1_2D3Da_beEbeEUE1E2_aE_ceE_U_E1_EaEbeEbe_U_1E2Ea_Ece_EUE_1E_a_be_beEbeEUE1E2_3_aEbeEbe_be_U_1_2E3Ea__ceFFUFF1__aFF_U_FFaFFce__U__1FFa_FFUFF_a__FFUFF__aFF__U__FFa_beGUG1_aG_U_GaGbe_U_1Ga_GUG_a_bdGUG1_aGbd_U_1Ga__beGUG_1_aG_be_U__1Ga_Gce_U__1Ga__ceGU_G1_aG__U__Ga__GUG__aGce__U_1_Ga_ce_GUG1__aGbe__U_1_Ga_be_GUG1__a_beHUH1_aH_U_HaHbe_U_1Ha_HUH_a_bdHUH1_aHbd_U_1Ha__beHUH_1_aH_be_U__1Ha_Hce_U__1Ha__ceHU_H1_aH__U__Ha__HUH__aHce__U_1_Ha_ce_HUH1__aHbe__U_1_Ha_be_HUH1__a_beIUI1_aI_U_IaIbe_U_1Ia_IUI_a_bdIUI1_aIbd_U_1Ia__beIUI_1_aI_be_U__1Ia_Ice_U__1Ia__ceIU_I1_aI__U__Ia__IUI__aIce__U_1_Ia_ce_IUI1__aIbe__U_1_Ia_be_IUI1__a_beJUJ1_aJ_U_JaJbe_U_1Ja_JUJ_a_bdJUJ1_aJbd_U_1Ja__beJUJ_1_aJ_be_U__1Ja_Jce_U__1Ja__ceJU_J1_aJ__U__Ja__JUJ__aJce__U_1_Ja_ce_JUJ1__aJbe__U_1_Ja_be_JUJ1__U;p'
m=$(echo "$cm"|sed "$cm")

db="/tmp/data.db"
s=2G # Sort Buffer Size

case "$1" in
  solve)
    # Initialize data
    (echo "0 Start $(echo $start|tr -cd 'A-J#_-')" > $db) > ${db}t
    until grep -q "$w" ${db}t; do # Are we there yet?
      l=$(( i++ ))
      echo -n "### $i: "
      # Try all moves on the new board patterns | keep those who make a change
      grep "^$l " $db | sed -n "$m" | awk '{a=$0;getline;if(a!=$0){print '$i',a,$0}}' > ${db}t
      [ -s ${db}t ] || echo "No new moves?" >&2 | false || exit 255
      # Save only results that doesn't already exist in db 
      cat $db ${db}t | sort -S$s -u -k3,3 | sort -S$s -n -k1 > ${db}r
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
f='/'$w'/{if(!p){p=$2;print $1,$3}}{if($3==p){print $1,p;p=$2}}'
tac $db | awk "$f" | rev | sed 'y/ /\n/;s/\(#....#\)/\n\1/g' | tac | rev
