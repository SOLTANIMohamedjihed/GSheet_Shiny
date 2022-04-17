

#load libraries
library(shiny)
library(shinydashboard)
library(googlesheets4)
library(DT)

ui <- fluidPage(

    # Define UI
    ui <- fluidPage(
        # App title ----
        titlePanel("Seflie Feedback"),
        # Sidebar layout with input and output definitions ----
        sidebarLayout(
            # Sidebar to demonstrate various slider options ----
            sidebarPanel(
                # Input: Overall Rating
                sliderInput(inputId = "helpful",
                            label = "I think this app is helpful",
                            min = 1,
                            max = 7,
                            value = 3),
                actionButton("submit", "Submit")
            ),
            mainPanel(
            ))
    )
)



server <- function(input, output, session) {
    # Reactive expression to create data frame of all input values ----
    sliderValues <- reactive({

        usefulRating <- input$helpful

        Data <-  data.frame(
            Value = as.character(usefulRating),
            stringsAsFactors = FALSE)
    })

    #This will add the new row at the bottom of the dataset in Google Sheets.
    observeEvent(input$submit, {
         MySheet <- gs4_find() #Obtain the id for the target Sheet
        MySheet <-   gs4_get('https://docs.google.com/spreadsheets/d/
        162KTHgd3GngqjTm7Ya9AYz4_r3cyntDc7AtfhPCNHVE/edit?usp=sharing')
        sheet_append(MySheet , data = Data)
    })
}
shinyApp(ui = ui, server = server)
