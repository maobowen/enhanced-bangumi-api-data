#!/bin/bash

set -u

DB_NAME="enhanced_bangumi_api"
PSQL_BIN="$(which psql)"
PSQL_OPTIONS="-P pager=off -X -d ${DB_NAME}"

# https://stackoverflow.com/a/21188136
get_abs_filename() {
  # $1 : relative filename
  filename=$1
  parentdir=$(dirname "${filename}")

  if [ -d "${filename}" ]; then
    echo "$(cd "${filename}" && pwd)"
  elif [ -d "${parentdir}" ]; then
    echo "$(cd "${parentdir}" && pwd)/$(basename "${filename}")"
  fi
}


${PSQL_BIN} ${PSQL_OPTIONS} -f "schemas/schemas.sql"
echo -n "Importing services.csv: "
${PSQL_BIN} ${PSQL_OPTIONS} -c "\COPY services FROM '$(pwd)/services.csv' DELIMITER ',' CSV HEADER;"
echo -n "Importing locales.csv: "
${PSQL_BIN} ${PSQL_OPTIONS} -c "\COPY locales FROM '$(pwd)/locales.csv' DELIMITER ',' CSV HEADER;"
for file in $(ls -v subjects/*.csv); do
  echo -n "Importing ${file}: "
  ${PSQL_BIN} ${PSQL_OPTIONS} -c "\COPY subjects FROM '$(get_abs_filename ${file})' DELIMITER ',' CSV HEADER;"
done
for file in $(ls -v sources/*.csv); do
  echo -n "Importing ${file}: "
  ${PSQL_BIN} ${PSQL_OPTIONS} -c "\COPY sources FROM '$(get_abs_filename ${file})' DELIMITER ',' CSV HEADER;"
done
for file in $(ls -v episodes/*/*.csv); do
  echo -n "Importing ${file}: "
  ${PSQL_BIN} ${PSQL_OPTIONS} -c "\COPY episodes FROM '$(get_abs_filename ${file})' DELIMITER ',' CSV HEADER;"
done
