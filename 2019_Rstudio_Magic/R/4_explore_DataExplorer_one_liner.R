############################################
### Exploring your data with DataExplorer 
### https://cran.r-project.org/web/packages/DataExplorer/vignettes/dataexplorer-intro.html
### One line to create a summary report of all your variables
############################################

library(DataExplorer)

load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","amerge_subset.rda"))
load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","variable_type_map.rda"))

### Only one line of code!
DataExplorer::create_report(amerge_subset, report_title = 'ADNI Data Report',
                            output_file='My_ADNI_Data_Report.html',
                            output_dir = Sys.getenv("ADNI_FOLDER"))
