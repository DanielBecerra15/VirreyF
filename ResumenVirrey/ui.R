
library(shiny)
library(bslib)


ui <- fluidPage(
  theme = bs_theme(bootswatch = "spacelab"),
  
  titlePanel("Estadistica UMEQ calle 100"),
  fluidRow(
    column(width = 12),
    column(width  = 4, 
         offset = 8,
         textOutput(outputId = "num_pte"),
         class = "secondary"
    )
  ),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput(inputId = "datarange", 
                     label = "Rango: ", 
                     start = "2022-05-01", 
                     end = "2022-05-31"
      ),
      selectInput(inputId = "cancelacion", 
                  label = "¿Procedimiento cancelado?",
                  choices = c("SI","NO","NA"),
                  selected = "NA"
      ),
      selectInput(inputId = "especialidad", 
                  label = "Seleccione especialidad: ", 
                  choices = unique(base$`ESPECIALIDAD TRATANTE`),
                  selected = "NA"
      )
    ),
    mainPanel(
      
      plotOutput(outputId = "plot_pte"),
      
      plotOutput(outputId = "plot_esp")
    
      )
  )
  
)


