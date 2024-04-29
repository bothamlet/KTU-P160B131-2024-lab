library(shiny)
library(ggplot2)
library(tidyverse)
library(jsonlite)

g_interface <- fluidPage(
  titlePanel("Įmonių vidutiniai atlyginimai per laikotarpį"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("kodas",
                     "Įmonės kodas",
                     choices = NULL)),
    
    mainPanel(
      tableOutput("table"),
      plotOutput("plot")
    )
  )
)

serv <- function(input, output, session) {
    data <- readRDS("../data/Data.rds")
  updateSelectizeInput(session, "kodas", choices = data$name, server = TRUE)
  output$plot <- renderPlot(
    data %>%
      filter(name == input$kodas) %>%
      ggplot(aes(x = ym(month), y = avgWage)) +
      geom_point() + 
      geom_line() +
      theme_classic() +
      labs(x = "Mėnesiai", y = "Vidutinis atlyginimas")
  )
}

shinyApp(ui = g_interface, server = serv)