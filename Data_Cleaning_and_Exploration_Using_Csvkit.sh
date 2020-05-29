#!/bin/bash

# In this project, we utitlized the Csvkit library, which supercharges your workflow by adding 13 new command line tools specifically for working with CSV files. We focused on below 5 tools from Csvkit:

# - csvstack: for stacking rows from multiple CSV files.
# - csvlook: renders CSV in pretty table format.
# - csvcut: for selecting specific columns from a CSV file.
# - csvstat: for calculating descriptive statistics for some or all columns.
# - csvgrep: for filtering tabular data using specific criteria.

# We used csvkit version 0.9.1 in this project and worked with the 3 datasets on housing affordability:
# - Hud_2005.csv
# - Hud_2007.csv
# - Hud_2013.csv

# Installing CSVkit:
sudo pip install csvkit

# - Merge `Hud_2005.csv`, `Hud_2007.csv`, and `Hud_2013.csv` in that order into one file:
#     - Name the resulting file `Combined_hud.csv`.
#     - Add an extra column named `year` which contains the year value from the file name for each row. E.g. the rows that originated from `Hud_2005.csv` should have `2005` as the value in the `year` column.
# - Use `head` to preview the first few rows of `Combined_hud.csv`.
# - Use the `wc` command with the `l` flag to confirm that the merged file contains `154118` rows.
ls -l
csvstack -n year -g 2005,2007,2013 Hud_2005.csv Hud_2007.csv Hud_2013.csv > Combined_hud.csv
head -5 Combined_hud.csv

# The `csvlook` tool parses CSV formatted data from its stdin and outputs a pretty formatted table representation of that data to its stdout. Use csvlook to preview the first 10 rows from `Combined_hud.csv`.
# the head command displays first 10 rows by default
# head Combined_hud.csv | csvlook
# head -n 10 Combined_hud.csv | csvlook
head -10 Combined_hud.csv | csvlook

# - Use csvcut to return all of the column names from `Combined_hud.csv`.
# - Use csvcut to display just the first 10 values in the `AGE1` column.
csvcut -n Combined_hud.csv
csvcut -c 2 Combined_hud.csv | head -10

# - Use csvstat to calculate just the mean for each column in `Combined_hud.csv`.
csvstat --mean Combined_hud.csv

# - Use csvstat to calculate the full summary statistics for just the `AGE1` column.
csvcut -n Combined_hud.csv
csvcut -c 2 Combined_hud.csv | csvstat

# - Display the first 10 rows from `Combined_hud.csv` where the value for the `AGE1` column is `-9` in a pretty table format.
csvgrep -c 2 -m -9 Combined_hud.csv | head -10 | csvlook

# - Select all rows where the value for `AGE1` isn't `-9` and write just those rows to `positive_ages_only.csv`.
csvgrep -c 2 -m -9 -i Combined_hud.csv > positive_ages_only.csv

# In this project, we used the csvkit library to explore and clean CSV files. We should use csvkit whenever we need to quickly transform or explore data from the command line, but remember that it has a few limitations:

# - Csvkit is not optimized for speed and struggles to run some commands over larger files.
# - Csvkit has very limited capabilities for actually editing problematic values in a dataset, since the community behind the library aspired to keep the library small and lightweight.
