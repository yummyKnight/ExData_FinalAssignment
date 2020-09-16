source("read_data.R")
changed_names <- list("24510" = "Baltimore City","06037" = "Los Angeles County")

NEI_prep <- select(NEI, SCC, year, Emissions, fips) %>% filter(fips == "24510" | fips == "06037")
emiss_balt_los_ang_on_road_by_year <- select(SCC, SCC, SCC.Level.Two) %>%
        filter(grepl("Highway Vehicles",  x =  SCC.Level.Two, ignore.case = T)) %>%
        left_join(NEI_prep, by = "SCC") %>% 
        select(fips, year, Emissions) %>% 
        drop_na() %>% 
        mutate(year = factor(year)) %>%
        group_by(year, fips) %>% summarise(total_emiss = sum(Emissions)) %>%
        mutate(fips = as.character(changed_names[fips]))


plt <- ggplot(data = emiss_balt_los_ang_on_road_by_year, aes(y = total_emiss, x = year))
plt <- plt + geom_col() + facet_grid(. ~ fips) + 
        labs(title = "Total emmisions in Baltimore from in period 1999 - 2008 from  motor vehicle sources", 
             x = "Year", y = "Amount of PM2.5 emitted, in tons")
ggsave("plot6.png", device = "png")