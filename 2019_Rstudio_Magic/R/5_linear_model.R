############################################
### "Simple analysis of variance" without and with a covariate
### from base R, ez, and BayesFactor
############################################

############################################
### Extremely strong note of caution: linear models are not easy.
### You will see differences in some of these results below.
### That's because many different things matter when performing them in R
### e.g., order, sums of squares, covariates, contrasts.
### It is *very* important to find either a really good book or a really great friend to help
############################################


library(car)
library(ez)
library(BayesFactor)

load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","amerge_subset.rda"))
load(file=paste0(Sys.getenv("ADNI_FOLDER"),"\\","variable_type_map.rda"))

## prepare a subset of the data in a data.frame
wb_dx_age <- data.frame(
  SUBJECTS = rownames(amerge_subset),
  WHOLE_BRAIN = as.numeric(amerge_subset$WholeBrain),
  DX = as.factor(amerge_subset$DX),
  AGE = as.numeric(amerge_subset$AGE)
)

## perform ANOVA/linear model in base R.
one_factor_anova <- lm(WHOLE_BRAIN ~ DX, data = wb_dx_age)
one_factor_ancova_maineffects <- lm(WHOLE_BRAIN ~ DX + AGE, data = wb_dx_age)
# one_factor_ancova_interaction <- lm(WHOLE_BRAIN ~ DX : AGE, data = wb_dx_age)
# one_factor_ancova_fullmodel <- lm(WHOLE_BRAIN ~ DX * AGE, data = wb_dx_age)
summary(one_factor_anova)
summary(aov(one_factor_ancova_maineffects))

## alternatively
one_factor_anova_alt <- aov(WHOLE_BRAIN ~ DX, data = wb_dx_age)
summary(one_factor_anova_alt)

## now through car
car_one_factor_anova_type2 <- Anova(lm(WHOLE_BRAIN ~ DX, data = wb_dx_age))
car_one_factor_anova_type3 <- Anova(lm(WHOLE_BRAIN ~ DX, data = wb_dx_age), type="III")
car_one_factor_ancova_maineffects <- Anova(lm(WHOLE_BRAIN ~ DX + AGE, data = wb_dx_age), type="III")

(car_one_factor_anova_type3)
(car_one_factor_ancova_maineffects)

## now through ez
ez_one_factor_anova <- ezANOVA(wb_dx_age, wid=SUBJECTS, WHOLE_BRAIN, between=DX, type=3, return_aov = TRUE)
ez_one_factor_ancova <- ezANOVA(wb_dx_age, wid=SUBJECTS, WHOLE_BRAIN, between=DX, between_covariates = AGE, type=3, return_aov = TRUE)
(ez_one_factor_ancova)


### some comparisons
  #### NOTE THE DIFFERENCES.
  #### ALSO NOTE: We never changed any of the contrast types. That also plays an important role.
  ## not entirely correct because samples are unbalanced b/w groups
summary(aov(one_factor_ancova_maineffects))
  ## use drop1 in base R to correct for that
drop1(one_factor_ancova_maineffects,~.,test="F")
  ## or use car with type="III"
car_one_factor_ancova_maineffects
  ## or use ez because it's easier
summary(ez_one_factor_ancova$aov)


## and some Bayes Factors, for fun.
BF_one_factor_anova <- anovaBF(WHOLE_BRAIN ~ DX, data = wb_dx_age)
BF_one_factor_ancova <- lmBF(WHOLE_BRAIN ~ DX + AGE, data = wb_dx_age)
