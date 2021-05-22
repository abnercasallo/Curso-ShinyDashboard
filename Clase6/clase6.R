#install.packages()
library(shiny)
library(shinydashboard)
#names(tag)
###CLASE 4
library(tidyverse)
#devtools::install_github("manosaladata/contrataciones-estado-emergencia", subdir="Roxygen/opencontracts")
library(opencontracts)

####PROCESANDO DATA##########
data("data120")
#View(data120)
#class(data120)

montos<-ggplot(data120[1:5,], aes(x =Proveedor, y=Monto_Soles_Millones))+ 
  geom_bar(stat="identity", position="dodge", fill="white",col="steelblue")+
  labs(title="MONTOS DE CONTRATOS ADJUDICADOS POR PROVEEDOR-TOP5", 
       subtitle="(en millones de soles)", y="Montos", x="Proveedor", caption="Manos a la data")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
montos

##############################
##########DASHBOARD###########
##############################

ui<-dashboardPage(title= "Dashboard", skin= "green",
                  dashboardHeader(title="PROYECTO",
                                  dropdownMenu(type="messages",
                                               messageItem(from="Abner",
                                                           "Hola"),
                                               messageItem(from = "Abner",
                                                           "No te olvides de compartir")
                                  ),
                                  dropdownMenu(type="notifications",
                                               notificationItem(text="No te olvides de seguir"),
                                               notificationItem(text="Saludos")
                                               
                                  ),
                                  dropdownMenu(type="tasks",
                                               taskItem(value=50,
                                                        text="Avance del dashboardHeader",
                                                        color="blue"),
                                               taskItem(value=10,
                                                        text="Avance del dashboardSidebar",
                                                        color="red")
                                  )
                                  
                  ),
                  dashboardSidebar(
                    sidebarSearchForm("searchText","buttonSearch","Buscar",icon = shiny::icon("apple"))
                    ,
                    sidebarMenu(id="sidebarID",
                     menuItem("Primera ventana", tabName = "montos"),
                     menuSubItem("Primera sub-ventana"),
                    menuItem("Segunda ventana",id = "chartsID",
                             menuSubItem("Sub-ventana1", tabName = "datos", icon = shiny::icon("eye")),
                             menuSubItem("video", tabName="video"),
                             menuSubItem("Sub-ventana3",icon =icon("apple-pay"))
                    )
                    )

                    
                  ),
                  dashboardBody(
                    
                    tabItems(tabItem(tabName = "datos", 
                                     DT::dataTableOutput("datos")
                                     
                    
                  ),
                  tabItem(tabName = "montos", 
                    
                    fluidRow(
                      column(width=9,  
                             valueBox("9 Meses","Periodo: Marzo-Diciembre",icon=icon("eye"),color="yellow"),
                             valueBoxOutput("valuebox"),
                             infoBox("Dato abiertos", "100%"),
                             ),
                      column(width=3, imageOutput("figura", width="10%",height="150px")),
                    fluidRow(box(title="GRÁFICO",plotOutput("montos"), width=9, status="primary", solidHeader=TRUE)))
                  
                  ),
                  tabItem(tabName="video", 
                          box(title="Video", tags$video(type = "video/mp4",src = "clase5.mp4", controls = "controls",
                                         height="150px", width="400px"), width=12, status="primary", solidHeader=TRUE))
                  
                  )
))

server <- function(input, output) { 
  
  redondeo <- function(x, k) as.numeric(trimws(format(round(x, k), nsmall=2)))
  output$datos<-DT::renderDataTable(data120)
  output$montos<-renderPlot({montos})
  output$valuebox<-renderInfoBox({valueBox(redondeo(sum((data120)[5])),"Monto Soles Millones", 
                                        icon=icon("money"),color="red")})
  output$figura <- renderImage({
    return(list(src = "www/img.png",contentType = "image/png"))
  })
}

shinyApp(ui, server)