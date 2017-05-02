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
      menuItem("Above or Below Average", tabName = "barchart2", icon = icon("dashboard")),
      menuItem("Room Type Price", tabName = "barchart1", icon = icon("dashboard")),
      menuItem("Price Histogram", tabName = "histogram", icon = icon("dashboard")),
      menuItem("Population vs. Average Price", tabName = "scatter", icon = icon("dashboard")),
      menuItem("Average Price KPI", tabName = "kpi_table", icon = icon("dashboard")),
      menuItem("Boxplot", tabName = "boxplot", icon = icon("dashboard"))
    )
  ),
  dashboardBody(    
    tabItems(
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
                tabPanel("Barcharts", plotlyOutput("plot1", height=350), 
                                      plotlyOutput("plot2", height=350),
                                      plotlyOutput("plot3", height=350))
              )
      ),
     tabItem(tabName = "barchart2",
                tabsetPanel(
                  tabPanel("Data",  
                           actionButton(inputId = "click2",  label = "To get data, click here"),
                           hr(), # Add space after button 
                           DT::dataTableOutput("barchartData1")
                           
                
            ),
                  tabPanel("Barchart", plotlyOutput("barchartPlot1", height=500))
                )
      ),
     tabItem(tabName = "histogram",
             tabsetPanel(
               tabPanel("Data",  
                        actionButton(inputId = "click4",  label = "To get data, click here"),
                        hr(), # Add space after button 
                        DT::dataTableOutput("histogramData")
                        
                        
               ),
               tabPanel("Histogram", plotlyOutput("histogramPlot", height=500))
             )
     ),
     tabItem(tabName = "scatter",
             tabsetPanel(
               tabPanel("Data",  
                        actionButton(inputId = "click5",  label = "To get data, click here"),
                        hr(), # Add space after button 
                        DT::dataTableOutput("scatterData")
                        
                        
               ),
               tabPanel("Scatter Plot", plotlyOutput("scatterPlot", height=500))
             )
     ),
     tabItem(tabName = "kpi_table",
             tabsetPanel(
               tabPanel("Data",  
                        sliderInput("KPI1", "Average Price - Low:", 
                                    min = 0, max = 286,  value = 286),
                        sliderInput("KPI2", "Average Price - High:", 
                                    min = 286.01, max = 800,  value = 800),
                        actionButton(inputId = "click6",  label = "To get data, click here"),
                        hr(), # Add space after button 
                        DT::dataTableOutput("kpiData")
                        
                        
               ),
               tabPanel("KPI Table", plotlyOutput("kpiPlot", height=1500))
             )
     ),
     tabItem(tabName = "boxplot",
             tabsetPanel(
               tabPanel("Data",  
                        actionButton(inputId = "click7",  label = "To get data, click here"),
                        hr(), # Add space after button 
                        DT::dataTableOutput("boxplotData")
                        
                        
               ),
               tabPanel("Boxplot", plotlyOutput("boxplotPlot", height=500))
             )
     )
    
      
  )
)    
)