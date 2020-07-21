Linear_Regression <- function(data){
require(stats)
fit1 <- lm(prop~M, data = data)
x1<-summary(fit1)
adj.R.squared<-round(summary(fit1)$adj.r.squared,2)
p.value<-round(summary(fit1)$coefficients[2,4],3)

#output variables
out <- list('adj.R.squared' = adj.R.squared,'p.value' = p.value)
return(out)
}
