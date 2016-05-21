#!/bin/bash
echo $$ > "/var/run/autoblock.pid"
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

while true ; do #endless loop to run this all the time
  acttime="$(LANG=de_DE date +%H%M)"
  actday="$(LANG=us_US date +%A)"
  source ab.conf
  counter1=0
  declare -a checkIP=( )

  start=${actday:0:3}_start
  end=${actday:0:3}_end
  start=${start,,}
  end=${end,,}
  start=${!start}
  end=${!end}

  for i in "${IP[@]}" ; do
    counter1=$((counter1+1))
    checkIP["$counter1"]=$(ufw status | grep "$i" | cut -c40-49 )
    #if where are inside of the time zone block IPs
    if [[ "$(( 10#$acttime ))" -gt "$start" && "$(( 10#$acttime ))" -lt "$end" ]];  then
      if [ "${checkIP[$counter1]}"="$i" ]; then
        if [ -z "${checkIP[$counter1]}" ]; then
          continue
        fi
        ufw delete deny from "$i"
      fi
    fi

    #if where are outside of the time zone block IPs
    if [[ "$(( 10#$acttime ))" -lt "$start" || "$(( 10#$acttime ))" -gt "$end" ]];  then
      if [ "${checkIP[$counter1]}"="$i" ]; then
        if [ -z "${checkIP[$counter1]}" ]; then
          ufw deny from "$i"
          continue
        fi
      fi
    fi
  done
  sleep 60 #sleep timer to wait
done

exit 0
