#!/bin/bash
while true
 do
  events=`mysql -uroot -prootpassword -h10.0.0.75 --silent -e "SELECT count(*) FROM eventuate.events;" 2>nul`
  entities=`mysql -uroot -prootpassword -h10.0.0.75 --silent -e "SELECT count(*) FROM eventuate.entities;" 2>nul`
  documents=`mongo test.perf.com/customers_and_orders --quiet --eval "db.customerView.count()"`
  if [ ! -f counts.csv ];
   then touch counts.csv;
    echo Timetamp,Events,Entities,Documents | tee -a counts.csv;
  fi
  echo "$(date +"%Y-%m-%d %T")","${events//[!0-9]/}","${entities//[!0-9]/}",$documents | tee -a counts.csv
  sleep $1
 done
