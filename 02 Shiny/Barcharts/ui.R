#ui.R
require(shiny)
require(shinydashboard)
require(DT)
require(leaflet)

dashboardPage(
  dashboardHeader(
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Room Type Price", tabName = "barchart1", icon = icon("dashboard")),
      menuItem("Above or Below Average", tabName = "barchart2", icon = icon("dashboard")),
      menuItem("Population vs. Average Price", tabName = "barchart3", icon = icon("dashboard"))
    )
  ),
  dashboardBody(    
    tabItems(
      # Begin Crosstab tab content.
      tabItem(tabName = "barchart1",
              tabsetPanel(
                tabPanel("Data",  
                         
                         actionButton(inputId = "click1",  label = "To get data, click here"),
                         hr(), # Add space after button.
                         DT::dataTableOutput("data1"),
                         hr(),
                         DT::dataTableOutput("data2"),
                         hr(),
                         DT::dataTableOutput("data3")
                ),
                tabPanel("Barcharts", plotOutput("plot1", height=250), 
                                      plotOutput("plot2", height=250),
                                      plotOutput("plot3", height=250))
              )
      ),
     tabItem(tabName = "barchart2",
                tabsetPanel(
                  tabPanel("Data",  
                           actionButton(inputId = "click2",  label = "To get data, click here"),
                           hr(), # Add space after button 
                           DT::dataTableOutput("barchartData1")
                           
                
            ),
                  tabPanel("Barchart", plotOutput("barchartPlot1", height=500))
                )
      ),
     tabItem(tabName = "barchart3",
                tabsetPanel(
                  tabPanel("Data",
                           actionButton(inputId = "click3", label = "To get data, click here"), 
                           hr(),
                           DT::dataTableOutput("barchartData2")
                           
                           ),
                  tabPanel("Barcharts", plotOutput("barchartPlot2", height=300),                                  plotOutput("barchartPlot3", height=300))
                )
    )  
  )
)    
)