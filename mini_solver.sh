#!/bin/bash

######  Klotski/huarong dao solver
#BAAC#
#BAAC#  Would probably be quicker if it
#DFFE#  was written in a proper language.
#DGHE#
#I__J#  jonst@nsc.liu.se
##--##

w="#AA#";d="/tmp/data.db"; s="CDEHIJ BBBGGG"; c='s/.* #/#/;s#\(.\)\([0-9]*\)#s/\1/e[\2m  /g;#g; #100A102B104F105G103_49-49$49'
m='s/^.* #v//;s/x/\\1/g;s/w/\\2/g;s/v/\/g;s\//g; #vs/^.* #//;s/a\([BCDE]\)/a5x5xUx7xefxtx6xbx0x5x5kxexax8_xUx_7xi5lx5xUx7xox5xrx\\3xv\([^Um]\)\([GHIJ]\)/xwUwnw6w0w5kwawUwi9wUwnw9kwalwUw_nwljwaw8jwatwU_wnw_6_wa_wUw_fw8_kwi8w_Uwbfw5_6bwa5_wUwbvu/FFvt/_8vr/5l6bevq/B5BUvo/e_\\3fvn/b0vm/U;sUvl/_5vk/67vi/_avj/6_7vf/_0ve/\wvd/\\(...\\)vc/AAvb/7_va/0_v9/\\(....._.4v8/\\(4v7/\xv6/_U_v5/\\(.4v4/....\\)v0/U;p;g;p;sU/g; #sU.* UmqC7CmqD7DmqE7EmGUHmGUImGUJU;h;p;sU_tc8cUc7ce_fc_dc6cbc0c8c8[_-][_-]U__7cecacd_cUc_7cfc8c8_t--U__b_ec\3cacd_cd--U___7c_ec0c_dct--U___bcecaBaCaDaEatuUubfu6u0u8_juauUui_uUu_fu_6_ua5Gi5Hi5Ii5J_U;p'
m=$(sed "$(sed "$m" <<< "$m")" <<< "$m")

echo "$(( i++ )) # $(awk '/^#[^ !]/{printf $1}' $0 | tr $s)" > $d
until grep -q "$w" $d; do
  (cat $d ; grep "^$(( --i ))" $d | sed -n "$m" | tr $s | awk '{a=$0;getline;if(a!=$0){print '$i',a,$0}}') > $d.; sort -uk3 $d. > $d; echo $(( i++ ))
done

echo Solution:
sort -rn $d | awk -v p=$w '(index($3,p)){print $1,$3;p=$2}' | rev | sed 'y/ /\n/;s/\(#....#\)/\n\1/g' | tac | rev | sed "$(sed "$c" <<< $c)" | tr 'e' '\033'
