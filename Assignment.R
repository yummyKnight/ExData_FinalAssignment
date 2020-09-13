library(dplyr)
library(tidyr)
library(ggplot2)
# 1
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")
# NEI_req_data <- subset(NEI, year %in% c(1999, 2002, 2005, 2008))
# total_emiss_by_year <- select(NEI_req_data,Emissions, year) %>% group_by(year) %>% summarise(total_emiss = sum(Emissions)) 
# barplot(total_emiss_by_year$total_emiss, names.arg = total_emiss_by_year$year, ylab = "Amount of PM2.5 emitted, in tons",xlab = "Year",
#         main = "Total emissions from PM2.5 in the United States from 1999 to 2008")
# 2
# emiss_baltymore_by_year <- filter(NEI, fips == "24510") %>%
#         select(Emissions, year) %>% 
#         group_by(year) %>% summarise(total_emiss = sum(Emissions))
# plot(emiss_baltymore_by_year,  type = "l", xaxt = "n")
# axis(side = 1, at = emiss_baltymore_by_year$year)
# 3
# emiss_baltymore_by_type_by_year <- filter(NEI, fips == "24510") %>%
#         select(Emissions, year, type) %>%
#         group_by(year, type) %>% summarise(total_emiss = sum(Emissions))
# plt <- ggplot(data = emiss_baltymore_by_type_by_year, aes(x = year, y = total_emiss))
# plt <- plt + geom_line(aes(color = type), , size = 1) + 
#         labs(title = "Total emmisions in Baltimore by type in period 1999 - 2008", x = "Year", y = "Amount of PM2.5 emitted, in tons")
# plt
# 4
# find_coal <- function(string) { 
#         t <- grep("coal",  x =  unique(string), ignore.case = T, value = T)
#         return(t)
# }
find_combust <- function(string){
        t <- grep("Combust.*",  x =  unique(string), ignore.case = T, value = T)
        return(t)
}
# coal_emiss <- select(SCC, SCC, SCC.Level.One, SCC.Level.Four) %>% 
#         filter(SCC.Level.One %in% find_combust(SCC.Level.One)) %>%
#         filter(SCC.Level.Four %in% find_coal(SCC.Level.Four)) %>%
#         left_join(select(NEI, SCC, year,Emissions), by = "SCC") %>% drop_na() %>%
#         group_by(year) %>% summarise(total_emiss = sum(Emissions))
# 
# plt <- ggplot(data = coal_emiss, aes(x = year, y = total_emiss))
# plt <- plt + geom_line(size = 1) +
#         labs(title = "Total emmisions in USA from coal combustion-related sources in period 1999 - 2008", x = "Year", y = "Amount of PM2.5 emitted, in tons")
# plt
#5
# NEI_prep <- select(NEI, SCC, year, Emissions, fips) %>% filter(fips == "24510" )
# emiss_baltymore_on_road_by_year <- select(SCC, SCC, SCC.Level.Two) %>%
#         filter(grepl("Highway Vehicles",  x =  SCC.Level.Two, ignore.case = T)) %>%
#         left_join(NEI_prep, by = "SCC") %>% drop_na() %>%
#         group_by(year) %>% summarise(total_emiss = sum(Emissions))
# 
# plt <- ggplot(data = emiss_baltymore_on_road_by_year, aes(x = year, y = total_emiss))
# plt <- plt + geom_line(size = 1) +
#         labs(title = "Total emmisions in Baltimore from in period 1999 - 2008 from  motor vehicle sources", 
#              x = "Year", y = "Amount of PM2.5 emitted, in tons")
# plt
#6
NEI_prep <- select(NEI, SCC, year, Emissions, fips) %>% filter(fips == "24510" | fips == "06037")
emiss_balt_los_ang_on_road_by_year <- select(SCC, SCC, SCC.Level.Two) %>%
        filter(grepl("Highway Vehicles",  x =  SCC.Level.Two, ignore.case = T)) %>%
        left_join(NEI_prep, by = "SCC") %>% drop_na() %>%
        group_by(year, fips) %>% summarise(total_emiss = sum(Emissions))

plt <- ggplot(data = emiss_balt_los_ang_on_road_by_year, aes(x = year, y = total_emiss))
plt <- plt + geom_line(size = 1, aes(color = fips)) +
        labs(title = "Total emmisions in Baltimore from in period 1999 - 2008 from  motor vehicle sources", 
             x = "Year", y = "Amount of PM2.5 emitted, in tons")
plt