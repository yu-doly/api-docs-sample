# #!/bin/bash
# Preview service openapi.yaml.

echo "Select target service."
select file in src/echoes-*
do
  entrypoint=$file/openapi.yaml
  break
done

if [ ! -e $entrypoint ]; then
  echo "$entrypoint not found. please check: ${entrypoint}"
  exit 1
fi

echo "Start preview... "
openapi preview-docs $entrypoint
