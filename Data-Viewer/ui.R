library(shiny)
library(DT)

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Data Viewer"),
    sidebarLayout(
        sidebarPanel(
            fileInput("uploaded_file", "Choose CSV File",
                      multiple = TRUE,
                      accept = c("text/csv",
                                 "text/comma-separated-values,text/plain",
                                 ".csv")),
            checkboxInput("header", "Header", TRUE),
            radioButtons("sep", "Separator",
                         choices = c(Semicolon = ";", Comma = ",", Tab = "\t"),
                         selected = ","),
            tags$hr(),
            radioButtons("disp", "Display",
                         choices = c(All = "all",
                                     Head = "head"),
                         selected = "all"),
            uiOutput("checkbox")
        ),
        mainPanel(
            tabsetPanel(
                id = "dataset",
                tabPanel("FILE", DT::dataTableOutput("rendered_file"))
            )
        )
    )
))
