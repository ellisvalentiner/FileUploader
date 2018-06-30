#
# This is a Shiny web application to demonstrate file uploading.
#

library(shiny)

ui <- fluidPage(

   titlePanel("File Uploader"),

   sidebarLayout(
      sidebarPanel(
        fileInput(
          inputId = "file1",
          label = "Choose file 1",
          multiple = FALSE
        ),
        fileInput(
          inputId = "file2",
          label = "Choose file 2",
          multiple = FALSE
        )
      ),

      mainPanel(
        textOutput(outputId = "summary"),
        tableOutput("file3")
      )
   )
)

server <- function(input, output) {

  output$summary <- renderText({
    readLines("summary.txt")
  })

  output$file3 <- renderTable({
    req(input$file1)
    req(input$file2)

    file1 <- read.csv(input$file1$datapath)
    file2 <- read.csv(input$file2$datapath)

    cbind(file1, file2)
  })

}

# Run the application
shinyApp(ui = ui, server = server)

