EIA Data Visualization and Analysis

**Author: Angel Salazar**

***

Purpose: The purpose of this repository is to track all data updates associated with Energy Information Agency's API accessible data and create graphs and analyze up to data energy data.

***

**Libraries Used**
- [eia](https://cran.r-project.org/web/packages/eia/index.html)
- [EIAdata](https://cran.r-project.org/web/packages/EIAdata/index.html)
- [ggplot2](https://www.maths.usyd.edu.au/u/UG/SM/STAT3022/r/current/Misc/data-visualization-2.1.pdf)
- tidyr
- rjson
- dplyr
- tidyverse
- reshape2

***

**Resources**

1. [Energy Information Agency (EIA)](https://www.eia.gov/opendata/)
2. [EIA Annual Outlook 2021](https://www.eia.gov/outlooks/aeo/)

***

**EIA API Key Process**   

Purpose: to ensure a transparent, step-by-step on ensuring that your EIA API Key works properly.

Step 1: Register for an API Key [here](https://www.eia.gov/opendata/register.php)   

Step 2: Load 'eia' r package into your R Session   

Step 3: Run the following code   
eia_set_key(key = "your_key_here", store = "sysenv")   
    
Step 4: Run the following code to check if you successfully set your API Key for the R Session   
eia_get_key()   
result should be your "API_KEY"   
    

***

**Table of Contents**
1. [Long Term Outlook 2021](https://github.com/aangelsalazarr/EIA-Outlook-R-Analysis/blob/main/long_term_outlook_2021.md)
2. [Short Term Outlook 2021](https://github.com/aangelsalazarr/EIA-Outlook-R-Analysis/blob/main/short_term_outlook.md)
3. International Outlook 2021
4. [Electricity](https://github.com/aangelsalazarr/EIA-Outlook-R-Analysis/blob/main/eia_electricity.md)
