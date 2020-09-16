source("read_data.R")
emiss_baltymore_by_type_by_year <- filter(NEI, fips == "24510") %>%
        select(Emissions, year, type) %>%
        group_by(year, type) %>% summarise(total_emiss = sum(Emissions))
plt <- ggplot(data = emiss_baltymore_by_type_by_year, aes(x = year, y = total_emiss))
plt <- plt + geom_line(aes(color = type), , size = 1) +
        labs(title = "Total emmisions in Baltimore by type in period 1999 - 2008", x = "Year", y = "Amount of PM2.5 emitted, in tons")
ggsave("plot3.png", device = "png")