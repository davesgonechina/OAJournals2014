library(shiny)
library(RcppArmadillo)
library(forecast)
library(ggplot2)
library(datasets)

doaj <- read.csv("doaj_journals.csv")
doaj$APC <- sub("$","",doaj$APC, fixed=TRUE)
doaj$APC <- sub(",","",doaj$APC, fixed=TRUE)
doaj$APC <- as.numeric(doaj$APC)
doaj$APC[is.na(doaj$APC)] <- 0

bealls <- read.csv("belist_journals.csv")
bealls$APC <- sub("$","",bealls$APC, fixed=TRUE)
bealls$APC <- sub(",","",bealls$APC, fixed=TRUE)
bealls$APC <- as.numeric(bealls$APC)
bealls$APC[is.na(bealls$APC)] <- 0

all <-rbind(doaj,bealls)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  datasetInput <- reactive({
    switch(input$dataset,
           "DOAJ" = doaj,
           "Bealls (non-DOAJ)" = bealls,
           "All (DOAJ + Bealls)" = all)
  })
  
  output$distPlot <- renderPlot({
    selectedDataset <- datasetInput()
    subjects <-as.character(input$subjectCheckboxes)
    grades <-as.character(input$gradeCheckboxes)
    subjectDataset <- selectedDataset[selectedDataset$Area %in% subjects, ]
    dataset <- subjectDataset[subjectDataset$Grade %in% grades, ]
    ggplot(dataset, aes(x=Start)) + xlim(input$Years[1],input$Years[2]) + geom_histogram(binwidth=1, colour="black", fill="white")      
  })

  output$apcPlot <- renderPlot({
    selectedDataset <- datasetInput()
    subjects <-as.character(input$subjectCheckboxes)
    grades <-as.character(input$gradeCheckboxes)
    subjectDataset <- selectedDataset[selectedDataset$Area %in% subjects, ]
    dataset <- subjectDataset[subjectDataset$Grade %in% grades, ]
    ggplot(dataset, aes(x=APC)) +xlim(input$APC[1],input$APC[2]) + geom_histogram(binwidth=1, colour="black", fill="white")      
  })
    
})