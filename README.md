![GitHub Top Language](https://img.shields.io/github/languages/top/maobowen/enhanced-bangumi-api-data)
[![Build Status](https://travis-ci.com/maobowen/enhanced-bangumi-api-data.svg?branch=master)](https://travis-ci.com/maobowen/enhanced-bangumi-api-data)
![GitHub License](https://img.shields.io/github/license/maobowen/enhanced-bangumi-api-data)

# Data for Enhanced Bangumi API

This is the data used by the [Enhanced Bangumi API](https://github.com/maobowen/enhanced-bangumi-api), yet another API to collect anime-related information such as on which websites people can stream animes.

## File Structures

### Database Schemas

- `schemas/schemas.sql` is the formal definition of the relational database schemas that the API uses. The format of CSV files described below are also in compliance with the tables defined here.
- `schemas/*.json` describes the schemas in [JSON Schema](https://json-schema.org/understanding-json-schema/reference/) format and are solely for validation purpose.

### Data

- `services.csv` contains the records of anime streaming websites.
- `locales.csv` contains the subtitle locale information.
- `subjects/<year>.csv` contains the records of anime series.
- `sources/<quarter>.csv` contain the records of which anime websites are streaming which animes.
- `episodes/<quarter>/<subject>.csv` contain the records for each episode.

### Catalogs

- `catelog/<year>.md` records for each anime series, the data of which streaming websites have been collected.

## Usage

Run `sh import.sh` to bulkily load schemas and data into a Postgres database.

## Development

The [data crawler](https://github.com/maobowen/enhanced-bangumi-api-data-crawler) is a tool that crawls anime data from various streaming websites and generates the source and episode records automatically. Records in the other CSV files need to be collected manually.

To validate the data files, run `npm install -g csval` to install [`csval`](https://github.com/travishorn/csval), and then run `sh validate.sh`.

## References

This sub-project is inspired by the following projects: 

- [TinyGrail Episode Plugin](https://bgm.tv/group/topic/346036)
- [Bangumi Data](https://github.com/bangumi-data/bangumi-data)

---

© [101对双生儿](https://bmao.tech/) 2020. All Rights Reserved.
