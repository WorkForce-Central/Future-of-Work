# PUMS Analysis, Data Prep, and Data Extracts used in the 2019 Pierce County's Future of Work Report

We extracted occupation level probabilities from Frey and Osborne’s study “The Future of Employment” and paired those probabilities with Standardized Occupation Codes (SOC) to current employment data for the region (2019 Q1 QCEW estimates drawn from Chmura’s JobsEQ).

To estimate probability by demographic and education characteristics, we first estimated employment distributions using Public-Use Microdata Samples for WA (Population 2017-1-yr) from the U.S. Census. Sample estimates were replicated using R (version 3.5.1) with the survey package. To account for inconsistencies between BLS SOC and PUMS SCOP coding, we aggregated PUMS employment estimates to the 2-digit SOCP. Frey and Osborne probabilities were weighted by regional employment counts and aggregated to the 2-digit SOC code, then joined with the 2-digit SOCP employment estimates for each demographic group.

All employment, wages, industry, and GDP estimates were pulled from the Bureau of Labor Statistics via Chmura's JobsEQ.
Postsecondary Awards data was pulled from the Naitonal Center for Education Statistics via Chmura's JobsEQ.
