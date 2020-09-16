# source("read_data.R")
emiss_baltymore_by_year <- filter(NEI, fips == "24510") %>%
        select(Emissions, year) %>%
        group_by(year) %>% summarise(total_emiss = sum(Emissions))
png("plot2.png")
plot(emiss_baltymore_by_year,  type = "l", xaxt = "n", ylab = "Amount of PM2.5 emitted, in tons",xlab = "Year",
     main = "Total emissions from PM2.5 in in the Baltimore City from 1999 to 2008")
axis(side = 1, at = emiss_baltymore_by_year$year)
dev.off()