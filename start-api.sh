echo -n "Feature build: " 
read feature

#Check exist folder
FEATURE_DIR="lib/features/$feature"

restart_server(){
  #Go to directory
  cd $FEATURE_DIR

  exec sudo kill $(ps aux | grep '[s]am' | awk '{print $2}') &
  
  sleep 2
  
  exec sudo sam local start-api -p 80 &

  cd ../../../  
}

if [ -d "$FEATURE_DIR" ]; then

#Start server
restart_server

#Docker start 
if P=$(pgrep docker)
then
    echo "docker is running..."
else
    sudo service docker start
fi

w1=$(tar -cf - "$FEATURE_DIR/src" | md5sum)
while true; do
  w2=$(tar -cf - "$FEATURE_DIR/src" | md5sum)
  if [ "$w1" != "$w2" ] ; then
    echo '\033[1;33mBuilding...\033[0m'
    
    sh build.sh -f "$feature" -i y

    echo '\033[1;34mRestart server...\033[0m'

    restart_server

    w1=$(tar -cf - "$FEATURE_DIR/src" | md5sum)
  fi
  sleep 5
done

fi