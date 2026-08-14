-- ============================================================
-- Solubility Project — Analysis Queries
-- Rohan — Aug 2026
-- Dataset: Delaney (ESOL) Aqueous Solubility Dataset, 1,128 compounds
-- ============================================================

-- Query 1: Most soluble compounds
-- Joins compounds + solubility tables, sorts to find the top 10
-- most water-soluble compounds. Used to sanity-check the data
-- and get a first look at what "soluble" compounds look like structurally.
SELECT c.molecular_weight, c.h_bond_donors, c.num_rings, s.measured_log_solubility
FROM compounds c
JOIN solubility s ON c.compound_id = s.compound_id
ORDER BY s.measured_log_solubility DESC
LIMIT 10;


-- Query 2: Least soluble compounds
-- Same as above, flipped to ASC — shows the 10 LEAST soluble
-- compounds, to compare against Query 1.
SELECT c.molecular_weight, c.h_bond_donors, c.num_rings, s.measured_log_solubility
FROM compounds c
JOIN solubility s ON c.compound_id = s.compound_id
ORDER BY s.measured_log_solubility ASC
LIMIT 10;


-- Query 3: Core analysis — averages by solubility class
-- Buckets all 1,128 compounds into 4 solubility categories using CASE,
-- then finds the average molecular weight, H-bond donors, and ring
-- count within each bucket. This is the main result of the project:
-- as solubility drops, molecular weight and ring count rise, while
-- H-bond donors fall.
SELECT 
  CASE 
    WHEN s.measured_log_solubility >= 0 THEN 'highly soluble'
    WHEN s.measured_log_solubility >= -2 THEN 'soluble'
    WHEN s.measured_log_solubility >= -4 THEN 'sparingly soluble'
    ELSE 'insoluble'
  END AS solubility_class,
  COUNT(*) AS num_compounds,
  AVG(c.molecular_weight) AS avg_mw,
  AVG(c.h_bond_donors) AS avg_h_donors,
  AVG(c.num_rings) AS avg_rings
FROM compounds c
JOIN solubility s ON c.compound_id = s.compound_id
GROUP BY solubility_class
ORDER BY avg_mw;


-- Query 4: Extended analysis — adds polar surface area and rotatable bonds
-- Same bucket structure as Query 3, with two more structural features added.
-- Found: polar surface area doesn't move in a clean straight line (non-monotonic),
-- and rotatable bonds falls as solubility rises — but this is likely confounded
-- with molecular weight (bigger molecules naturally have more rotatable bonds),
-- so it's not treated as an independent effect.
SELECT 
  CASE 
    WHEN s.measured_log_solubility >= 0 THEN 'highly soluble'
    WHEN s.measured_log_solubility >= -2 THEN 'soluble'
    WHEN s.measured_log_solubility >= -4 THEN 'sparingly soluble'
    ELSE 'insoluble'
  END AS solubility_class,
  COUNT(*) AS num_compounds,
  AVG(c.molecular_weight) AS avg_mw,
  AVG(c.h_bond_donors) AS avg_h_donors,
  AVG(c.num_rings) AS avg_rings,
  AVG(c.polar_surface_area) AS avg_psa,
  AVG(c.num_rotatable_bonds) AS avg_rotatable_bonds
FROM compounds c
JOIN solubility s ON c.compound_id = s.compound_id
GROUP BY solubility_class
ORDER BY avg_mw;