############################################
### Exploring your data with inspectdf 
### See vignette: https://github.com/alastairrushworth/inspectdf
############################################

library(inspectdf)

load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","amerge_subset.rda"))
load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","variable_type_map.rda"))

### 3.1 Inspect what kind of data types are in your df
inspect_types(amerge_subset, show_plot = T)

### 3.2 Inspect memory usage of your variables
inspect_mem(amerge_subset, show_plot = T)

### 3.3 Inspect NA to find prevalence of missing values
###### However we have chosen only complete case data, so this is not too informative for the adni toy dataset
inspect_na(amerge_subset, show_plot=T)

### 3.4 Inspect pairwise correlations of continuous variables
inspect_cor(amerge_subset[,variable_type_map[,"Continuous"]==1], show_plot=T)

### 3.5 Inspect feature imbalance of categorical variables
inspect_imb(amerge_subset[,variable_type_map[,"Categorical"]==1], show_plot = T)

### 3.6 Inspect categorical summaries
inspect_cat(amerge_subset[,variable_type_map[,"Categorical"]==1], show_plot = T)
