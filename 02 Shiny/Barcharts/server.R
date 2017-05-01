# server.R
require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(data.world)
require(readr)
require(DT)
require(leaflet)





shinyServer(function(input, output) { 
 


  
  
  df11 <- eventReactive(input$click1, {
    
      print("Getting from data.world")
      query(
        data.world(propsfile = "www/.data.world"),
        dataset="kurtakranz/s-17-dv-project-6", type="sql",
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
      dataset="kurtakranz/s-17-dv-project-6", type="sql",
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
      dataset="kurtakranz/s-17-dv-project-6", type="sql",
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
  
  output$plot1 <- renderPlot({
    ggplot(df11(), aes(x=factor(neighbourhood), y=average_price)) + geom_bar(stat = 'identity') + geom_hline(yintercept=365.8) + labs(title="Entire Room/Apt Prices") + theme_light()
  })
  
  output$plot2 <- renderPlot({
    ggplot(df12(), aes(x=factor(neighbourhood), y=average_price)) + geom_bar(stat = 'identity') + geom_hline(yintercept=105) + labs(title="Private Room Prices") + theme_light()
  })
  output$plot3 <- renderPlot({
    ggplot(df13(), aes(x=factor(neighbourhood), y=average_price)) + geom_bar(stat = 'identity') + geom_hline(yintercept=87.9) + labs(title="Shared Room Prices") + theme_light()
  })


  
  df2 <- eventReactive(input$click2, {
    
    print("Getting from data.world")
    query(
      data.world(propsfile = "www/.data.world"),
      dataset="kurtakranz/s-17-dv-project-6", type="sql",
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
  
  output$barchartPlot1 <- renderPlot({
    ggplot(df2(), aes(x=factor(neighbourhood), y=price_difference)) + geom_bar(stat = 'identity')
  })
  
  
  df3 <- eventReactive(input$click3, {
    
    print("Getting from data.world")
    query(
      data.world(propsfile = "www/.data.world"),
      dataset="kurtakranz/s-17-dv-project-6", type="sql",
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
    ggplot(df3(), aes(x=factor(neighbourhood), y=population)) + geom_bar(stat = 'identity')
  })

  
  
  output$barchartPlot3 <- renderPlot({
    ggplot(df3(), aes(x=factor(neighbourhood), y=average_price)) + geom_bar(stat = 'identity')
  })

} 
)