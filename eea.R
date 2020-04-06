# eea.R
# EEA historical data
# IIASA, Apr 6, 2020

library(ggplot2)

# load combined data
aq <- read.csv("./austria/combined.csv")

aq$date <- substr(aq$DatetimeBegin, start = 1, stop = 10)
aq$date <- as.POSIXct(aq$date, origin='2019-01-01')

new <- aggregate(aq[, 7], list(aq$date, aq$AirPollutant, aq$AirQualityStationEoICode, aq$AirQualityStationType), mean)
names(new) <- c("date","AirPollutant","Station","Type","Concentration")

ggplot(data = new, aes(x = date, y = Concentration)) + geom_point(pch = 21)+
  facet_wrap(~Type, scales = "free", ncol = 1)+
  stat_smooth() +
  ggtitle("Austria NO2 All Stations")

ggsave("no2.png")
