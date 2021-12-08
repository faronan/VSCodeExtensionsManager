if [ $# != 1 ]; then
  # 引数で指定しなかった場合は、全extensionsをインストールする
  json_length=$(cat extensions.json | jq ".[]" | jq -s add | jq length)
  for i in $(seq 0 $(expr ${json_length} - 1)); do
    extension=$(cat extensions.json | jq ".[]" | jq -s add | jq ".[${i}]" | sed 's/"//g')
    code --install-extension $extension
  done
else
  json_length=$(cat extensions.json | jq ".${1}" | jq -s add | jq length)
  for i in $(seq 0 $(expr ${json_length} - 1)); do
    extension=$(cat extensions.json | jq ".${1}[${i}]" | sed 's/"//g')
    code --install-extension $extension
  done
fi
