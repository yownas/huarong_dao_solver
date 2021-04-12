#!/bin/bash

######  Klotski/huarong dao solver
#BAAC#  <- Solves this setup in 81 steps
#BAAC#
#DFFE#  Would probably be quicker if it
#DGHE#  was written in a proper language.
#I__J#  jonst@nsc.liu.se
##--##

w="#AA#";d="/tmp/data.db";s="C-J BBBFG";c='s/.* #/#/;s#\(.\)\([0-9]*\)#s/\1/\x'\
'1b[\2m  /g;#g; #100A102B104F105G103_49-49$49';m='s/^.* #v//;s/x/wUw/g;s/w/\\1'\
'/g;s/v/\/g;s\//g; #vs/^.* #//;s/a\([BCDE]\)/a5w5x7wefwtw6wbw0w5w5kwewaw8_x_7w'\
'i5lw5x7wow5wrw\\3wv5\([GHIJ]\)/5xnw6w0w5kwaxi9xnw9kwalx_nwljwaw8jwatwU_wnw_6_'\
'wa_x_fw8_kwi8w_Uwbfw5_6bwa5_xbvu/FFvt/_8vr/5l6bevq/B5BUvo/e_\\3fvn/b0vm/U;sUv'\
'l/_5vk/67vi/_avj/6_7vf/_0ve/\\2vd/\\(...\\)vc/AAvb/7_va/0_v9/\\(....._.4v8/\\'\
'(4v7/\wv6/_U_v5/\\(.4v4/....\\)v0/U;p;g;p;sU/g; #sU.* UmqC7CmqD7DmqE7EmGUHmGU'\
'ImGUJU;h;p;sU_tc8cUc7ce_fc_dc6cbc0c8c8[_-][_-]U__7cecacd_cUc_7cfc8c8_t--U__b_'\
'ec\3cacd_cd--U___7c_ec0c_dct--U___bcecaBaCaDaEatuUubfu6u0u8_juauUui_uUu_fu_6_'\
'ua5Gi5Hi5Ii5J_U;p';m=$(sed "$(sed "$m"<<<"$m")"<<<"$m")
echo "0 # $(awk '/^#[^!]/{printf $1}' $0|tr $s)">$d
until grep -q $w $d;do echo $((i++));(cat $d;grep ^$((--i))" " $d|sed -n "$m"|\
tr $s|awk '{a=$0;getline;if(a!=$0)print '$i',a,$0}')>$d.;sort -uk3 $d.>$d;done
echo Solution:;sort -rn $d|awk -v p=$w '(index($3,p)){print $1,$3;p=$2}'|rev|\
sed 'y/ /\n/;s/\(#....#\)/\n\1/g'|tac|rev|sed "$(sed "$c"<<<$c)"
