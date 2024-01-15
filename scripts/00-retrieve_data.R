library(opendatatoronto)
library(tidyverse)

ttc_bus_delay_package <- search_packages("TTC Bus Delay Data")
ttc_bus_delay_resource <- ttc_bus_delay_package |> list_package_resources()
ttc_bus_delay_statistics <- 
  ttc_bus_delay_resource |> 
  dplyr::filter(row_number()==n()) |> 
  get_resource()

write_csv(ttc_bus_delay_statistics, 'output/data/ttc_bus_delay_statistics.csv')