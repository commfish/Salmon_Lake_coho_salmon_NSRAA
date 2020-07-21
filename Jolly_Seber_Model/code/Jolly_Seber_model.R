#load libraries ----
library(FSA)
library(ggplot2)
library(extrafont)
library(readxl)
library(dplyr)
library(marked)
#https://www.rdocumentation.org/packages/FSA/versions/0.8.17

# data ----
#https://www.rdocumentation.org/packages/FSA/versions/0.8.17/topics/capHistConvert
nsraa <- read_excel("data/nsraa_2016.xlsx") 
# to 'individual' format
nsraa.I <- capHistConvert(nsraa,id="fish",in.type="RMark") 
# to 'frequency' format
nsraa.F <- capHistConvert(nsraa,id="fish",in.type="RMark",out.type="frequency") 
# to 'MARK' format
nsraa.M <- capHistConvert(nsraa,id="fish",in.type="RMark",out.type="MARK")
ex1.R2M$freq <- as.numeric(sub(";","",ex1.R2M$freq))
# to 'event' format
nsraa.E <- capHistConvert(ex1.E2R,id="fish",in.type="RMark",out.type="event") 

# analysis ---- 
##open population estimate
#https://www.rdocumentation.org/packages/FSA/versions/0.8.17/topics/capHistSum
#https://www.rdocumentation.org/packages/FSA/versions/0.8.17/topics/jolly
ch1 <- capHistSum(nsraa.I, cols2ignore="fish")# data.frame w/capture histories in “individual” format
ex1 <- mrOpen(ch1, type=c("Jolly"), conf.level=0.95)
x<-summary(ex1)
y<-confint(ex1,parm=c("N","phi"),verbose=TRUE)
x["B_star"] <- x$B*(log10(x$phi)/(x$phi-1)) #calculate a B star term at each i
column_sums<- t(as.data.frame(colSums(x[-1], na.rm=T)))
column_sums<-as.data.frame(column_sums)
B_star_sum<-column_sums$B_star #extract B_hat_sum from i=2 on
N2<-nth(x$N, 2) #extract N2
phi_1<-nth(x$phi, 1) #phi at i=1 is 0 
phi_1=0.001 #create a 'fake' phi at i=1
N_hat<-N2*(log10(phi_1)/(phi_1-1))+B_star_sum #calculate N_hat
N_hat #estimate of Jolly-Seber open population estimate 
write.csv(x, "output/mrOpen.csv")
write.csv(y, "output/mrOpen_CI.csv")

##closed population estimate
ch1 <- capHistSum(nsraa.I,cols2ignore="fish")
mr1 <- mrClosed(ch1, method="Schnabel", chapman.mod = TRUE)
mr2 <- mrClosed(ch1, method="SchumacherEschmeyer")
x<-summary(mr1)
y<-confint(mr1)
a<-summary(mr2)
b<-confint(mr2)
write.csv(x, "output/mrClosed_Schnabel.csv") 
write.csv(y, "output/mrClosed_Schnabel_CI.csv") 
write.csv(a, "output/mrClosed_Schum-Esch.csv") 
write.csv(b, "output/mrClosed_Sch-Esch_CI.csv") 
