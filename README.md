# Volusia Merged Streets
Merged GIS street data for Volusia County.

The StreetMerge script combines street geography based on street name and suffix. 

The situs records are then updated with the unique merged street identifiers.

The script includes a number of updates to the situs table in order to standardize some street name formats (e.g. INTL SPEEDWAY vs INTERNATIONAL SPEEDWAY).

## Usage

You have two options for utilizing this dataset.

1. Run every statement in the StreetMerge.sql script, which will perform all updates on existing tables.
2. Run the two Volusia...sql scripts, which will import the entire streets_merged and situs tables.
