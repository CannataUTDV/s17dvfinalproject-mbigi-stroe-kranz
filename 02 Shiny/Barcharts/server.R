# server.R
require(ggplot2)
require(dplyr)
require(shiny)
require(plotly)
require(shinydashboard)
require(data.world)
require(readr)
require(DT)
require(leaflet)
library(plotly)





shinyServer(function(input, output) { 
 


  
  
  df11 <- eventReactive(input$click1, {
    
      print("Getting from data.world")
      query(
        data.world(propsfile = "www/.data.world"),
        dataset="kurtakranz/s-17-dv-final-project", type="sql",
        query= "SELECT neighbourhood, room_type, avg(price) as average_price,
        SUM(price) as sum_price, count(neighbourhood) as count_neighbourhood
        
        
        
        from clean_listings_summary
        where room_type = 'Entire home/apt'
        group by neighbourhood, room_type
        order by neighbourhood"
      
      ) 
    }
)
    
  df12 <- eventReactive(input$click1, {
    
    print("Getting from data.world")
    query(
      data.world(propsfile = "www/.data.world"),
      dataset="kurtakranz/s-17-dv-final-project", type="sql",
      query= "SELECT neighbourhood, room_type, avg(price) as average_price,
      SUM(price) as sum_price, count(neighbourhood) as count_neighbourhood
      
      
      
      from clean_listings_summary
      where room_type = 'Private room'
      group by neighbourhood, room_type
      order by neighbourhood"
      
    ) 
  }
    )
  
  df13 <- eventReactive(input$click1, {
    
    print("Getting from data.world")
    query(
      data.world(propsfile = "www/.data.world"),
      dataset="kurtakranz/s-17-dv-final-project", type="sql",
      query= "SELECT neighbourhood, room_type, avg(price) as average_price,
      SUM(price) as sum_price, count(neighbourhood) as count_neighbourhood
      
      
      
      from clean_listings_summary
      where room_type = 'Shared room'
      
      group by neighbourhood, room_type
      order by neighbourhood"
      
    ) 
  }
    )
  
  output$data1 <- renderDataTable({DT::datatable(df11(), rownames = FALSE,
                  extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$data2 <- renderDataTable({DT::datatable(df12(), rownames = FALSE,
                                                 extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$data3 <- renderDataTable({DT::datatable(df13(), rownames = FALSE,
                                                 extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$plot1 <- renderPlotly({
    p <- ggplot(df11(), aes(x=factor(neighbourhood), y=average_price)) + geom_bar(stat = 'identity', color = "blue", fill = "lightblue") + geom_hline(yintercept=365.8) + labs(title="Entire Room/Apt Prices") + theme_light() + theme(text = element_text(size=8), axis.text.x = element_text(angle=90, hjust=1)) + labs(x = 'Zip Code')
    ggplotly(p)
  })
  
  output$plot2 <- renderPlotly({
    p <- ggplot(df12(), aes(x=factor(neighbourhood), y=average_price)) + geom_bar(stat = 'identity', color = "blue", fill = "lightblue") + geom_hline(yintercept=105) + labs(title="Private Room Prices") + theme_light() + theme(text = element_text(size=8), axis.text.x = element_text(angle=90, hjust=1)) + labs(x = 'Zip Code')
    ggplotly(p)
  })
  
  output$plot3 <- renderPlotly({
    p <- ggplot(df13(), aes(x=factor(neighbourhood), y=average_price)) + geom_bar(stat = 'identity', color = "blue", fill = "lightblue") + geom_hline(yintercept=105) + labs(title="Shared Room Prices") + theme_light() + theme(text = element_text(size=8), axis.text.x = element_text(angle=90, hjust=1)) + labs(x = 'Zip Code')
    ggplotly(p)
  })
  
 


  
  df2 <- eventReactive(input$click2, {
    
    print("Getting from data.world")
    query(
      data.world(propsfile = "www/.data.world"),
      dataset="kurtakranz/s-17-dv-final-project", type="sql",
      query= "SELECT neighbourhood, avg(price) as average_price, (avg(price) - 249.7) as price_difference
       
        from clean_listings_summary
        
        group by neighbourhood
        order by neighbourhood"
      
    ) 
  }
    )
  
  
  output$barchartData1 <- renderDataTable({DT::datatable(df2(), rownames = FALSE,
                         extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$barchartPlot1 <- renderPlotly({
    p <- ggplot(df2(), aes(x=factor(neighbourhood), y=price_difference)) + geom_bar(stat = 'identity', color="blue", fill="lightblue") + labs(x = 'Zip Code') + theme_light() + theme(text = element_text(size=8), axis.text.x = element_text(angle=90, hjust=1))
    ggplotly(p)
  })
  
  
  df3 <- eventReactive(input$click3, {
    
    print("Getting from data.world")
    query(
      data.world(propsfile = "www/.data.world"),
      dataset="kurtakranz/s-17-dv-final-project", type="sql",
      query= "SELECT cast(l.neighbourhood as string), p.B05001_001 as population, avg(price) as             average_price
      from clean_listings_summary l join 
      uscensusbureau.`acs-2015-5-e-foreignbirth`.`USA_ZCTA.csv/USA_ZCTA` p
      on (l.neighbourhood = p.ZCTA)
      group by l.neighbourhood
      order by l.neighbourhood"
      
    ) 
  }
    )
  
  
  output$barchartData2 <- renderDataTable({DT::datatable(df3(), rownames = FALSE,
                                                         extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$barchartPlot2 <- renderPlot({
    ggplot(df3(), aes(x=factor(neighbourhood), y=population)) + geom_bar(stat = 'identity') + labs(x = 'Zip Code')
  })

  
  
  output$barchartPlot3 <- renderPlot({
    ggplot(df3(), aes(x=factor(neighbourhood), y=average_price)) + geom_bar(stat = 'identity') + labs(x = 'Zip Code')
  })
  
  df_hist <- eventReactive(input$click4, {
    
    print("Getting from data.world")
    query(
      data.world(propsfile = "www/.data.world"),
      dataset="kurtakranz/s-17-dv-final-project", type="sql",
      query= "SELECT price 
       
        from clean_listings_summary
        where price < 4000"
      
    ) 
  }
  )
  
  output$histogramData <- renderDataTable({DT::datatable(df_hist(), rownames = FALSE,
                                                         extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
   output$histogramPlot <- renderPlotly({
     p <- ggplot(df_hist(), aes(x=price)) +
       geom_histogram(binwidth = 10, color = "blue") + theme_light()
     ggplotly(p)
  })
   
   df_scatter <- eventReactive(input$click5, {
     
     print("Getting from data.world")
     query(
       data.world(propsfile = "www/.data.world"),
       dataset="kurtakranz/s-17-dv-final-project", type="sql",
       query= "SELECT p.B05001_001 as population, avg(price) as average_price,
              neighbourhood
      from clean_listings_summary l join 
      uscensusbureau.`acs-2015-5-e-foreignbirth`.`USA_ZCTA.csv/USA_ZCTA` p
      on (l.neighbourhood = p.ZCTA)
      group by l.neighbourhood"
       
     ) 
   }
   )
   
   output$scatterData <- renderDataTable({DT::datatable(df_scatter(), rownames = FALSE,
                                                          extensions = list(Responsive = TRUE, FixedHeader = TRUE)
   )
   })
   
   output$scatterPlot <- renderPlotly({
     p <- ggplot(df_scatter(), aes(x=population, y=average_price, fill = neighbourhood)) +
       geom_point(color = "skyblue" )+ labs(x = 'Population per Zip Code') + geom_smooth(method=lm, se=FALSE) + guides(neighbourhood=FALSE) + theme_light()
     ggplotly(p)
   })
   
   KPI_Low = reactive({input$KPI1})     
   KPI_High = reactive({input$KPI2})
   
   df_kpi <- eventReactive(input$click6, {
     
     print("Getting from data.world")
     query(
       data.world(propsfile = "www/.data.world"),
       dataset="kurtakranz/s-17-dv-final-project", type="sql",
       query= "SELECT neighbourhood, room_type, avg(price) as avg_price,
       SUM(price) as sum_price, count(neighbourhood) as count_neighbourhood,
       
       case
       when (SUM(price) / COUNT(neighbourhood)) < ? then '03 Low'
       when (SUM(price) / COUNT(neighbourhood)) > ? then '01 High'
       else '02 Medium'
       end AS average_price
       
       from clean_listings_summary
       
       group by neighbourhood, room_type
       order by neighbourhood",
        queryParameters = list(KPI_Low(), KPI_High())
      ) 
    }
)
    
  output$kpiData <- renderDataTable({DT::datatable(df_kpi(), rownames = FALSE,
                  extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$kpiPlot <- renderPlotly({p <- ggplot(df_kpi()) + 
      
      geom_text(aes(x=room_type, y=factor(neighbourhood), label=round(avg_price, 2)), size=3) +
      geom_tile(aes(x=room_type, y=factor(neighbourhood), fill=average_price), alpha=0.50) + labs(x = 'Zip Code') + theme_light()
      ggplotly(p)
  })

  df_box <- eventReactive(input$click7, {
    
    print("Getting from data.world")
    query(
      data.world(propsfile = "www/.data.world"),
      dataset="kurtakranz/s-17-dv-final-project", type="sql",
      query= "SELECT price, cast(neighbourhood as string)
      
      from clean_listings_summary
      where neighbourhood in (78703, 78730, 78732, 78735, 78737)
      " 
      
    ) 
  }
    )
  
  output$boxplotData <- renderDataTable({DT::datatable(df_box(), rownames = FALSE,
                                                         extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$boxplotPlot <- renderPlotly({
    p <- ggplot(df_box(), aes(x=factor(neighbourhood), y=price)) + labs(x = 'Zip Code') + 
      geom_boxplot() + theme_light()
    ggplotly(p)
  })
  
  

  
  
} 
)