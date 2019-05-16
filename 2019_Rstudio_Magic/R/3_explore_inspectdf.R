############################################
### Exploring your data with inspectdf 
### See vignette: https://github.com/alastairrushworth/inspectdf
############################################

library(inspectdf)

load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","amerge_subset.rda"))
load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","variable_type_map.rda"))

### 3.1 Inspect what kind of data types are in your df
inspect_types(amerge_subset)
