library(shiny)
if (!require("DT")) install.packages('DT')


shinyUI(fluidPage(
  
  # Application title
  titlePanel("2014 Open Access Journals Analysis"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h3("This app uses data from Walt Crawford's Cites & Insights research"),
      a("PDF", href="http://citesandinsights.info/civ15i3.pdf", target="_blank"),
      p("Excel files available on FigShare"),
      a("DOAJ XLSX File", href="http://figshare.com/articles/Open_Access_Journals_2014_DOAJ_subset/1299451", target="_blank"),
      p(""),
      a("Beall XLSX File", href="http://figshare.com/articles/Open_Access_Journals_2014_Beall_list_not_in_DOAJ_subset/1299452", target="_blank"),
      p("The first dataset is from the Directory of Open Access Journals (DOAJ), while the second comprises journals on Jeffrey Beall's \"predatory\" journal list that do not appear in the DOAJ."),
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("DOAJ", "Bealls (non-DOAJ)", "All (DOAJ + Bealls)"),
                  selected = "All (DOAJ + Bealls)"),
      p("Crawford categorized the journals according to general fields. MegaJournals, such as PLoS One, do not necessarily confine themselves to any field."),
      checkboxGroupInput("subjectCheckboxes", "Choose subject group",
                  choices = c("B: Biology" = "B",
                              "E&L: Earth & Life Sciences" = "E&L",
                              "E&T: Engineering & Technology" = "E&T",
                              "Gen: General" = "Gen",
                              "H: Humanities" = "H",
                              "M: Medicine" = "M",
                              "M&C: Math & Computer Science" = "M&C",
                              "P: Megajournals" = "P",
                              "Sci: Sciences" = "Sci",
                              "SS: Social Sciences" = "SS",
                              "Unknown" = ""), 
                  selected = c("B","E&L","E&T","Gen", "H","M","M&C","P","Sci","SS","")),
      p("Crawford also graded journals on quality according to several categories."),
      checkboxGroupInput("gradeCheckboxes", "Journal Quality Grade",
                         choices = c("A: Apparently good" = "A", 
                                     "B: May need investigation" = "B",
                                     "C: Highly questionable" = "C",
                                     "DC: Ceased" = "DC",
                                     "DD: Apparently dying" = "DD",
                                     "DE: Erratic" = "DE",
                                     "DH: Hiatus" = "DH",
                                     "DN: New" = "DN",
                                     "DS: Small" = "DS",
                                     "E: Empty" = "E",
                                     "EC: Empty/ceased" = "EC",
                                     "H: Hybrid" = "H",
                                     "N: Not OA" = "N",
                                     "O: Opaque" = "O",
                                     "X: Unreachable/unworkable" = "X"),
                         selected = c("A","B","C","DC","DD","DE","DH","DN","DS")),
      p("A journal's start year is not necessarily the year they offered open access publishing, but in some cases is the date of first publication."),
      sliderInput("Years",
                  label = h3("Year Range"),
                  sep = "",
                  min = 1853, 
                  max = 2014, 
                  value = c(1853,2014),
                  step = 1),
      p("The Article-Processing Charge (APC) is what an author (or institution) pays for publishing in an OA journal."),
      sliderInput("APC",
                label = h3("APC Range"),
                sep = ",",
                min = 0, 
                max = 5000, 
                value = c(0,5000),
                step = 1)
  ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput(""),
      plotOutput("distPlot"),
      textOutput(""),
      plotOutput("apcPlot"),
      textOutput("Fee for American non-member 10-page full paper"),
      plotOutput("paidPlot"),
      textOutput(""),
      plotOutput("subjectPlot"),
      
      DT::dataTableOutput('outputResults')
    )
  )
))
