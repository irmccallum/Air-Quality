# joincsv.R
# join annual data for all stations, and metadata
# IIASA, Apr 6, 2020

md <- read.csv("metadata.csv")
md <- md[c(1,8,19,20)]

file.list <- list.files(path = "./austria/no2", pattern = "*.csv", include.dirs = T, full.names = T)

tables <- lapply(file.list, read.csv, header = TRUE)

combined.df <- do.call(rbind , tables)
combined.df <- combined.df[c(1,5,6,9,11:17)]

all <- merge(combined.df, md, by = c("Countrycode", "SamplingPoint"), all = TRUE)

write.csv(all, file = "./austria/combined.csv")
