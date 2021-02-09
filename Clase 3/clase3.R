#install.packages()
library(shiny)
library(shinydashboard)


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
                     menuItem("Primera ventana"),
                     menuSubItem("Primera sub-ventana"),
                    menuItem("Segunda ventana",id = "chartsID",
                             menuSubItem("Sub-ventana1"),
                             menuSubItem("Sub-ventana2"),
                             menuSubItem("Sub-ventana3",icon =icon("apple-pay"))
                    )
                    )

                    
                  ),
                  dashboardBody()
)

server <- function(input, output) { 
}

shinyApp(ui, server)