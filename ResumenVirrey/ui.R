
library(shiny)

ui <- fluidPage(
  
  
  titlePanel("Estadistica UMEQ calle 100"),
  
  dateRangeInput(inputId = "datarange", label = "Rango: ", start = "2022-05-01", end = "2022-09-30"
                 ),
  selectInput(inputId = "cancelacion", label = "¿Procedimiento cancelado?",choices = c("SI","NO","NA"),selected = "NA"
              ),
  selectInput(inputId = "especialidad", label = "Seleccione especialidad: ", choices = unique(base$`ESPECIALIDAD TRATANTE`),selected = "NA"
              ),
  plotOutput(outputId = "plot_pte"),
  
  plotOutput(outputId = "plot_esp"),
  
  textOutput(outputId = "num_pte")
  
  
  
  
              
  )

