import os
import glob
import pandas as pd
os.chdir(os.getcwd()+"/bpifiles")


combined_csv = pd.read_csv("bpi1.csv")
#1388530800000
combined_csv = combined_csv[(combined_csv[combined_csv.columns[2]] >= 1388530800000) & (combined_csv[combined_csv.columns[2]] < 1420066800000)]
#1420066800000
#export to csv
combined_csv.to_csv( "bpi1unsorted.csv", index=False)

#sort
bpi_sorted=combined_csv.sort_values(combined_csv.columns[2])
bpi_sorted.to_csv( "bpi1sorted.csv", index=False)