# if [ ${1} == all ]; then
#   docker-compose run --rm python yq -y ".[]" extensions.yml | tr -d '\r' | sed -e 's/- //g' -e '/---/d' | while read extension; do
#     code --install-extension $extension
#   done
# else
#   docker-compose run --rm python yq -y .${1} ${2} | tr -d '\r' | sed -e 's/- //g' | while read extension; do
#     code --install-extension $extension
#   done
# fi

# 引数で指定しなかった場合は、全extensionsをインストールする
if [ $# != 1 ]; then
  IFS=$'\n'
  for extension in $(cat extensions.json | jq -c ".extensions"); do
    code --install-extension $extension
  done
else
  echo OK
fi
