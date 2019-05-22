if(!require(covstatis)){
  devtools::install_github("jennyrieck/C-MARINeR", subdir = "/code/covstatis")
  library(covstatis)
}

if(!require(GSVD)){
  devtools::install_github("derekbeaton/GSVD")
  library(GSVD)
}


## subset into group and specificallly continous columns

control_continuous_data <- amerge_subset[amerge_subset$DX=="CN",which(variable_type_map[,"Continuous"]==1)]
mci_continuous_data <- amerge_subset[amerge_subset$DX=="MCI",which(variable_type_map[,"Continuous"]==1)]
ad_continuous_data <- amerge_subset[amerge_subset$DX=="Dementia",which(variable_type_map[,"Continuous"]==1)]

## create correlation matrics
control_correlation <- cor(control_continuous_data)
mci_correlation <- cor(mci_continuous_data)
ad_correlation <- cor(ad_continuous_data)

## put the correlation matrices into a list

cor_mats <- list(control = control_correlation,
                 mci = mci_correlation,
                 ad = ad_correlation)

## call covstatis

covstatis_results <- covstatis(cor_mats, compact = F)