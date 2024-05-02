# Presentation Assignment

## Introduction

This was an assignment for SIS-750 Data Analysis at American University in Washington DC. The project was to create a presentation using data of our choosing to evaluate a research interest. The assignment required that the entire presentation be produced within RStudio using xaringan or beamer then posted to github, being evaluated for its visualisations and code

## Research Topic

For this project, I decided to use one of the suggested data sets that interested me. As someone that is interested in nationalism, national identity, and populism, anything to do with people communicating disdain for the government or political mobilisation is of interest. For the data set I chose, I wanted to explore data that highlighted different forms of political and social mobilisation and get a basic understanding of participation and targets. 

## Data

The data that was used was from the Urban Social Disorder (USD) dataset. The USD dataset provides information on violent or political events on the city level. Data collected is for events across major cities internationally between 1960 to 2014. There are 33 variables with one particular variable coding 12 different types of events that occured around the world, in addition to targets, actors, deaths from the events, the year, the start and end date of the event and more. For this presentation, the frequency of the type of the events was explored as well as the average events that were primarily targeting the government. 

## Approach
- Cleaning
  - Recode the type variables from a numeric variable to a character variable
- Visualisation
  - Graph showing event type frequency in the form of percentage when compared side by side
  - Graph highlighting regional average of events primarily targeting the government
  
## Exemplary Code
- Mutated and created a new variable that renamed outcomes in the individual data set. 
  - Please see the rmd script in the r set up chunk

```
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
```
