library(tidyverse)

#data is read into a dataframe but tidyverse reads it as tibbles

glimpse(telecom)

#want only customers whose churn is yes
telecom%>% filter(Churn == "yes") %>% select(MonthlyCharges,customerID)
#filter function from dplyr 

telecom$MonthlyCharges
is.na(telecom$MonthlyCharges)

telecom%>%distinct(MonthlyCharges)

#monthly charges of telecom 
telecom <- telecom%>%mutate(MonthlyCharges = replace(MonthlyCharges, is.na(MonthlyCharges), median(MonthlyCharges, na.rm = TRUE)))
telecom

#looking at totalcharges values we can see that na,NA and N/A values are present in the data and dplyr only identifies NA values
is.na(telecom$TotalCharges)

#count is 1 because only NA value is identified
telecom%>% summarise(count=sum(is.na(telecom$TotalCharges)))

#replace the N/A and na values with NA
telecom <- telecom%>%mutate(TotalCharges = replace(TotalCharges, TotalCharges=="na", NA))
telecom <- telecom%>%mutate(TotalCharges = replace(TotalCharges,TotalCharges=="N/A",NA))
sum(is.na(telecom$TotalCharges))

glimpse(telecom$TotalCharges)

#converting factor data into numeric values
telecom$TotalCharges <- as.numeric(telecom$TotalCharges)
glimpse(telecom$TotalCharges)

telecom <- telecom %>% mutate(PaymentMethod = replace(PaymentMethod, PaymentMethod=="--",NA))
is.na(telecom$PaymentMethod)
telecom
