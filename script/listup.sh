EXTENSIONS_ARRAY="["
for extension in $(code --list-extensions); do
  EXTENSIONS_ARRAY+=\"${extension}\",
done
EXTENSIONS_ARRAY=${EXTENSIONS_ARRAY/%?/}"]"

echo {} | jq '.extensions ='${EXTENSIONS_ARRAY} >extensions.json
