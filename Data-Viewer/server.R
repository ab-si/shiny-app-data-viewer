library(shiny)
library(dplyr)

data("iris")

options(shiny.maxRequestSize=30*1024^2)

shinyServer(function(input, output, session) {
    
    df <- reactive({
        req(input$uploaded_file)
        read.csv(input$uploaded_file$datapath,
                 header = input$header,
                 sep = input$sep)  
        
    })
    
    output$checkbox <- renderUI({
        checkboxGroupInput(inputId = "select_var", 
                           label = "Select variables", 
                           choices = names(df()))
    })
    
    df_sel <- reactive({
        req(input$select_var)
        df_sel <- df() %>% select(input$select_var)
    })
    
    output$rendered_file <- DT::renderDataTable({
        if(input$disp == "head") {
            head(df_sel())
        }
        else {
            df_sel()
        }
    })
    
})
