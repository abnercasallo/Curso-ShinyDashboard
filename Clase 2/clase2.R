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
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output) { 
}

shinyApp(ui, server)