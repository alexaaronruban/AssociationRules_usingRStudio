#Rearrange basket according to invoice no
retail_basket <- retail_basket[order(retail_basket$ï..InvoiceNo),]
retail_basket$ï..InvoiceNo <- as.numeric(retail_basket$ï..InvoiceNo)
retail_basket$Description<-as.factor(retail_basket$Description)
str(retail_basket)
#Install plyr function to arrange the products according to their invoice no
install.packages("plyr")
library(plyr)
#Apply ddply function from plyr function
retail_basket1<- ddply(retail_basket,c("ï..InvoiceNo","InvoiceDate"), 
                       function(retail_basket)paste(retail_basket$Description, 
                                                    collapse = ","))
#Inspect changed data frame
head(retail_basket1)
str(retail_basket1)
#Get only the products column to the dataframe
retail_basket1<-retail_basket1[,3]
head(retail_basket1)
colnames(retail_basket1) <- c("item_list")
str(retail_basket1)
#Export dataframe to a csv file
write.csv(retail_basket1,"online_retail5.csv", row.names = TRUE)
