library(ADNIMERGE)
library(tidyverse)
library(magrittr)

###########################
### Load and clean data
###########################

## 1.1 Specify the column names you want and filter those participants at baseline with MOCA>=16 and complete data
adnimerge %>%
  dplyr::select(RID, VISCODE, DX, AGE, PTGENDER, PTEDUCAT, PTETHCAT, PTRACCAT, APOE4, FDG, AV45, CDRSB, ADAS13, MOCA, WholeBrain, Hippocampus, MidTemp, mPACCtrailsB) %>%
  filter(VISCODE == "bl") %>%
  filter(MOCA >= 16) %>%
  drop_na() -> amerge_subset

## 1.2 Bring in modified hachinksi 
amerge_subset %<>% inner_join(modhach[,c("RID","HMSCORE")])

## 1.3 Manually change variable classes (remove class 'labelled')
char.cols<-c('RID', 'VISCODE', 'DX', 'PTGENDER','PTETHCAT', 'PTRACCAT')
amerge_subset[,char.cols] %<>% lapply(function(x) as.character(x))
num.cols<-c('AGE', 'PTEDUCAT', 'APOE4', 'FDG','AV45', 'CDRSB', 'ADAS13', 'MOCA','WholeBrain','Hippocampus','MidTemp','mPACCtrailsB','HMSCORE')
amerge_subset[,num.cols] %<>% lapply(function(x) as.numeric(x))

### 1.4 Add rownames and remove first 2 (ID) columns
rownames(amerge_subset) <- amerge_subset$RID
amerge_subset %<>% select(-RID, -VISCODE)

## 1.5 Recode some of the variables to eliminate low frequency responses/values
##### Use if_else() to rescore numeric values in a particular range (ie, a T/F vector)
##### if_else() in dplyr is identical to the base funciton ifselse()
amerge_subset$PTEDUCAT <- if_else(amerge_subset$PTEDUCAT<=12, 12, amerge_subset$PTEDUCAT) 
amerge_subset$CDRSB <- if_else(amerge_subset$CDRSB>=5.5, 5.5, amerge_subset$CDRSB)
amerge_subset$HMSCORE <- if_else(amerge_subset$HMSCORE>=3, 3, amerge_subset$HMSCORE)

##### Use recode() to recode string variables
##### There are multiple recode() functions across R packages (ie, car); specifiy which package you want to call with ::
amerge_subset$PTETHCAT <- dplyr::recode(amerge_subset$PTETHCAT, `Hisp/Latino`= "Hisp/Latino",  .default = "Not Hisp/Latino")
## an alternate recode() with piping
amerge_subset %<>% mutate(PTETHCAT = recode(PTETHCAT, `Hisp/Latino`= "Hisp/Latino",  .default = "Not Hisp/Latino"))

################################
### Create variable type mapping
################################

## 1.6 Take a quick look at what these originally were:
unlist(lapply(amerge_subset,function(x){y<-class(x); y[length(y)]}))

## 1.7 Make a map of variables to types
matrix(0, nrow=ncol(amerge_subset), ncol = 3) %>%
  `colnames<-`(c("Continuous","Categorical","Ordinal")) %>%
  `rownames<-`(colnames(amerge_subset)) ->
  variable_type_map

## some *very* good arguments can (should) be made that these are not necessarily continuous.
## some are counts or count-like and most are by definition strictly non-negative.
likely_continuous_items <- c("AGE","FDG","AV45","WholeBrain","Hippocampus","MidTemp","mPACCtrailsB")
strictly_categorical_items <- c("DX","PTGENDER","PTETHCAT","PTRACCAT")
strictly_ordinal_items <- c("PTEDUCAT","MOCA","ADAS13","CDRSB")
categorical_or_ordinal_items <- c("APOE4","HMSCORE")

variable_type_map[likely_continuous_items,"Continuous"] <- 1
variable_type_map[strictly_categorical_items,"Categorical"] <- 1
variable_type_map[strictly_ordinal_items,"Ordinal"] <- 1
variable_type_map[categorical_or_ordinal_items,"Categorical"] <- 1
variable_type_map[categorical_or_ordinal_items,"Ordinal"] <- 1

## 1.8 Save our cleaned ADNI dataset and variale type mapping
#save(amerge_subset, file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","amerge_subset.rda"))
#save(variable_type_map, file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","variable_type_map.rda"))