############################################
### Exploring your data with summarytools 
### See vignette: https://cran.r-project.org/web/packages/summarytools/vignettes/Introduction.html
############################################

library(summarytools)

load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","amerge_subset.rda"))
load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","variable_type_map.rda"))

## 2.1 Frequency table
### set style to 'rmarkdown' for nicely formatted tables in rmd
freq(amerge_subset[,c('DX', 'PTRACCAT')],style='simple', report.nas=T, totals = T, cumul = T, headings = F)

## 2.2 Cross-tab table with chi-square test
ctable(amerge_subset$DX, amerge_subset$PTGENDER, prop='r', totals = T, chisq = T)
ctable(amerge_subset$DX, amerge_subset$APOE4, prop='r', totals = F,chisq = T)

### for markdown with multiline headings
#print(ctable(amerge_subset$DX, amerge_subset$PTGENDER, prop='r', totals = T), method = "render")
### Chi-square test in rmd
#library(magrittr)
#amerge_subset %$% 
#  ctable(DX, APOE4, chisq = TRUE, headings = FALSE) %>%
#  print(method = "render")

## 2.3 Descriptive univarite stats for continuous variables
descr(amerge_subset[,variable_type_map[,1]==1])
descr(amerge_subset[,variable_type_map[,1]==1], stats=c("mean", "sd", "min", "med", "max"),transpose = T, headings=F)

## 2.4 Data frame summary
view(dfSummary(amerge_subset))
### for rmd
#dfSummary(amerge_subset, plain.ascii = FALSE, style = "grid",graph.magnif = 0.75, valid.col = FALSE, tmp.img.dir = "/tmp")

## 2.5 Descriptive stats by DX group
stby(data = amerge_subset,INDICES = amerge_subset$DX,FUN = descr, stats = c("mean", "sd", "min", "med", "max"), transpose = TRUE)

