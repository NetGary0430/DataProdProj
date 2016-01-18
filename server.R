library(shiny)
library(datasets)

# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output) {

  # By declaring datasetInput as a reactive expression we ensure 
  # that:
  #
  #  1) It is only called when the inputs it depends on changes
  #  2) The computation and result are shared by all the callers 
  #	  (it only executes a single time) USArrests dataset
  #  We are using the inputs from the ui file to select the 
  #  state of interest and the crime of interest to display results
  #
  datasetInput <- reactive({
    switch(input$crime,
           "Murder" = USArrests[input$state,1],
           "Assault" = USArrests[input$state,2],
           "Rape" = USArrests[input$state,4])
  })
  

  # The output$summary depends on the datasetInput reactive
  # expression, so will be re-executed whenever datasetInput is
  # invalidated
  # (i.e. whenever the input$dataset changes)
  output$summary <- renderPrint({
    dataset <- datasetInput()
    print(input$state)
    print(input$crime)
    head(dataset)
  })
  

})
