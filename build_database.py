"""
build_database.py

What this does, in plain terms:
1. Reads the raw CSV (one big spreadsheet of 1,128 compounds)
2. Splits it into two related tables, just like the movies/boxoffice exercise:
     - compounds:  the compound's identity + structural features
     - solubility: the compound's measured/predicted solubility values
3. Saves both tables into a single SQLite database file: solubility.db

Run it with:  python3 build_database.py
"""

import pandas as pd
import sqlite3

# Step 1: read the CSV into a pandas DataFrame (basically an in-memory spreadsheet)
df = pd.read_csv("delaney.csv")

# Rename columns to be SQL-friendly (no spaces, all lowercase, underscores)
df = df.rename(columns={
    "Compound ID": "compound_id",
    "ESOL predicted log solubility in mols per litre": "predicted_log_solubility",
    "Minimum Degree": "min_degree",
    "Molecular Weight": "molecular_weight",
    "Number of H-Bond Donors": "h_bond_donors",
    "Number of Rings": "num_rings",
    "Number of Rotatable Bonds": "num_rotatable_bonds",
    "Polar Surface Area": "polar_surface_area",
    "measured log solubility in mols per litre": "measured_log_solubility",
    "smiles": "smiles",
})

# Step 2: split into two tables that share a common key (compound_id) — same idea
# as movies.id = boxoffice.movie_id in your SQLBolt exercise.

compounds = df[[
    "compound_id", "smiles", "molecular_weight", "min_degree",
    "h_bond_donors", "num_rings", "num_rotatable_bonds", "polar_surface_area"
]]

solubility = df[[
    "compound_id", "measured_log_solubility", "predicted_log_solubility"
]]

# Step 3: write both tables into one SQLite database file
conn = sqlite3.connect("solubility.db")
compounds.to_sql("compounds", conn, if_exists="replace", index=False)
solubility.to_sql("solubility", conn, if_exists="replace", index=False)
conn.close()

print("Done. Created solubility.db with two tables: 'compounds' and 'solubility'")
print(f"Rows loaded: {len(df)}")
