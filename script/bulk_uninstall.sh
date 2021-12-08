FILE="uninstall_extensions.json"

if [ -e $FILE ]; then
  json_length=$(cat $FILE | jq ".[]" | jq -s add | jq length)
  for i in $(seq 0 $(expr ${json_length} - 1)); do
    extension=$(cat $FILE | jq ".[]" | jq -s add | jq ".[${i}]" | sed 's/"//g')
    code --uninstall-extension $extension
  done
fi
