# #!/bin/bash
# Generate yaml and html files under docs from openapi.yaml for each service.

files=src/echoes-*
ALL="all"

echo "Select target service."
select selected in $ALL $files
do
  if [ $selected != $ALL ]; then
    files=$selected
  fi

  break
done

for file in $files
do
  service_name="${file##*/}"

  entrypoint=$file/openapi.yaml
  outputDir=docs/$service_name

  if [ ! -e $entrypoint ]; then
    echo "$entrypoint not found. please check: ${entrypoint}"
    exit 1
  fi

  echo "\nStart generating YAML of $service_name..."
  npx openapi bundle $entrypoint -o $outputDir/openapi.yaml

  echo "\nStart generating HTML of $service_name..."
  npx redoc-cli bundle $outputDir/openapi.yaml -o $outputDir/index.html --options.onlyRequiredInSamples
done

exit 0
