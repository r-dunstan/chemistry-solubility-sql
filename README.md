Predicting aqueous solubility from different molecular structures
Analysis of the ESOL dataset using SQL + python

## Question
Which structural properties of a molecule are related to how soluble the molecule is in water?

## Data used
The Delaney (ESOL) dataset was used as it consists of 1128 organic compounds with experimentally measured properties such as the number of hydrogen bond doners, number of rings, number of rotatable bonds, molecular weight and the polar surface area of each compound. 

## What was done 
The relational database was built (build_database.py) to convert the raw CSV into a queryable database so it could be split into two related tables (compound and solubility), joined on coumpound_id. This was done for JOIN practice using SQL and to reflect how data is structured in practice. 
The data was then queried using SQL (analysis_queries.sql) using JOINs, CASE statements, GROUP BY and aggregate functions to group the 1128 compounds into four different solubility groups from insoluble to highly soluble, this was then used to compare their structural properties. 
Python was then used to visuale the found data (make_chart.py).

## What was found.
Through the data it was found that compounds become less soluble as the molecular weight increases, this was seen as highly soluble compounds had an average of 108.8g/mol whereas the insoluble compounds had an average of 287.0 g/mol. Another property was the ring count as it was found that compounds with a lower ring count were the most soluble compared to those with higher ring counts which were less soluble suggesting that as ring count increases compounds become less soluble. It was also found that insoluble compounds have fewer hydrogen bond donors, from an average of 1.22 in soluble compounds to 0.42 seen with less soluble compounds. 
<img width="2250" height="750" alt="chart1_averages_by_class" src="https://github.com/user-attachments/assets/ad4ca36d-bfef-4249-ba54-abd0690e10ca" />
This is consistent with established ideas that molecues that can hydrogen bond with water through -OH groups and NH groups dissolve easier compared to larger ring heavier compounds which is expressed in the scatter graph below.<img width="1200" height="900" alt="chart2_mw_vs_solubility" src="https://github.com/user-attachments/assets/9d528dee-0b69-467b-8a03-0f4e7e146f67" />

## Limitations 
Through analysis of the data there were two areas which stood out. One was the polar surface area, which was expected to increase with the solubility however it dipped and rose across the 4 solubility groups. The rotatable bonds on the other hand did fall as solubility rose which was expected however this is likely tied to the molecular weight, as larger molecules naturally have more single bonds to rotate around, therefore this might just be reinforcing the molecular weight trend. 

## Improvements
One thing I would do next time is control for the molecular weight to find an independent effect for the rotatable bonds.
Compare predicted dataset values with measured ones in order to check of the ESOL model over or underperforms.

## Files in repo 
delaney.csv — raw dataset
build_database.py — builds the SQLite database from the CSV
analysis_queries.sql — all SQL queries used in the analysis, commented
make_charts.py — generates the charts from the database
solubility.db — the built database
chart1_averages_by_class.png, chart2_mw_vs_solubility.png — output charts
