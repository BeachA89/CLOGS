

ui <- dashboardPage(
    dashboardHeader (title = "CLOGS database", titleWidth = 450),
    dashboardSidebar(
        # fileInput("file1", "Choose files", multiple = TRUE,
        #           accept = c("text/csv",
        #                      "text/comma-separated-values,text/plain",
        #                      ".csv")),
        # actionButton("goButton", "Go!"),
        
        # selectInput("distance", "Distance:",
        #             choices = c("500" = "Labelled_data_500",
        #                         "1000" = "Labelled_data_1000")),
        # selectInput("Report_Type", "Report Type:",
        #             c("Single Race" = "Single Race",
        #               "Two Races" = "Two Races",
        #               "vs Top 10" = "vs Top 10")),    
        uiOutput("select_Swimmer"),
        uiOutput("select_Stroke"),
        uiOutput("select_Starttype"),
        #selectInput("Report_Type", "Report Type:",
        #            c("Single Comp" = "Single Comp",
        #              "Distance Comparison" = "Distance Comparison"))  
        
        uiOutput("select_Measurement_date"),
        # selectInput("Distance1", "Distance:",
        #             choices = c(">70" = ">70",
        #                         "68-70" = "68-70",
        #                         "66-68" = "66-68",
        #                         "64-66" = "64-66")),
        # selectInput("Distance2", "Distance:",
        #             choices = c(">70" = ">70",
        #                         "68-70" = "68-70",
        #                         "66-68" = "66-68",
        #                         "64-66" = "64-66"))
        actionButton("goButton", "Show data")
        
    ),
    dashboardBody(
        
        fluidRow(
            box(title = "Swimmer Information", status = "primary", solidHeader = TRUE, width = 12,
                collapsible = FALSE,
                DT::dataTableOutput("datatable_summary1"))
        ),
        fluidRow(
            box(title = "Dive", status = "primary", solidHeader = TRUE, width = 12,
                collapsible = FALSE,
                DT::dataTableOutput("datatable_dive"))
        ),
        
        fluidRow(
            box(title = "Horizontal Speed", status = "primary", solidHeader = TRUE, width = 12,
                collapsible = FALSE,
                DT::dataTableOutput("datatable_Horspeed"))
        ),
        
        
        fluidRow(
            box(title = "", status = "primary", solidHeader = TRUE,width = 12,
                collapsible = FALSE,plotOutput("Plot_Horspeed"))
        ),
        
        fluidRow(
            box(title = "Depth", status = "primary", solidHeader = TRUE, width = 12,
                collapsible = FALSE,
                DT::dataTableOutput("datatable_Depth"))
        ),
        
        fluidRow(
            box(title = "", status = "primary", solidHeader = TRUE,width = 12,
                collapsible = FALSE,plotOutput("Plot_Depth"))
        )
        
        #fluidRow(
        #    box(title = "Distance Comparison", status = "primary", solidHeader = TRUE, width = 12,
        #        collapsible = TRUE,
        #        DT::dataTableOutput("datatable_comparison"))
        #)
        
        #    fluidRow(
        #      box(title = "Time vs Top 10 average", status = "primary", solidHeader = TRUE,width = 12,
        #          collapsible = TRUE,plotOutput("ggplot"))
        #    )
        
        
        
    )
    
)










# Create Shiny app ----
# shinyApp(ui, server)