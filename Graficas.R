fecha_i<-as.Date("2022-08-01")
fecha_f<-as.Date("2022-10-01")
cancelacion <- "NA"
especialidad<- "NA"


if(cancelacion == "NA"){
  base_1<-base
} else{
  base_1<-base %>% filter(CANCELACION==cancelacion)
}

if(especialidad == "NA"){
  base_2<-base_1
} else{
  base_2<-base_1 %>% filter(`ESPECIALIDAD TRATANTE`==especialidad)
}

n_ptes<- base_2 %>% 
  filter(`FECHA DE CIRUGIA`>=fecha_i & `FECHA DE CIRUGIA`<= fecha_f) %>% 
  select(`SALA DE CIRUGIA`) %>% 
  nrow()
n_ptes
