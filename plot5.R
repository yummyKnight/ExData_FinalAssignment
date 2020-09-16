# source("read_data.R")
NEI_prep <- select(NEI, SCC, year, Emissions, fips) %>% filter(fips == "24510" )
emiss_baltymore_on_road_by_year <- select(SCC, SCC, SCC.Level.Two) %>%
        filter(grepl("Highway Vehicles",  x =  SCC.Level.Two, ignore.case = T)) %>%
        left_join(NEI_prep, by = "SCC") %>% drop_na() %>%
        group_by(year) %>% summarise(total_emiss = sum(Emissions))

plt <- ggplot(data = emiss_baltymore_on_road_by_year, aes(x = year, y = total_emiss))
plt <- plt + geom_line(size = 1) +
        labs(title = "Total emmisions in Baltimore from in period 1999 - 2008 from  motor vehicle sources",
             x = "Year", y = "Amount of PM2.5 emitted, in tons")
ggsave("plot5.png", device = "png")