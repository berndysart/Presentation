#Presentation

#packages----------------------
library(tidyverse)
library(haven)
library(patchwork)
library(forcats)
library(scales)

FctWhen = function(...){ #function that recodes elements of variables to either new titles or characters. 
  args = rlang::list2(...)
  rhs = map(args, rlang::f_rhs)
  cases = case_when(!!!args)
  exec(fct_relevel, cases, !!!rhs)
}

#data cleaning and loading
USD <- read_dta("events.dta")

USD2 = USD

USD = 
  USD |>
  mutate( #relabeling the values from numbers to characters
    TYPE = FctWhen(
      PTYPE == 10 ~ "General Warfare",
      PTYPE == 20 ~ "Inter-communal Warfare",
      PTYPE == 30 ~ "Armed Battle/Clash",
      PTYPE == 31 ~ "Armed Attack",
      PTYPE == 40 ~ "Pro-Government Terrorism (Repression)",
      PTYPE == 41 ~ "Anti-Government Terrorism",
      PTYPE == 42 ~ "Communal Terrorism",
      PTYPE == 50 ~ "Organised Violent Riot",
      PTYPE == 51 ~ "Spontaneous Violent Riot",
      PTYPE == 60 ~ "Organised Demonstration",
      PTYPE == 61 ~ "Pro-Government Demonstration",
      PTYPE == 62 ~ "Spontaneous Demonstration",
      PTYPE == 70 ~ "Other"
    )
  )

#first visualisation------------
USD |>  
  ggplot(aes(x = fct_infreq(TYPE), fill = TYPE))+ #inverts the order of the x-axis to be smallest to largest
  coord_flip(ylim = c(0,5000)) + #allows for all values to be seen on the graph
  geom_bar(show.legend = FALSE) +
  scale_y_continuous(
    expand = c(0,0), #removes the space between the y-axis and the x-axis
    labels = scales::percent) + #gives percentage along y-axis
  geom_text(
    stat = 'count', 
    aes(label = after_stat(round(count/sum(count)*100, digits = 1)), hjust = -0.5) #populates the proportion next to the graph and automatically rounds it
  ) +
  theme_minimal(base_size = 15) +
  theme(
    axis.title.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.line = element_line(colour = "black"),
    panel.background = element_blank(), 
    panel.grid = element_blank()
  ) +
  labs(
    y = "Percentage"
  )
#second visualisation-----------
USD2 = #creates a new data set
  USD |>
  summarise( #calculates total for global sample
    mean = mean(TARGET1 == "Government"),
  ) |>
  mutate( #creates a new variable in the data for binding later
    REGION = "Global"
  )
  
USD |>
  group_by(REGION) |>
  summarise(
    mean = mean(TARGET1 == "Government")
  ) |>
  bind_rows(USD2) |> #adds the created variable that acts as the global sample mean
  ggplot(aes(
    x = fct_rev(fct_infreq(REGION, mean)), 
    y = mean,
    fill = (REGION == "Global")
  )) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = round(mean*100, digits = 1)), hjust = -0.5) +
  coord_flip() +
  scale_y_continuous(
    expand = c(0,0),
    limits = c(0,0.5)
  ) +
  theme_minimal(base_size = 15) +
  theme(
    axis.line = element_line(colour = "black"),
    axis.title.y = element_blank(),
    axis.text.x = element_blank(),
    panel.background = element_blank(),
    panel.grid = element_blank()
  ) +
  labs(
    y = "Average"
  )
