# #!/bin/bash
# Split openapi file by service with structure.

read -p "Please enter path to API definition file (YAML) that you want to split (default: edition.yaml):" entrypoint

entrypoint=${entrypoint:-editing.yaml}

if [ ! -e $entrypoint ]; then
  echo "$entrypoint not found. please check: ${entrypoint}"
  break
elif [ "${entrypoint##*.}" != "yaml" ]; then
  echo "Please check the extention."
  exit 1
fi

echo "Select target service."
select file in src/echoes-*
do
  outputDir=$file
  break
done

if [ ! -e $outputDir ]; then
  echo "$outputDir not found. please check: ${outputDir}"
  exit 1
fi

echo "Start splitting... "
echo "openapi split $entrypoint --outDir=$outputDir"
openapi split $entrypoint --outDir=$outputDir

echo "Delete original API definition file？ [Y/n]: "
read ANS

case $ANS in
  "" | [Yy]* )
    rm $entrypoint
    echo "Success deleted!"
    exit 0
    ;;
  * )
    exit 0
    ;;
esac
