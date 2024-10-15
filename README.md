# Repository to generate tabular imputed data from MIMIC-III dataset

This repository contains the data to generate the MIMIC-III database using Docker and Postgres, to generate the main dataset from [Moor, M., Horn, M., Rieck, B., Roqueiro, D., & Borgwardt, K. (2019). Early Recognition of Sepsis with Gaussian Process Temporal Convolutional Networks and Dynamic Time Warping.](http://proceedings.mlr.press/v106/moor19a/moor19a.pdf) and the main dataset used in the article: [Comparing artificial intelligence strategies for early sepsis detection in the ICU: an experimental study](https://doi.org/10.1007/s10489-023-05124-z).


# Table of Contents
1. [Abstract](#Abstract) 
2. [Authors](#Authors) 
3. [Prerequisites](#Prerequisites)
4. [How to download and generate the base data](#Generate)
5. [What format will the data be in?](#Data_format)
6. [How works the code of the repository?](#Code)
7. [License](#license) 

<a name="Abstract"/>

## Abstract

***A Flexible Framework for Sepsis Prediction: Standardizing Data Management and Imputation in Time Series Using MIMIC-III***

> Sepsis is a life-threatening immune response to infections, leading to organ dysfunction. Despite technological advances, the application of AI in sepsis prediction faces challenges, particularly due to a lack of standardized approaches for data preprocessing and imputation. This work introduces a new framework aimed at simplifying data management, ensuring AI models trained on time series data are both reliable and comprehensive. The framework facilitates the construction and preprocessing of the Mimic-III database from PhysioNet, providing a standardized benchmark for future AI research in early sepsis prediction.


<a name="Authors"/>

## Authors:
- Javier Solís-García
- Jose E. Sánchez-López
- Belén Vega-Márquez
- Isabel A. Nepomuceno-Chamorro


<a name="Prerequisites"/>

## Prerequisites

This repository has been tested with the following requirements; however, it may be run with a different version of the listed software:

1. Ubuntu 20.04 or 22.04
2. Docker version 20.10.18
3. docker-compose version 1.29.2
4. Nvidia Container Tookit

<a name="Generate"/>

## How to download and generate the base data

### Clone the repository

The repository can be cloned with the command: ```git clone https://github.com/javiersgjavi/mimic-III-tabular.git```

### Generate the base data

```Warning:``` This guide has been made for Ubuntu 20.04, it should be similar for other Linux versions, but may differ for a different operating system

1. Request access to MIMIC-III data in [PhysioNet](https://mimic.mit.edu/docs/gettingstarted/).

2. Execute the streamlit app to generate data: ```streamlit run st.py```
   
<a name="Data_format"/>

## What format will the data be in?

At the end of the execution, 3 folders will be generated, which will contain the train, val and test data, and inside each of them 3 independent files in .npy format:

- x_dl.npy: this file contains the data of each patient in 3 dimensions:
    - 1 dimension: contains the patients.
    - 2 dimension: contains the different measurements.
    - 3 dimension: contains the time instants from [-49h, 0h] being 0h the onset instant.

Thus, if we want to consult the measurement 4 of patient 2 at time instant -48, it would be consulted as follows:

```
import numpy as np
x = np.load('x_dl.npy')
print(x[2, 4, 1])
```

- x_ml.npy: This file contains the data of each patient but in 2 dimensions, so that it is easily applicable with machine learning models. To achieve this dimension reduction we simply applied numpy's .flatten() function, so ```x_ml = x_dl.flatten()```. This file contains a number of rows equal to the number of patients, and a number of columns equal to 2156(number_of_measures*hours_before_sepsis). The column distribution has been constructed by concatenating successively the 49h of each measurement, so the first 49 columns represent the columns of [-49h, 0h] of measurement 0, and so on for each of the measurements.

- y.npy: this file contains the classification of each patient, if the patient is positive it will be marked as 1, and 0 otherwise.

The measures used to detect the occurrence of sepsis can be seen in the following list:
```
0. sysbp
1. diabp
2. meanbp
3. resprate
4. heartrate
5. spo2_pulsoxy
6. tempc
7. cardiacoutput
8. tvset
9. tvobserved
10. tvspontaneous
11. peakinsppressure
12. totalpeeplevel
13. o2flow
14. fio2
15. albumin
16. bands
17. bicarbonate
18. bilirubin
19. creatinine
20. chloride
21. glucose
22. hematocrit
23. hemoglobin
24. lactate
25. platelet
26. potassium
27. ptt
28. inr
29. pt
30. sodium
31. bun
32. wbc
33. creatinekinase
34. ck_mb
35. fibrinogen
36. ldh
37. magnesium
38. calcium_free
39. po2_bloodgas
40. ph_bloodgas
41. pco2_bloodgas
42. so2_bloodgas
43. troponin_t
```
<a name="Code"/>

## How works the code of the repository?

- **st.py**: it is the script that launch the web app to help with the process of data generation.
- **utils/preprocess_data.py**: it is a script that contains all functions that preprocess the data. This script contains all functions to make the different imputations methods.
- **classes/DataGeneration.py**: is the class that read the previous data generated by [BorgwardtLab/Imputing_Signatures](https://github.com/BorgwardtLab/Imputing_Signatures) repository and manage the transfomation to the tabular data.
- **classes/MGP.py**: the code of this file implement de MGP used in the gaussian process imputation. All code in this file is extracted from [BorgwardtLab/Imputing_Signatures](https://github.com/BorgwardtLab/Imputing_Signatures) repository.
- **data**: this folder will be generated during the execution of the repository and will contain the original data and the imputed data to reduce the execution time.
- **build_mimic_data**: this folder is used to download and generate the data which will be used. It contains the clone of two repositories:
  - [MIT-LCP/mimic-code](https://github.com/MIT-LCP/mimic-code) repository: is used to download de MIMIC-III data from physionet
  - [BorgwardtLab/mgp-tcn](https://github.com/BorgwardtLab/mgp-tcn): is used to generate the data that will be used by the experiments.


## License<a name="license"></a>

This project is licensed under the BSD-3-Clause license - see the [LICENSE](LICENSE) file for details
