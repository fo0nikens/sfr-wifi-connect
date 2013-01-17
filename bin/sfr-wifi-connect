#!/bin/bash

USER_AGENT="Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20100101 Firefox/17.0"

function param() {
  echo $1 | grep -o "$2=[^&]\+" | grep -o '[^=]\+$'
}

if [ $# -lt 2 ]
then
  echo "Usage: $(basename $0) SFR_EMAIL SFR_PASSWORD [CHECK_PERIOD]"
  exit 1;
fi

sfr_email=$1
sfr_pwd=$2
check_period=${3:-"15s"}

while true
do

echo "email=$sfr_email"
echo "password=$sfr_pwd"

login_url=$(curl -s -i \
  --user-agent "$USER_AGENT" \
  --url http://www.google.fr \
    | grep -o '^Location: https://hotspot.wifi.sfr.fr.*$' \
    | grep -o "https://.*$")

echo "login_url=$login_url"

if [ ! -z "$login_url" ]
then
  uamip=$(param $login_url uamip)
  uamport=$(param $login_url uamport)
  challenge=$(param $login_url challenge)
  nasid=$(param $login_url nasid)
  mac=$(param $login_url mac)
  mode=$(param $login_url mode)
  channel=$(param $login_url channel)

  echo "uamip=$uamip"
  echo "uamport=$uamport"
  echo "challenge=$challenge"
  echo "nasid=$nasid"
  echo "mac=$mac"
  echo "mode=$mode"
  echo "channel=$channel"

  curl -s \
    --user-agent "$USER_AGENT" \
    --cookie "autoLoginSFR=$sfr_email; langSFR=fr" \
    --url "$login_url" \
      > /dev/null

  logon_url=$(curl -s \
    --user-agent "$USER_AGENT" \
    --cookie "autoLoginSFR=$sfr_email; langSFR=fr" \
    --referer "$login_url" \
    --url https://hotspot.wifi.sfr.fr/nb4_crypt.php \
      --data-urlencode "username=$sfr_email" \
      --data-urlencode "password=$sfr_pwd" \
      --data "conditions=on" \
      --data "save=on" \
      --data "challenge=$challenge" \
      --data "accessType=neuf" \
      --data "lang=fr" \
      --data "mode=$mode" \
      --data-urlencode "userurl=http://www.google.fr" \
      --data "uamip=$uamip" \
      --data "uamport=$uamport" \
      --data "channel=$channel" \
      --data-urlencode "mac=$mac|$nasid" \
      --data "connexion=Connexion" \
        | grep -o 'window.location = "http://.\+$' \
        | grep -o 'http://[^"]\+')

  echo "logon_url=$logon_url"

  if [ ! -z "$logon_url" ]
  then
    result_url=$(curl -s -i \
      --user-agent "$USER_AGENT" \
      --url "$logon_url" \
        | grep -o '^Location: https://hotspot.wifi.sfr.fr.*$' \
        | grep -o "https://.*$")

    echo "result_url=$result_url"

    curl -s \
      --user-agent "$USER_AGENT" \
      --url "$result_url" \
        > /dev/null
  fi
fi

sleep $check_period

done

