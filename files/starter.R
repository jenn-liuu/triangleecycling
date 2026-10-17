library(tidyverse)
lines <- read_csv("bluesky_line_items.csv")
ships <- read_csv("bluesky_shipments.csv")
lot   <- read_csv("parts_lot_clean.csv")

# value share by group (weighted lines only, excludes ES Mix aggregate flat line)
lines %>% filter(line_type == "weighted") %>%
  group_by(commodity_group) %>%
  summarise(lbs = sum(net_lbs), usd = sum(line_total), usd_per_lb = usd/lbs) %>%
  arrange(desc(usd))

# Laptops_Mixed price over time
lines %>% filter(commodity_clean == "Laptops - Mixed") %>%
  ggplot(aes(ship_date, price_per_lb)) + geom_line() + geom_point()
