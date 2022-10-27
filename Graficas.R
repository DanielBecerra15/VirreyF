fecha_i<-as.Date("2022-05-02")
fecha_f<-as.Date("2022-09-30")
#date_range<-fecha_i:fecha_f
cancelacion <- "NO"
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

# CONTADOR DE PACIENTES ---------------------------------------------------

base_3<- base_2 %>% 
  filter(`FECHA DE CIRUGIA`>=fecha_i & `FECHA DE CIRUGIA`<=fecha_f) %>% 
  select(`FECHA DE CIRUGIA`, `SALA DE CIRUGIA`,`PROCEDIMIENTO 1`,`TIPO DE ANESTESIA`) 
n_ptes<- nrow(base_3)
n_ptes

# GRAFICA DENSIDAD DE PACIENTES/TIEMPO ------------------------------------

base_4<- base_3 %>% 
  group_by(`FECHA DE CIRUGIA`) %>% 
  tally() %>% 
  as.data.frame() 

ggplot(base_4,aes(`FECHA DE CIRUGIA`,n), xinch(x = 1))+
  geom_line(aes(col = "red"), size = 1.2)

# GRAFICA PROCEDIMIENTOS --------------------------------------------------
base$`PROCEDIMIENTO 1`
ggplot(base,aes(x = `PROCEDIMIENTO 1`))+
  geom_bar()#+stat_count(geom = "text", aes(label = stat(count)))+scale_x_discrete()+coord_flip()
