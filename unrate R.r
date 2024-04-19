library(fredr)
library(ggplot2)
api_key <- "c8247afcd1a475a41a3bb69eef879aea"

fredr_set_key(api_key)


unrate_data <- fredr(series_id = "UNRATE", observation_start = as.Date("1990-01-01"), observation_end = as.Date("2000-01-01"))


actlis_data <- fredr(series_id = "RHORUSQ156N", observation_start = as.Date("1990-01-01"), observation_end = as.Date("2000-01-01"))


if (nrow(unrate_data) == 0 || nrow(actlis_data) == 0) {
  stop("One or both data series failed to load, check the series ID and your internet connection.")
}


data_merged <- merge(unrate_data, actlis_data, by = "date", all = TRUE)


plot <- ggplot(data_merged, aes(x = date)) +
  geom_line(aes(y = value.x, colour = "UNRATE"), size = 1) +
  geom_line(aes(y = value.y, colour = "RHORUSQ156N"), size = 1) +
  labs(title = "Comparison of Unemployment Rate and RHORUSQ156N",
       x = "Year",
       y = "Value",
       colour = "Series") +
  theme_minimal()


print(plot)

