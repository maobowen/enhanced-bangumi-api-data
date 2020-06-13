#!/bin/sh

set -u

TOP_LEVEL_SCHEMAS=("services" "locales")
SCHEMA_SUBJECTS="subjects"
SCHEMA_SOURCES="sources"
SCHEMA_EPISODES="episodes"
HEADER_SUBJECTS="id,name_jp,name_cn,name_en,mal_id,website,on_air_date,bgm_image_url"
HEADER_SOURCES="subject_id,service_id,paid,subject_url_id,subtitle_locales,remark"
HEADER_EPISODES="subject_id,episode_id,service_id,episode_url_id,video_url_id,remark"
error=0

for schema in "${TOP_LEVEL_SCHEMAS[@]}"; do
  if [ -f "schemas/${schema}.json" ]; then
    echo "Validating ${schema}.csv"
    csval "${schema}.csv" "schemas/${schema}.json" > /dev/null || error=1
  fi
done

if [ -f "schemas/${SCHEMA_SUBJECTS}.json" ]; then
  for file in $(ls -v ${SCHEMA_SUBJECTS}/*.csv); do
    echo "Validating ${file}"
    read -r header < ${file} && [ ${header} = ${HEADER_SUBJECTS} ] || { echo "Header of ${file} is wrong"; error=1; }
    csval ${file} "schemas/${SCHEMA_SUBJECTS}.json" > /dev/null || error=1
  done
fi

if [ -f "schemas/${SCHEMA_SOURCES}.json" ]; then
  for file in $(ls -v ${SCHEMA_SOURCES}/*.csv); do
    echo "Validating ${file}"
    read -r header < ${file} && [ ${header} = ${HEADER_SOURCES} ] || { echo "Header of ${file} is wrong"; error=1; }
    csval ${file} "schemas/${SCHEMA_SOURCES}.json" > /dev/null || error=1
  done
fi

if [ -f "schemas/${SCHEMA_EPISODES}.json" ]; then
  for file in $(ls -v ${SCHEMA_EPISODES}/*/*.csv); do
    echo "Validating ${file}"
    read -r header < ${file} && [ ${header} = ${HEADER_EPISODES} ] || { echo "Header of ${file} is wrong"; error=1; }
    csval ${file} "schemas/${SCHEMA_EPISODES}.json" > /dev/null || error=1
  done
fi

if [ ${error} -eq 1 ]; then 
    exit 1
fi
