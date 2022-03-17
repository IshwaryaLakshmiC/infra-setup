if [ "\`wget http://example.org/ -O /dev/null -S --quiet 2>&1 | grep '200 OK'\`" != "" ]; 
then 
   echo 'Running fine'; 
fi;
