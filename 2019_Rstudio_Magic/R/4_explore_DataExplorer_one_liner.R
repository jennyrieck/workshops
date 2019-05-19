############################################
### Exploring your data with DataExplorer 
### https://cran.r-project.org/web/packages/DataExplorer/vignettes/dataexplorer-intro.html
### One line to create a summary report of all your variables
############################################

library(DataExplorer)

load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","amerge_subset.rda"))
load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","variable_type_map.rda"))

### Only one line of code; but with an extra, extra, extra, strong word of caution:
DataExplorer::create_report(amerge_subset, report_title = 'ADNI Data Report',
                            output_file='My_ADNI_Data_Report_PARTIALLY_INCORRECT.html',
                            output_dir = Sys.getenv("ADNI_FOLDER"))


### First of all, this package takes all data you have, 
  ### magically transforms it into numbers (even categorical data),
  ### then performs correlations & PCA. 
  ### this is wrong. You cannot compute correlations or PCA on categories.
    ### see: https://github.com/derekbeaton/Workshops/tree/master/RTC/PCA_MCA_Resampling

### thus, to use this type of package appropriately, you need to think about what it does and what you have
  ### we *must* restrict the analysis to only values where we can appropriately compute correlations


### Only one line of code; but now, appropriately. 
DataExplorer::create_report(amerge_subset[variable_type_map[,"Continuous"]==1], report_title = 'ADNI Data Report',
                            output_file='My_ADNI_Data_Report_CORRECT.html',
                            output_dir = Sys.getenv("ADNI_FOLDER"))