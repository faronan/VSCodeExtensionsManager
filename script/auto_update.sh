current=($(yq -y ".[]" extensions.yml | tr -d '\r' | sed -e 's/- //g' -e '/---/d'))
fetch=($(curl -s $GIST_URL | jq -r '.[] | .metadata.publisherId'))

difference() {
  (printf '%s\n' $@ | sort -u; printf '%s\n' ${2}) | sort | uniq -u
}

difference_array=(`difference "${fetch[*]}" "${current[*]}"`)

if [ ${#difference_array[@]} -eq 0 ]; then
  echo "no diff!"
fi

for diff in ${difference_array[@]}; do
  echo "  - $diff" >> extensions.yml
done