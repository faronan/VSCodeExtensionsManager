if [ $# == 0 ]; then
  export $(cat script/.env)
  FILE=$BACKUP_FILE
else
  FILE=$1
fi

cat $FILE | while read extension
do
  code --install-extension $extension
done