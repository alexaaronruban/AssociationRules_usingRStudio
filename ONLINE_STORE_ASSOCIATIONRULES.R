library(arules)
library(arulesViz)
library(tidyverse)
install.packages("knitr")
library(knitr)
library(ggplot2)
library(lubridate)
library(plyr)
library(dplyr)

retail_txn<-read.transactions("C:/Users/Alex Aaron/Documents/DATA SCIENCE CLASS NOTES/COURSEWORK/COURSEWORK-ASDM/ASSOCIATION RULES COURSEWORK/retail_0.csv",format='basket',sep=',')
retail_txn
#Convert it into transaction object
trObj_0<-as(retail_txn,"transactions")
summary(trObj_0)
knitr::opts_chunk$set(fig.width=8, fig.height=8) 

#Plot of top 20 items
if (!require("RColorBrewer")) {
  # install color package of R
  install.packages("RColorBrewer")
  #include library RColorBrewer
  library(RColorBrewer)
}
itemFrequencyPlot(trObj_0,topN=20,type="absolute",col=brewer.pal(8,'Pastel2'), main=" Item Frequency Plot",fig_chunk(fig.width))

itemFrequencyPlot(trObj_0,topN=20,type="relative",col=brewer.pal(8,'Pastel2'),main="Relative Item Frequency Plot")

retail_rules<-apriori(trObj_0,parameter=list(supp=0.01,conf=0.6,maxlen=4))
retail_rules
summary(retail_rules)
inspect(retail_rules)
#Remove redundant rules
sub.rules <- which(colSums(is.subset(retail_rules, retail_rules)) > 1) # get subset rules in vector
length(sub.rules) 
subset.retail_rules <- retail_rules[-sub.rules]
#Plot the association rules
plot(retail_rules,method="grouped",topN=20)


#Buying with JAM JAR WITH GREEN LID
retail_rules1<-apriori(trObj_0,parameter=list(supp=0.001,conf=0.8),appearance=list(default="lhs",rhs="JAM JAR WITH GREEN LID"))
summary(retail_rules1)
inspect(retail_rules1)
plot(retail_rules1,method="grouped")
#Buying with HAND WARMER UNION JACK
retail_rules2<-apriori(trObj_0,parameter=list(supp=0.001,conf=0.7),appearance=list(default="lhs",rhs="HAND WARMER UNION JACK"))
summary(retail_rules2)
inspect(retail_rules2)
plot(retail_rules2,method="grouped")
#Rules for Regency Tea Plate Pink
retail_rules3<-apriori(trObj_0,parameter=list(supp=0.003,conf=0.9),appearance=list(default="lhs",rhs="REGENCY TEA PLATE PINK"))
summary(retail_rules3)
inspect(retail_rules3)
plot(retail_rules3)
#Rules for Regency Milk Jug Pink
retail_rules4<-apriori(trObj_0,parameter=list(supp=0.003,conf=0.8),appearance=list(default="lhs",rhs="REGENCY MILK JUG PINK"))
summary(retail_rules4)
inspect(retail_rules4)
plot(retail_rules4)
plot(retail_rules4,method="grouped")
