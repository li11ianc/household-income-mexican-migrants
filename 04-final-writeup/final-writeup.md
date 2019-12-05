Characteristics of Recent Mexican Immigrants to the United States that
Influence Household Income
================
Ben 10
12/05/2019

Your project goes here\! Before you submit, make sure your chunks are
turned off with `echo = FALSE`.

You can add sections as you see fit. At a minimum, you should have the
following
sections:

## Section 1: Introduction (includes introduction and exploratory data analysis)

## Section 2: Regression Analysis (includes the final model and discussion of assumptions)

## Section 3: Discussion and Limitations

## Section 4: Conclusion

## Section 5: Additional Work

augment mig\_output \<- augment(model1) %\>% mutate(obs\_num =
row\_number()) .hat: leverage .cooksd: Cook’s distance .std.resid:
standardized residuals

leverage\_threshold \<- 2\*(5+1)/nrow(tips) ggplot(data = tips\_output,
aes(x = obs\_num,y = .hat)) + geom\_point(alpha = 0.7) +
geom\_hline(yintercept = leverage\_threshold,color = “red”)+ labs(x =
“Observation Number”,y = “Leverage”,title = “Leverage”) +
geom\_text(aes(label=ifelse(.hat \> leverage\_threshold,
as.character(obs\_num), "")), nudge\_x = 4)

tips\_output %\>% filter(.hat \> leverage\_threshold) %\>% select(Party,
Meal, Age)

ggplot(data = tips\_output, aes(x = .fitted,y = .std.resid)) +
geom\_point(alpha = 0.7) + geom\_hline(yintercept = 0,color = “red”) +
geom\_hline(yintercept = -2,color = “red”,linetype = “dotted”) +
geom\_hline(yintercept = 2,color = “red”,linetype = “dotted”) + labs(x
=“Predicted Value”,y =“Standardized Residuals”,title = “Standardized
Residuals vs. Predicted”) + geom\_text(aes(label =
ifelse(abs(.std.resid) \>2,as.character(obs\_num),"")), nudge\_x = 0.3)

Standardized residuals vs. predictors\!\!\! make plots

tips\_output %\>% filter(abs(.std.resid) \> 2) %\>% select(Party, Meal,
Age, Tip)

Estimate of regression standard deviation, σ̂, using all observations

glance(model1)$sigma Estimate of σ̂ without points with large magnitude
standardized residuals

tips\_output %\>% filter(abs(.std.resid) \<= 2) %\>%
summarise(sigma\_est = sqrt(sum(.resid^2)/(n() - 5 - 1)))

Recall that we use σ̂ to calculate the standard errors for all
confidence intervals and p-values, so outliers can affect conclusions
drawn from model

library(rms) tidy(vif(model1))
