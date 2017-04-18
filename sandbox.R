library(rjson)
library(dplyr)
library(googleVis)
library(RCurl)

creds = fromJSON(file = "credentials.json")

endpoint = paste("https://data.colorado.gov/resource/idu3-cuww.json?$$app_token=",creds$token,sep="")

cols = "*"
limitRows = as.character(2000)
offsetRows = as.character(50)
selections = paste("&$select=",cols,sep="")
queryAPI = paste(selections,'&$limit=',limitRows,'&$offset=',offsetRows,sep='')
request = paste(endpoint,queryAPI,sep="")

data = fromJSON(getURL(request))

df = data %>%
  select(mailzipcode,
         city,
         state,
         licensetype,
         licenseexpirationdate,
         licensestatusdescription,
         licensefirstissuedate,
         licenselastreneweddate,
         degrees,
         firstname,
         lastname)

library(lubridate)
df$yearsToExpiration = round(as.numeric(as.Date(df$licenseexpirationdate) - today())/365,1)
a = df[is.na(df$licenseexpirationdate) == FALSE,]
b = a %>% filter(yearsToExpiration>0)
