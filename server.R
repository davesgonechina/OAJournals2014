library(shiny)
library(RcppArmadillo)
library(forecast)
library(ggplot2)
library(datasets)
library(DT)

doaj <- read.csv("doaj_journals.csv", stringsAsFactors = FALSE)
doaj$APC <- sub("$","",doaj$APC, fixed=TRUE)
doaj$APC <- sub(",","",doaj$APC, fixed=TRUE)
doaj$APC <- as.numeric(doaj$APC)

bealls <- read.csv("belist_journals.csv", stringsAsFactors = FALSE)
bealls$APC <- sub("$","",bealls$APC, fixed=TRUE)
bealls$APC <- sub(",","",bealls$APC, fixed=TRUE)
bealls$APC <- as.numeric(bealls$APC)

all <-rbind(doaj,bealls,stringsAsFactors=FALSE)

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
    subjectDataset <- selectedDataset[selectedDataset$Group %in% subjects, ]
    gradesDataset <- subjectDataset[subjectDataset$Grade %in% grades, ]
    yearsDataset <- gradesDataset[gradesDataset$Start>=input$Years[1] & gradesDataset$Start<=input$Years[2], ]
    dataset <- yearsDataset[yearsDataset$APC>=input$APC[1] & yearsDataset$APC<=input$APC[2], ]
    ggplot(dataset, aes(x=Start)) + ggtitle("Distribution of Journals By Earliest of claimed or observed year") + xlab("Earliest Known Publication Start Date") + ylab("Total")  + xlim(input$Years[1],input$Years[2]) + geom_histogram(binwidth=1, colour="black", fill="white")      
  })

  output$apcPlot <- renderPlot({
    selectedDataset <- datasetInput()
    subjects <-as.character(input$subjectCheckboxes)
    grades <-as.character(input$gradeCheckboxes)
    subjectDataset <- selectedDataset[selectedDataset$Group %in% subjects, ]
    gradesDataset <- subjectDataset[subjectDataset$Grade %in% grades, ]
    yearsDataset <- gradesDataset[gradesDataset$Start>=input$Years[1] & gradesDataset$Start<=input$Years[2], ]
    dataset <- yearsDataset[yearsDataset$APC>=input$APC[1] & yearsDataset$APC<=input$APC[2], ]
    ggplot(dataset, aes(x=APC)) + ggtitle("Distribution of Journals By APC") + xlab("Article Processing Cost") + ylab("Total") + xlim(input$APC[1],input$APC[2]) + geom_histogram(binwidth=1, colour="black", fill="white")      
  })
  
  output$paidPlot <- renderPlot({
    selectedDataset <- datasetInput()
    subjects <-as.character(input$subjectCheckboxes)
    grades <-as.character(input$gradeCheckboxes)
    subjectDataset <- selectedDataset[selectedDataset$Group %in% subjects, ]
    gradesDataset <- subjectDataset[subjectDataset$Grade %in% grades, ]
    yearsDataset <- gradesDataset[gradesDataset$Start>=input$Years[1] & gradesDataset$Start<=input$Years[2], ]
    dataset <- yearsDataset[yearsDataset$APC>=input$APC[1] & yearsDataset$APC<=input$APC[2], ]
    ggplot(dataset, aes(x=Pay.Free.Unk.NA)) + ggtitle("Distribution of Journals by Paid or Free") + xlab("Free or Paid") + ylab("Total") + scale_x_discrete(breaks=c("F", "N", "P", "U"),  labels=c("Free (no fee)","Not applicable (Grades E-X)","Pay (APC)", "Unknown (Grade C)")) + geom_histogram(binwidth=1, colour="black", fill="white")      
  })
  
  output$subjectPlot <- renderPlot({
    selectedDataset <- datasetInput()
    subjects <-as.character(input$subjectCheckboxes)
    grades <-as.character(input$gradeCheckboxes)
    subjectDataset <- selectedDataset[selectedDataset$Group %in% subjects, ]
    gradesDataset <- subjectDataset[subjectDataset$Grade %in% grades, ]
    yearsDataset <- gradesDataset[gradesDataset$Start>=input$Years[1] & gradesDataset$Start<=input$Years[2], ]
    dataset <- yearsDataset[yearsDataset$APC>=input$APC[1] & yearsDataset$APC<=input$APC[2], ]
    ggplot(dataset, aes(x=Group)) + ggtitle("Distribution of Journals by Subject Group") + xlab("Subject Group") + ylab("Total") + scale_x_discrete(breaks=c("B", "E&L", "E&T", "Gen", "H", "M", "M&C", "P", "Sci", "SS", ""),  labels=c("B: Biology", "E&L: Earth & Life Sciences", "E&T: Engineering & Technology", "Gen: General", "H: Humanities", "M: Medicine", "M&C: Math & Computer Science", "P: Megajournals", "Sci: Sciences", "SS: Social Sciences", "Unknown")) + geom_histogram(binwidth=1, colour="black", fill="white")      
  })
  
  output$outputResults <- DT::renderDataTable({  selectedDataset <- datasetInput()
                                                 subjects <-as.character(input$subjectCheckboxes)
                                                 grades <-as.character(input$gradeCheckboxes)
                                                 subjectDataset <- selectedDataset[selectedDataset$Group %in% subjects, ]
                                                 gradesDataset <- subjectDataset[subjectDataset$Grade %in% grades, ]
                                                 yearsDataset <- gradesDataset[gradesDataset$Start>=input$Years[1] & gradesDataset$Start<=input$Years[2], ]
                                                 dataset <- yearsDataset[yearsDataset$APC>=input$APC[1] & yearsDataset$APC<=input$APC[2], ]
                                                 DT::datatable(dataset)})

})
