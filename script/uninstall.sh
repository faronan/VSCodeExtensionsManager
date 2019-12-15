EXTENSIONS=(`code --list-extensions`)

for extension in ${EXTENSIONS[@]}; do
  echo "$extension" >> backup.txt
  code --uninstall-extension $extension
done