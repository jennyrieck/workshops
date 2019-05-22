library(ADNIMERGE)

###########################
### Load and clean data
###########################

## 0.1 Specify the column names and participants you want (ie, baseline visit for all participants with MOCA>=16)
adni.cols <- c('RID', 'VISCODE', 'DX', 'AGE', 'PTGENDER', 'PTEDUCAT', 'PTETHCAT', 'PTRACCAT', 'APOE4', 'FDG', 'AV45', 'CDRSB', 'ADAS13', 'MOCA', 'WholeBrain', 'Hippocampus', 'MidTemp', 'mPACCtrailsB')
adni.rows <- c(adnimerge$VISCODE=='bl' & adnimerge$MOCA>=16)
amerge_subset <- adnimerge[adni.rows,adni.cols]

#### remove participants with missing data
amerge_subset <- amerge_subset[complete.cases(amerge_subset),]

## 0.2 Bring in modified hachinksi 
amerge_subset$HMSCORE <- modhach$HMSCORE[match(amerge_subset$RID, modhach$RID)]

## Let's look at the dataset we've curated!
View(amerge_subset) ##importantly, capital V
class(amerge_subset$RID)

## 0.3 Manually change variable classes (remove class 'labelled')
amerge_subset$RID <- as.character(amerge_subset$RID)
amerge_subset$VISCODE <- as.character(amerge_subset$VISCODE)
amerge_subset$DX <- as.character(amerge_subset$DX)
amerge_subset$AGE <- as.numeric(amerge_subset$AGE)
amerge_subset$PTGENDER <- as.character(amerge_subset$PTGENDER)
amerge_subset$PTEDUCAT <- as.numeric(amerge_subset$PTEDUCAT)
amerge_subset$PTETHCAT <- as.character(amerge_subset$PTETHCAT)
amerge_subset$PTRACCAT <- as.character(amerge_subset$PTRACCAT)
amerge_subset$APOE4 <- as.numeric(amerge_subset$APOE4)
amerge_subset$FDG <- as.numeric(amerge_subset$FDG)
amerge_subset$AV45 <- as.numeric(amerge_subset$AV45)
amerge_subset$CDRSB <- as.numeric(amerge_subset$CDRSB)
amerge_subset$ADAS13 <- as.numeric(amerge_subset$ADAS13)
amerge_subset$MOCA <- as.numeric(amerge_subset$MOCA)
amerge_subset$WholeBrain <- as.numeric(amerge_subset$WholeBrain)
amerge_subset$Hippocampus <- as.numeric(amerge_subset$Hippocampus)
amerge_subset$MidTemp <- as.numeric(amerge_subset$MidTemp)
amerge_subset$mPACCtrailsB <- as.numeric(amerge_subset$mPACCtrailsB)
amerge_subset$HMSCORE <- as.numeric(amerge_subset$HMSCORE)

## 0.4 Add RID as rowname and remove first 2 (ID) columns
rownames(amerge_subset) <- amerge_subset$RID
amerge_subset <- amerge_subset[,-c(1:2)]

## 0.5 Recode some of the variables to rescore low frequency responses/values
amerge_subset$PTEDUCAT[amerge_subset$PTEDUCAT<=12] <- 12
amerge_subset$PTETHCAT[amerge_subset$PTETHCAT!='Hisp/Latino']<-'Not Hisp/Latino'
amerge_subset$PTRACCAT[amerge_subset$PTRACCAT!='Black' & amerge_subset$PTRACCAT!='White' & amerge_subset$PTRACCAT!='Asian']<-'Other'

#### ifelse() is a base function that can also recode a variable
amerge_subset$CDRSB<-ifelse(amerge_subset$CDRSB>=5.5, 5.5, amerge_subset$CDRSB)
amerge_subset$HMSCORE <- ifelse(amerge_subset$HMSCORE>=3, 3, amerge_subset$HMSCORE)

### Let's look at the data again after cleanup
View(amerge_subset)

################################
### Create variable type mapping
################################

## 0.6 Take a quick look at what these originally were:
unlist(lapply(amerge_subset,function(x){y<-class(x); y[length(y)]}))

## 0.7 Make a map of variables to types
variable_type_map <- matrix(0, nrow=ncol(amerge_subset), ncol = 3)
colnames(variable_type_map) <- c("Continuous","Categorical","Ordinal")
rownames(variable_type_map) <- colnames(amerge_subset)

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

## 0.8 Save our cleaned ADNI dataset and variale type mapping
### Check our environmental variable
head(Sys.getenv())
save(amerge_subset, file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","amerge_subset.rda"))
save(variable_type_map, file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","variable_type_map.rda"))