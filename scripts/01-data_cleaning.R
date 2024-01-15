library(janitor)
library(dplyr)

raw_ttc_delay_data <- 
  read_csv(
    file = "output/data/ttc_bus_delay_statistics.csv",
    show_col_types = FALSE
  )

# Make the names easier to type
cleaned_ttc_delay_data <- clean_names(raw_ttc_delay_data)

# Remove irrelevant rows
cleaned_ttc_delay_data <- cleaned_ttc_delay_data |> 
  select(
    date, 
    route,
    time, 
    day, 
    # location removed since values varied too much to derive relationships
    # (~11,000 unique values for ~50,000 entries)
    # additionally, route provides similar info
    incident, 
    min_delay
    # min_gap removed since min_delay is the value we are interested in
    # direction removed since it is irrelevant
    # vehicle removed since it is irrelevant
  )

# Simplify incident names
cleaned_ttc_delay_data <- cleaned_ttc_delay_data |>
  mutate(
    incident =
      case_match(
        incident,
        "Diversion" ~ "Diversion",
        "Security" ~ "Safety",
        "Cleaning - Unsanitary" ~ "Safety",
        "Emergency Services" ~ "Safety",
        "Collision - TTC" ~ "Diversion",
        "Mechanical" ~ "Bus Issue",
        "Operations - Operator" ~ "Bus Issue",
        "Investigation" ~ "Safety",
        "Utilized Off Route" ~ "Other",
        "General Delay" ~ "General",
        "Road Blocked - NON-TTC Collision" ~ "Diversion",
        "Held By" ~ "Other",
        "Vision" ~ "Safety"
      )
  )

# save data
write_csv(cleaned_ttc_delay_data, 'output/data/cleaned_ttc_bus_delay_statistics.csv')



