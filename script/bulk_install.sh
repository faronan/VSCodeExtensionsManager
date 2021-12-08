if [ $# != 1 ]; then
  # 引数で指定しなかった場合は、全extensionsをインストールする
  json_content=$(cat extensions.json | jq ".[]" | jq -s add)
else
  json_content=$(cat extensions.json | jq ".${1}")
fi

json_length=$(echo $json_content | jq length)
if [ ${json_length} != 0 ]; then
  for i in $(seq 0 $(expr ${json_length} - 1)); do
    extension=$(echo $json_content | jq ".[${i}]" | sed 's/"//g')
    code --install-extension $extension
  done
fi
