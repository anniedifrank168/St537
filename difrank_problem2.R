#install.packages("lavaan")
#install.packages("sem")
library(lavaan)
library(sem)
lt <- sem::readMoments("data/EverittEx7.1.txt", diag = T) 
R <- (lt + t(lt)) - diag(1, 9)
R2 <- R[-9, -9]
R2

model <- specifyModel(text = "
## Specification of doctor factor
doctor      -> x1, lambda11, NA
doctor      -> x3, lambda31, NA
doctor      -> x4, lambda41, NA
doctor      -> x8, lambda81, NA
## Specification of Aspiration factor
patient     -> x2, lambda22, NA
patient     -> x5, lambda52, NA
patient     -> x6, lambda62, NA
patient     -> x7, lambda72, NA
## Uniquenesses for each variable
x1         <-> x1, psi1, NA
x2         <-> x2, psi2, NA
x3         <-> x3, psi3, NA
x4         <-> x4, psi4, NA
x5         <-> x5, psi5, NA
x6         <-> x6, psi6, NA
x7         <-> x7, psi7, NA
x8         <-> x8, psi8, NA
## Fixed variances for the two factors
doctor     <-> doctor, NA, 1
patient    <-> patient, NA, 1
## Correlation between two factors
doctor     <-> patient, rho, NA")

model

# Fit the model 
respons_sem <- sem(model = model, 
                   S = R2,
                   N = 123
)