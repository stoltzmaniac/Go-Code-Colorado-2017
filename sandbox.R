library(rjson)
library(dplyr)
library(googleVis)

creds = fromJSON(file = "credentials.json")

endpoint = paste("https://data.colorado.gov/resource/idu3-cuww.json?$$app_token=",creds$token,sep="")

cols = "*"
rows = 2000
offsetRows = 50
selections = paste("&$select=",cols,sep="")



request = paste(endpoint,query,sep="")

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
