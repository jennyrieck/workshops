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
hippo_dx_age <- data.frame(
  SUBJECTS = rownames(amerge_subset),
  HIPPO = as.numeric(amerge_subset$Hippocampus),
  DX = as.factor(amerge_subset$DX),
  AGE = as.numeric(amerge_subset$AGE)
)


############################################
### These examples ask and answer the same question in multiple ways:
### Question: Are there differences/effects of whole brain volume between groups?
### Approach one: linear model/ANOVA (not quite appropriate)
### Approach two: linear model/AN*C*OVA (also not quite appropriate)
    #### The independent variable (IV)---which is DX---is corrected by AGE
### Approach three: linear model/ANOVA with the DV (brain volume) corrected by AGE
    #### This requires two linear models, or the residuals of one model as the DV in another.
############################################


############################################
### "Simple" linear model/one-factor ANOVA: whole brain volume and DX (groups)
############################################

## perform ANOVA/linear model in base R.
one_factor_anova <- lm(HIPPO ~ DX, data = hippo_dx_age)
summary(one_factor_anova)

## alternatively
one_factor_anova_alt <- aov(HIPPO ~ DX, data = hippo_dx_age)
summary(one_factor_anova_alt)

## now through car
car_one_factor_anova_type2 <- Anova(lm(HIPPO ~ DX, data = hippo_dx_age))
car_one_factor_anova_type3 <- Anova(lm(HIPPO ~ DX, data = hippo_dx_age), type="III")
(car_one_factor_anova_type2)
(car_one_factor_anova_type3)

## now through ez
ez_one_factor_anova <- ezANOVA(hippo_dx_age, dv=HIPPO, wid=SUBJECTS, between=DX, type=3, return_aov = TRUE)
(ez_one_factor_anova)

## and some Bayes Factors, for fun.
BF_one_factor_anova <- anovaBF(HIPPO ~ DX, data = hippo_dx_age)
(BF_one_factor_anova)



############################################
### "Simple" linear model/one-factor AN*C*OVA: whole brain volume and DX (groups) with DX corrected by age
############################################

## base R
one_factor_ancova_maineffects <- lm(HIPPO ~ DX + AGE, data = hippo_dx_age)
# one_factor_ancova_interaction <- lm(HIPPO ~ DX : AGE, data = hippo_dx_age)
# one_factor_ancova_fullmodel <- lm(HIPPO ~ DX * AGE, data = hippo_dx_age)
summary(aov(one_factor_ancova_maineffects))

## 'car' package
car_one_factor_ancova_maineffects <- Anova(lm(HIPPO ~ DX + AGE, data = hippo_dx_age), type="III")
(car_one_factor_ancova_maineffects)

## the 'ez' package
ez_one_factor_ancova <- ezANOVA(hippo_dx_age, dv=HIPPO, wid=SUBJECTS,  between=DX, between_covariates = AGE, type=3, return_aov = TRUE)
(ez_one_factor_ancova)

## the 'BayesFactor' package
BF_one_factor_ancova <- lmBF(HIPPO ~ DX + AGE, data = hippo_dx_age)
(BF_one_factor_ancova)

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

## or take a Bayesian approach



############################################
### Not as simple linear model/one-factor ANOVA: whole brain volume and DX (groups) with whole brain volume corrected by age
  ### arguably the most correct approach for the question at hand.
############################################

## We want to do this because we know age is a major contributor to brain volume (i.e., a confound with the DV)
  ### to note, age is not the only contributor, age, sex, and a variety of other confounds exist.
  ### here, we are keeping it simple with just AGE.

HIPPO_from_age <- lm(HIPPO ~ AGE, data = hippo_dx_age)
(HIPPO_from_age$residuals)
## we can now see that the HIPPO values are orthogonal to AGE
cor(HIPPO_from_age$residuals, hippo_dx_age$AGE)

## put the mean back in so our summary statistics make sense. 
HIPPO_residuals <- HIPPO_from_age$residuals + mean(hippo_dx_age$HIPPO)

## make a new DF
hippo_residuals_dx <- data.frame(
  SUBJECTS = rownames(amerge_subset),
  HIPPO_RESIDUALS = HIPPO_residuals,
  DX = hippo_dx_age$DX
)


## base R
one_factor_anova_adjusted <- lm(HIPPO_RESIDUALS ~ DX, data = hippo_residuals_dx)
summary(one_factor_anova_adjusted)

## base R -- alternative
one_factor_anova_adjusted_alt <- aov(HIPPO_RESIDUALS ~ DX, data = hippo_residuals_dx)
summary(one_factor_anova_adjusted_alt)

## base R, super lazy way:
summary(
  lm(lm(HIPPO ~ AGE, data = hippo_dx_age)$residuals ~ hippo_dx_age$DX)
)
## base R, super lazy alternate way:
summary(
  aov(lm(HIPPO ~ AGE, data = hippo_dx_age)$residuals ~ hippo_dx_age$DX)
)

## 'car' package
car_one_factor_anova_type3_adjusted <- Anova(lm(HIPPO_RESIDUALS ~ DX, data = hippo_residuals_dx), type="III")
(car_one_factor_anova_type3_adjusted)

## 'ez' package
ez_one_factor_anova_adjusted <- ezANOVA(hippo_residuals_dx, dv=HIPPO_RESIDUALS, wid=SUBJECTS, between=DX, type=3, return_aov = TRUE)
(ez_one_factor_anova_adjusted)


## 'BayesFactor' package
BF_one_factor_anova_adjusted <- anovaBF(HIPPO_RESIDUALS ~ DX, data = hippo_residuals_dx)
(BF_one_factor_anova_adjusted)
