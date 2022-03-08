# Load Packages
library(flexdashboard)
library(tidyverse)
library(plotly)
library(DT)
library(viridis)
library(formattable)
library(radarchart)

# Load in our data
FootballData <- read_csv("data/Session6_ExampleData.csv")

# Create data
Disposals <- ggplot(FootballData) +
  geom_bar(mapping = aes(x = Quarter, fill = DisposalType),
           position = "dodge") +
  scale_fill_viridis_d()

# Make this interactive - to give us the number of Disposals per Quarter
ggplotly(Disposals)


Disposals <- ggplot(FootballData) +
  geom_bar(mapping = aes(x = DisposalType, fill = Athlete),
           position = "stack") +
  scale_fill_viridis_d()

# Make this interactive - to give us the number for Athletes total disposals
ggplotly(Disposals)

# Table/Report
# Create a table using the DT Package
DataTidied <- FootballData %>%
  group_by(Athlete, Quarter) %>% 
  summarise(DisposalType) %>% 
  mutate(across(where(is.numeric), round, 1))
# Call the DT Package
datatable(FootballData, extensions = 'Buttons',
          options = list(
            dom = 'Bfrtip',
            buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
          )
)