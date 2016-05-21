#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
echo $$ > "/var/run/autoblock.pid"      #save PID in a file for daemon.sh

while true ; do                         #endless loop to run this all the time
  acttime="$(LANG=de_DE date +%H%M)"    #get actual system time in 24H format
  actday="$(LANG=us_US date +%A)"       #get actual system weekday in english
  source ab.conf                        #read in the config file
  counter1=0
  declare -a checkIP=( )

  start=${actday:0:3}_start             #just get the first 3 letters of weekday and add _start
  end=${actday:0:3}_end                 #same with _end
  start=${start,,}                      #make everything small
  end=${end,,}                          #same with end time
  start=${!start}                       #set the start time of unblock from config file
  end=${!end}                           #set the end time of unblock from config file

  for i in "${IP[@]}" ; do              #loop to run for every IP adress set
    counter1=$((counter1+1))            #counter +1
    checkIP["$counter1"]=$(ufw status | grep "$i" | cut -c40-49 )                         #check if IPs are blocked
    if [[ "$(( 10#$acttime ))" -gt "$start" && "$(( 10#$acttime ))" -lt "$end" ]];  then  #if where are inside of the time zone block IPs
      if [ -z "${checkIP[$counter1]}" ]; then                                             #if string is empty
        continue                                                                          #go on without doing anything
      else
        ufw delete deny from "$i"                                                         #delete in ufw the rules for blocking IPs
      fi
    fi
    if [[ "$(( 10#$acttime ))" -lt "$start" || "$(( 10#$acttime ))" -gt "$end" ]];  then  #if where are outside of the time zone block IPs
      if [ -z "${checkIP[$counter1]}" ]; then                                             #if string is empty
        ufw deny from "$i"                                                                #write new rules for blocking IPs
      fi
    fi
  done
  sleep 60                              #sleep timer to wait
done

exit 0
