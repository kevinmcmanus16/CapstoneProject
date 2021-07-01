#install(if not already) and load dplyr package
install.packages("dplyr")
library(dplyr)

#Upload datasets
OriginalChicagoCrimes <- read.csv('C:/Users/mcman/OneDrive/Documents/CSU/MIS581/Crimes_-_2001_to_Present.csv',header=TRUE, na.strings="0", stringsAsFactors=FALSE)
ChicagoWeather <- read.csv('C:/Users/mcman/OneDrive/Documents/CSU/MIS581/ChicagoWeather.csv',header=TRUE, na.strings="0", stringsAsFactors=FALSE)

#Replace NA values with 0
OriginalChicagoCrimes[is.na(OriginalChicagoCrimes)]=0
ChicagoWeather[is.na(ChicagoWeather)]=0

#Convert Date variable from character to date data type in both datasets
OriginalChicagoCrimes$Date = as.POSIXct(OriginalChicagoCrimes$Date, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
ChicagoWeather$DATE = as.POSIXct(ChicagoWeather$DATE, format="%m/%d/%Y")

#Convert Updated.On variable from character to date data type
OriginalChicagoCrimes$Updated.On = as.POSIXct(OriginalChicagoCrimes$Updated.On, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())

#Classify Primary.Type into property, nonviolent, and violent categories
OriginalChicagoCrimes$Primary.Type = ifelse(OriginalChicagoCrimes$Primary.Type %in% c("BURGLARY","THEFT","MOTOR VEHICLE THEFT","ARSON",
"CRIMINAL DAMAGE"), 1, ifelse(OriginalChicagoCrimes$Primary.Type %in% c("HOMICIDE","CRIM SEXUAL ASSAULT","ROBBERY","BATTERY","RITUALISM",
"ASSAULT","HUMAN TRAFFICKING"),3,2))

#Convert Domestic variable into an integer from character
OriginalChicagoCrimes$Domestic = ifelse(OriginalChicagoCrimes$Domestic %in% c("true"),1,0)

#Rename DATE column in weather dataset for join preparation
ChicagoWeatherFinal <- rename(ChicagoWeather, Date= DATE)

#Drop columns not needed for analysis
OriginalChicagoCrimes <- OriginalChicagoCrimes[-c(4,5,7,8,9,15,18,19)]
ChicagoWeatherFinal <- ChicagoWeatherFinal[-c(1,2,7,9)]

#Select crime data from 1/1/2014  through 12/31/2020
FilteredChicagoCrimes <- OriginalChicagoCrimes[(OriginalChicagoCrimes$Date>="2014-01-01" & OriginalChicagoCrimes$Date<="2020-12-31"),]

#Merge Datasets by Date
WeatherCrime <- merge(FilteredChicagoCrimes, ChicagoWeatherFinal, by = "Date", all=TRUE)

#Export merged dataset
write.csv(WeatherCrime, 'C:/Users/mcman/OneDrive/Documents/CSU/MIS581/ChicagoCrimeWeather.csv')


