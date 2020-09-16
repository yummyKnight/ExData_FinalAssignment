# source("read_data.R")
NEI_req_data <- subset(NEI, year %in% c(1999, 2002, 2005, 2008))
total_emiss_by_year <- select(NEI_req_data,Emissions, year) %>% group_by(year) %>% summarise(total_emiss = sum(Emissions))
png("plot1.png")
barplot(total_emiss_by_year$total_emiss, names.arg = total_emiss_by_year$year, ylab = "Amount of PM2.5 emitted, in tons",xlab = "Year",
        main = "Total emissions from PM2.5 in the United States from 1999 to 2008")
dev.off()