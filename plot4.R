# 4
# source("read_data.R")
coal_emiss <- select(SCC, SCC, SCC.Level.One, SCC.Level.Four) %>%
        filter(grepl("Combust.*",  x =  SCC.Level.One, ignore.case = T)) %>%
        filter(grepl("coal",  x =  SCC.Level.Four, ignore.case = T)) %>%
        left_join(select(NEI, SCC, year,Emissions), by = "SCC") %>% drop_na() %>%
        group_by(year) %>% summarise(total_emiss = sum(Emissions))

plt <- ggplot(data = coal_emiss, aes(x = year, y = total_emiss))
plt <- plt + geom_line(size = 1) +
        labs(title = "Total emmisions in USA from coal combustion-related sources in period 1999 - 2008", x = "Year", y = "Amount of PM2.5 emitted, in tons")
ggsave("plot4.png", device = "png")