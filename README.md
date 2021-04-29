# Volusia Merged Streets
Merged GIS street data for Volusia County.

The StreetMerge script combines street geography based on street name and suffix. 

The situs records are then updated with the unique merged street identifiers.

The script includes a number of updates to the situs table in order to standardize some street name formats (e.g. INTL SPEEDWAY vs INTERNATIONAL SPEEDWAY).

NOTE: There are still roughly 29k records that do not have a unique street ID assigned to them. The majority of these simply do not have an address in the dataset. However, some of these are legitimate addresses with formatting issues. To see a more detailed breakdown you should run the query at the bottom of the StreetMerge script.

## Usage

You have two options for utilizing this dataset.

1. Run every statement in the StreetMerge.sql script, which will perform all updates on existing tables.
2. Run the two Volusia...sql scripts, which will import the entire streets_merged and situs tables.

## Sample set

| Street_GUID | Street_Name       | Street_Type | Left_Address_From | Left_Address_To | Right_Address_From | Right_Address_To |
|-------------|-------------------|-------------|-------------------|-----------------|--------------------|------------------|
| 1           | "105 TURN AROUND" | NULL        | 0                 | 0               | 0                  |                  |
| 2           | "10TH"            | "AVE"       | 700               | 2398            | 701                | 2399             |
| 3           | "10TH"            | "ST"        | 100               | 1498            | 0                  | 1499             |
| 4           | "11TH"            | "AVE"       | 100               | 2498            | 101                | 2499             |
| 5           | "11TH"            | "ST"        | 868               | 870             | 869                | 869              |
| 6           | "123 TURN AROUND" | NULL        | 0                 | 0               | 0                  |                  |
| 7           | "127 TURN AROUND" | NULL        | 0                 | 0               | 0                  |                  |
| 8           | "129 TURN AROUND" | NULL        | 0                 | 0               | 0                  |                  |
| 9           | "12TH"            | "AVE"       | 0                 | 2498            | 1                  | 2499             |
| 10          | "12TH"            | "ST"        | 101               | 2298            | 100                | 2301             |
| 11          | "13TH"            | "AVE"       | 700               | 998             | 701                | 999              |
| 12          | "13TH"            | "ST"        | 1100              | 2048            | 1100               | 2049             |
| 13          | "14TH"            | "AVE"       | 700               | 998             | 701                | 999              |
| 14          | "14TH"            | "ST"        | 2                 | 2398            | 1                  | 2399             |
| 15          | "15TH"            | "AVE"       | 700               | 998             | 701                | 999              |
