FILE="uninstall_extensions.json"

if [ -e $FILE ]; then
  json_content=$(cat $FILE | jq ".[]")
  json_length=$(echo $json_content | jq length)

  if [ ${json_length} != 0 ]; then
    for i in $(seq 0 $(expr ${json_length} - 1)); do
      extension=$(echo $json_content | jq ".[${i}]" | sed 's/"//g')
      code --uninstall-extension $extension
    done
  fi
fi
