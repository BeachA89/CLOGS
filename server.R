server <- function(input, output) {
  
  
  
  tab_Collateddata_1 <-  reactive({
    
    Collateddata%>%
      dplyr::filter(Swimmer %in% input$Swimmer) %>% 
      dplyr::filter(Stroke %in% input$Stroke)%>% 
      dplyr::filter(Start_type %in% input$Starttype)%>% 
      dplyr::filter(Measurement_date %in% input$Measurement_date)
    
  })  
  
  output$select_Swimmer <-  renderUI({
    selectizeInput('Swimmer', 'Select Swimmer', choices = c("select" = "", unique(Collateddata$Swimmer)), multiple =TRUE)  
  }) 
  
  output$select_Stroke <-  renderUI({
    inputSwimmer = as.character(input$Swimmer)
    choice_Stroke <- reactive({
      Collateddata %>% 
        dplyr::filter(Swimmer %in% inputSwimmer) %>% 
        pull(Stroke) %>% 
        as.character()
      
      
    })
    
    
    
    
    selectizeInput('Stroke', 'Select Stroke', choices = c("select" = "", choice_Stroke()), multiple =TRUE)  
  })    
  
  output$select_Starttype <-  renderUI({
    inputSwimmer = as.character(input$Swimmer)
    inputStroke = as.character(input$Stroke)
    choice_Starttype <- reactive({
      Collateddata %>% 
        dplyr::filter(Swimmer %in% inputSwimmer) %>% 
        dplyr::filter(Stroke %in% inputStroke) %>%
        pull(Start_type) %>% 
        as.character()
      
      
    })
    
    
    
    
    selectizeInput('Starttype', 'Select Start Type', choices = c("select" = "", choice_Starttype()), multiple =TRUE)  
  })
  
  output$select_Measurement_date <-  renderUI({
    inputSwimmer = as.character(input$Swimmer)
    inputStroke = as.character(input$Stroke)
    inputStarttype = as.character(input$Starttype)
    choice_Measurement_date <- reactive({
      Collateddata %>% 
        dplyr::filter(Swimmer %in% inputSwimmer) %>% 
        dplyr::filter(Stroke%in% inputStroke) %>%
        dplyr::filter(Start_type %in% inputStarttype) %>%
        pull(Measurement_date) %>% 
        as.character()
      
      
    })
    
    
    
    
    selectizeInput('Measurement_date', 'Select Date', choices = c("select" = "", choice_Measurement_date()), multiple =TRUE)  
  })
  
  
  #datafiltered <- Collateddata %>% dplyr::filter(Swimmer == "Ryan Hodierne", Stroke == "Breaststroke", Start_type == "Track L")#, Measurement_date == "15/11/2019")
  
  
  
  output$datatable_summary1 <-  DT::renderDataTable({
    input$goButton
    # if (input$Report_Type == "Distance Comparison"){
    #   datatable_Distance1 <- Distance_filter_1() %>% dplyr::select(Name, Competition, Round, Distance, AngleAvg, HVelAvg, RVelAvg, `Turn 1 Single`, `Turn 1 Double`, 
    #                                                                `Turn 2 Single`, `Turn 2 Double`,  `Turn 3 Single`, `Turn 3 Double`,
    #                                                                `Turn 4 Single`, `Turn 4 Double`)
    #   datatable_Distance2 <- Distance_filter_2() %>% dplyr::select(Name, Competition, Round, Distance, AngleAvg, HVelAvg, RVelAvg, `Turn 1 Single`, `Turn 1 Double`, 
    #                                                                `Turn 2 Single`, `Turn 2 Double`,  `Turn 3 Single`, `Turn 3 Double`,
    #                                                                `Turn 4 Single`, `Turn 4 Double`)
    #   
    #   datatable1 = bind_rows(datatable_Distance1,datatable_Distance2)
    #   ({datatable(datatable1, rownames= FALSE, colnames=c("Name", "Competition", "Round", "Distance", "Release Angle (deg)", "Hor Release Angle (deg)", "Release Vel (m/s)", "Turn 1 Single (s)",
    #                                                       "Turn 1 Double (s)", "Turn 2 Single (s)", "Turn 2 Double (s)", "Turn 3 Single (s)", "Turn 3 Double (s)", "Turn 4 Single (s)", "Double to Release (s)"), 
    #               options = list(columnDefs = list(list(className = 'dt-center', targets = "_all")), dom='t', order=list(list(3, 'desc')), scrollX = TRUE))})
    # } else {
    
    datatable_summary1 <- isolate(tab_Collateddata_1() %>% dplyr::select(Measurement_date, Measurement_time, Swimmer, Stroke, Age, Fatigue, Para, Relay, Suited))
    #datatable1[is.na(datatable1)] <- "X"
    ({datatable(datatable_summary1, rownames= FALSE, colnames=c("Date", "Time", "Swimmer", "Stroke", "Age", "Fatigue", "Para", "Relay", "Suited"),
                options = list(columnDefs = list(list(className = 'dt-center', targets = "_all")), scrollX = TRUE))})
    #
    
    #}
  })
  
  output$datatable_dive <-  DT::renderDataTable({
    input$goButton
    # if (input$Report_Type == "Distance Comparison"){
    #   datatable_Distance1 <- Distance_filter_1() %>% dplyr::select(Name, Competition, Round, Distance, AngleAvg, HVelAvg, RVelAvg, `Turn 1 Single`, `Turn 1 Double`, 
    #                                                                `Turn 2 Single`, `Turn 2 Double`,  `Turn 3 Single`, `Turn 3 Double`,
    #                                                                `Turn 4 Single`, `Turn 4 Double`)
    #   datatable_Distance2 <- Distance_filter_2() %>% dplyr::select(Name, Competition, Round, Distance, AngleAvg, HVelAvg, RVelAvg, `Turn 1 Single`, `Turn 1 Double`, 
    #                                                                `Turn 2 Single`, `Turn 2 Double`,  `Turn 3 Single`, `Turn 3 Double`,
    #                                                                `Turn 4 Single`, `Turn 4 Double`)
    #   
    #   datatable1 = bind_rows(datatable_Distance1,datatable_Distance2)
    #   ({datatable(datatable1, rownames= FALSE, colnames=c("Name", "Competition", "Round", "Distance", "Release Angle (deg)", "Hor Release Angle (deg)", "Release Vel (m/s)", "Turn 1 Single (s)",
    #                                                       "Turn 1 Double (s)", "Turn 2 Single (s)", "Turn 2 Double (s)", "Turn 3 Single (s)", "Turn 3 Double (s)", "Turn 4 Single (s)", "Double to Release (s)"), 
    #               options = list(columnDefs = list(list(className = 'dt-center', targets = "_all")), dom='t', order=list(list(3, 'desc')), scrollX = TRUE))})
    # } else {
    
    datatable_dive <- isolate(tab_Collateddata_1() %>% dplyr::select(Measurement_date, Measurement_time, Swimmer, Stroke, `Time_head_to_15_meter_(s)`, `Take-off_angle_(degrees)`, 
                                                                     `Trunk_angle_(degrees)`, `Hor._speed_flight_phase_(m/s)`, `Entry_angle_(degrees)`, `Length_of_entry_hole_(m)`, `Hor._distance_of_hip_entry_(m)`, `Maximal_depth_(m)`, `Hor._distance_of_first_leg_kick_(m)`,
                                                                     `Hor._distance_of_head_resurface_(m)`, "Hor._distance_between_first_leg_kick_and_1m_before_head_resurface_(m)", "Hor._speed_between_first_leg_kick_and_1m_before_head_resurface_(m/s)"))
    
    #datatable1[is.na(datatable1)] <- "X"
    ({datatable(datatable_dive, rownames= FALSE, colnames=c("Date", "Time", "Swimmer", "Stroke", "Head to 15m (s)", "Take-off angle (deg)", 
                                                            "Trunk angle (deg)", "Hor. speed flight phase (m/s)", "Entry angle (deg)", "Length of entry hole (m)", "Hor. distance of hip entry (m)", "Maximal depth (m)", "Hor. distance of first leg kick (m)",
                                                            "Hor. distance of head resurface (m)", "Hor. distance between first leg kick and 1m before head resurface (m)", "Hor. speed between first leg kick and 1m before head resurface (m/s)"),
                options = list(columnDefs = list(list(className = 'dt-center', targets = "_all")), scrollX = TRUE))})
    #
    
    #}
  })
  
  output$datatable_Horspeed <-  DT::renderDataTable({
    input$goButton
    # if (input$Report_Type == "Distance Comparison"){
    #   datatable_Distance1 <- Distance_filter_1() %>% dplyr::select(Name, Competition, Round, Distance, AngleAvg, HVelAvg, RVelAvg, `Turn 1 Single`, `Turn 1 Double`, 
    #                                                                `Turn 2 Single`, `Turn 2 Double`,  `Turn 3 Single`, `Turn 3 Double`,
    #                                                                `Turn 4 Single`, `Turn 4 Double`)
    #   datatable_Distance2 <- Distance_filter_2() %>% dplyr::select(Name, Competition, Round, Distance, AngleAvg, HVelAvg, RVelAvg, `Turn 1 Single`, `Turn 1 Double`, 
    #                                                                `Turn 2 Single`, `Turn 2 Double`,  `Turn 3 Single`, `Turn 3 Double`,
    #                                                                `Turn 4 Single`, `Turn 4 Double`)
    #   
    #   datatable1 = bind_rows(datatable_Distance1,datatable_Distance2)
    #   ({datatable(datatable1, rownames= FALSE, colnames=c("Name", "Competition", "Round", "Distance", "Release Angle (deg)", "Hor Release Angle (deg)", "Release Vel (m/s)", "Turn 1 Single (s)",
    #                                                       "Turn 1 Double (s)", "Turn 2 Single (s)", "Turn 2 Double (s)", "Turn 3 Single (s)", "Turn 3 Double (s)", "Turn 4 Single (s)", "Double to Release (s)"), 
    #               options = list(columnDefs = list(list(className = 'dt-center', targets = "_all")), dom='t', order=list(list(3, 'desc')), scrollX = TRUE))})
    # } else {
    
    datatable_Horspeed <- isolate(tab_Collateddata_1() %>% dplyr::select(Measurement_date, Measurement_time, Swimmer, Stroke, "timeStartsignal", "Time_hip_to_5_meter_(s)", "Time_hip_to_10_meter_(s)", "Time_hip_to_15_meter_(s)", "Hor._speed_at_5_meter_(m/s)",  "Hor._speed_at_10_meter_(m/s)",  "Hor._speed_at_15_meter_(m/s)", "Hor._speed_3-4_meter_(m/s)", "Hor._speed_4-5_meter_(m/s)",
                                                                         "Hor._speed_5-6_meter_(m/s)", "Hor._speed_6-7_meter_(m/s)", "Hor._speed_8-9_meter_(m/s)", "Hor._speed_9-10_meter_(m/s)", "Hor._speed_10-11_meter_(m/s)", "Hor._speed_11-12_meter_(m/s)", "Hor._speed_13-14_meter_(m/s)",
                                                                         "Hor._speed_14-15_meter_(m/s)"))
    
    #datatable1[is.na(datatable1)] <- "X"
    ({datatable(datatable_Horspeed, rownames= FALSE, colnames=c("Date", "Time", "Swimmer", "Stroke", "Start signal (s)", "Time hip to 5m (s)", "Time hip to 10m (s)","Time hip to 15m (s)", "Hor. speed at 5m (m/s)",  "Hor. speed at 10m (m/s)",  "Hor. speed at 15m (m/s)", "Hor. speed 3-4m (m/s)", "Hor. speed 4-5m (m/s)",
                                                                "Hor. speed 5-6m (m/s)", "Hor. speed 6-7m (m/s)", "Hor. speed 8-9m (m/s)", "Hor. speed 9-10m (m/s)", "Hor. speed 10-11m (m/s)", "Hor. speed 11-12m (m/s)", "Hor. speed 13-14m (m/s)",
                                                                "Hor. speed 14-15m (m/s)"),
                options = list(columnDefs = list(list(className = 'dt-center', targets = "_all")), scrollX = TRUE))})
    #
    
    #}
  })
  
  output$datatable_Depth <-  DT::renderDataTable({
    input$goButton
    # if (input$Report_Type == "Distance Comparison"){
    #   datatable_Distance1 <- Distance_filter_1() %>% dplyr::select(Name, Competition, Round, Distance, AngleAvg, HVelAvg, RVelAvg, `Turn 1 Single`, `Turn 1 Double`, 
    #                                                                `Turn 2 Single`, `Turn 2 Double`,  `Turn 3 Single`, `Turn 3 Double`,
    #                                                                `Turn 4 Single`, `Turn 4 Double`)
    #   datatable_Distance2 <- Distance_filter_2() %>% dplyr::select(Name, Competition, Round, Distance, AngleAvg, HVelAvg, RVelAvg, `Turn 1 Single`, `Turn 1 Double`, 
    #                                                                `Turn 2 Single`, `Turn 2 Double`,  `Turn 3 Single`, `Turn 3 Double`,
    #                                                                `Turn 4 Single`, `Turn 4 Double`)
    #   
    #   datatable1 = bind_rows(datatable_Distance1,datatable_Distance2)
    #   ({datatable(datatable1, rownames= FALSE, colnames=c("Name", "Competition", "Round", "Distance", "Release Angle (deg)", "Hor Release Angle (deg)", "Release Vel (m/s)", "Turn 1 Single (s)",
    #                                                       "Turn 1 Double (s)", "Turn 2 Single (s)", "Turn 2 Double (s)", "Turn 3 Single (s)", "Turn 3 Double (s)", "Turn 4 Single (s)", "Double to Release (s)"), 
    #               options = list(columnDefs = list(list(className = 'dt-center', targets = "_all")), dom='t', order=list(list(3, 'desc')), scrollX = TRUE))})
    # } else {
    
    datatable_Depth <- isolate(tab_Collateddata_1() %>% dplyr::select(Measurement_date, Measurement_time, Swimmer, Stroke, "Depth_at_3_meter_(m)", "Depth_at_4_meter_(m)", "Depth_at_5_meter_(m)", "Depth_at_6_meter_(m)", "Depth_at_meter_(m)", "Depth_at_8_meter_(m)", "Depth_at_9_meter_(m)",                    
                                                                      "Depth_at_10_meter_(m)", "Depth_at_11_meter_(m)", "Depth_at_12_meter_(m)", "Depth_at_13_meter_(m)", "Depth_at_14_meter_(m)", "Depth_at_15_meter_(m)",
    ))
    #datatable1[is.na(datatable1)] <- "X"
    ({datatable(datatable_Depth, rownames= FALSE, colnames=c("Date", "Time", "Swimmer", "Stroke", "Depth at 3m (m)", "Depth at 4m (m)", "Depth at 5m (m)", "Depth at 6m (m)", "Depth at 7m (m)", "Depth at 8m (m)", "Depth at 9m (m)",                    
                                                             "Depth at 10m (m)", "Depth at 11m (m)", "Depth at 12m (m)", "Depth at 13m (m)", "Depth at 14m (m)", "Depth at 15m (m)"), 
                options = list(columnDefs = list(list(className = 'dt-center', targets = "_all")), scrollX = TRUE))})
    #
    
    #}
  })
  
  
  
  output$Plot_Horspeed <-  renderPlot({
    input$goButton
    Plot_Horspeed <-  isolate(tab_Collateddata_1() %>% dplyr::select(ID,"Hor._speed_3-4_meter_(m/s)", "Hor._speed_4-5_meter_(m/s)",
                                                                     "Hor._speed_at_5_meter_(m/s)", "Hor._speed_5-6_meter_(m/s)", "Hor._speed_6-7_meter_(m/s)", "Hor._speed_8-9_meter_(m/s)", "Hor._speed_9-10_meter_(m/s)", 
                                                                     "Hor._speed_at_10_meter_(m/s)", "Hor._speed_10-11_meter_(m/s)", "Hor._speed_11-12_meter_(m/s)", "Hor._speed_13-14_meter_(m/s)",
                                                                     "Hor._speed_14-15_meter_(m/s)", "Hor._speed_at_15_meter_(m/s)") %>% 
                                reshape2::melt(id = c("ID")))
    
    ggplot(Plot_Horspeed, aes(x=variable, y=value, colour=ID)) + geom_line(aes(group=`ID`))+ ggtitle("Horizontal Speed") + theme(plot.title = element_text(hjust = 0.5)) +
      scale_x_discrete(name = "Distance", labels = c("3-4m", "4-5m", "5m", "5-6m","6-7m","8-9m", "9-10m", "10m", "10-11m", "11-12m", "13-14m", "14-15m", "15m")) + scale_y_continuous("Hor. Speed (m/s)") #+
    #scale_y_reverse()
    
  })
  
  
  
  output$Plot_Depth <-  renderPlot({
    input$goButton
    Plot_Depth <- isolate(tab_Collateddata_1() %>% dplyr::select(ID, "Depth_at_3_meter_(m)", "Depth_at_4_meter_(m)", "Depth_at_5_meter_(m)", "Depth_at_6_meter_(m)", "Depth_at_meter_(m)", "Depth_at_8_meter_(m)", "Depth_at_9_meter_(m)",                    
                                                                 "Depth_at_10_meter_(m)", "Depth_at_11_meter_(m)", "Depth_at_12_meter_(m)", "Depth_at_13_meter_(m)", "Depth_at_14_meter_(m)", "Depth_at_15_meter_(m)") %>% 
                            reshape2::melt(id = c("ID")))
    
    ggplot(Plot_Depth, aes(x=variable, y=value, colour=ID)) + geom_line(aes(group=`ID`))+ ggtitle("Depth") + theme(plot.title = element_text(hjust = 0.5)) +
      scale_x_discrete(name = "Distance", labels = c("3m", "4m", "5m", "6m","7m", "8m","9m", "10m", "11m", "12m", "13m", "14m", "15m")) + scale_y_reverse("Depth (m)")
    
  })
  
  
  
}
