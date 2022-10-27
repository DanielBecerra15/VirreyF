
library(shiny)

server <- function(input, output) {
  output$plot_pte <- renderPlot({
    if(input$cancelacion == "NA"){
      base_1<-base
    } else{
      base_1<-base %>% filter(CANCELACION==input$cancelacion)
    }
    
    if(input$especialidad == "NA"){
      base_2<-base_1
    } else{
      base_2<-base_1 %>% filter(`ESPECIALIDAD TRATANTE`==input$especialidad)
    }
    base_3<- base_2 %>% 
      filter(`FECHA DE CIRUGIA`>=min(input$datarange) & `FECHA DE CIRUGIA`<=max(input$datarange)) %>% 
      select(`FECHA DE CIRUGIA`, `SALA DE CIRUGIA`,`PROCEDIMIENTO 1`,`TIPO DE ANESTESIA`) 
    base_4<- base_3 %>% 
      group_by(`FECHA DE CIRUGIA`) %>% 
      tally() %>% 
      as.data.frame() 
    
    ggplot(base_4,aes(`FECHA DE CIRUGIA`,n), xinch(x = 1))+
      geom_line(aes(col = "red"), 
                size = 1.5)+
      theme(axis.text = element_text(angle = 45),
            panel.grid.major.y = element_line(size = 0.01, colour = "black"),
            panel.grid.major.x = element_line(size = 0.01,colour = "black"))+
      geom_point(color="red", show.legend = T)+
      scale_x_date(date_breaks = "1 day")+
      labs(colour = "Pacientes")
  })
  
  output$num_pte <- renderText({
    if(input$cancelacion == "NA"){
      base_1<-base
    } else{
      base_1<-base %>% filter(CANCELACION==input$cancelacion)
    }
    
    if(input$especialidad == "NA"){
      base_2<-base_1
    } else{
      base_2<-base_1 %>% filter(`ESPECIALIDAD TRATANTE`==input$especialidad)
    }
    base_3<- base_2 %>% 
      filter(`FECHA DE CIRUGIA`>=min(input$datarange) & `FECHA DE CIRUGIA`<=max(input$datarange)) %>% 
      select(`FECHA DE CIRUGIA`, `SALA DE CIRUGIA`,`PROCEDIMIENTO 1`,`TIPO DE ANESTESIA`)
    n_ptes<- nrow(base_3)
    paste(n_ptes)
      
  })
  
  output$plot_esp <- renderPlot({
    if(input$cancelacion == "NA"){
      base_1<-base
    } else{
      base_1<-base %>% filter(CANCELACION==input$cancelacion)
    }
    
    if(input$especialidad == "NA"){
      base_2<-base_1
    } else{
      base_2<-base_1 %>% filter(`ESPECIALIDAD TRATANTE`==input$especialidad)
    }
    base_3<- base_2 %>% 
      filter(`FECHA DE CIRUGIA`>=min(input$datarange) & `FECHA DE CIRUGIA`<=max(input$datarange)) %>% 
      select(`FECHA DE CIRUGIA`, `SALA DE CIRUGIA`,`PROCEDIMIENTO 1`,`TIPO DE ANESTESIA`)
    ggplot(base_3,aes(x = `PROCEDIMIENTO 1`))+
      geom_bar(width = 0.5,colour = "blue", fill = "skyblue")+
      geom_text(aes(label = ..count..),
                stat = "count",
                position = position_dodge(1))+
      theme(axis.text = element_text(angle = 90,hjust = T),
            panel.grid.major.y = element_line(size = 0.01, colour = "black"))
  })
    

}

  shinyApp(ui, server )
     