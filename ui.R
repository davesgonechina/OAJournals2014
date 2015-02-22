# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("2014 Open Access Journals Analysis"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h3("This app uses data from Walt Crawford's Cites & Insights research"),
      a("PDF", href="http://citesandinsights.info/civ15i3.pdf"),
      p("Excel files available on FigShare"),
      a("DOAJ XLSX File", href="http://figshare.com/articles/Open_Access_Journals_2014_DOAJ_subset/1299451"),
      p(""),
      a("Beall XLSX File", href="http://figshare.com/articles/Open_Access_Journals_2014_Beall_list_not_in_DOAJ_subset/1299452"),
      p("The first dataset is from the Directory of Open Access Journals (DOAJ), while the second comprises journals on Jeffrey Beall's \"predatory\" journal list that do not appear in the DOAJ."),
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("DOAJ", "Bealls (non-DOAJ)", "All (DOAJ + Bealls)")),
      p("Crawford categorized the journals according to general fields. MegaJournals, such as PLoS One, do not necessarily confine themselves to any field."),
      checkboxGroupInput("subjectCheckboxes", "Choose subject areas",
                  choices = c("General" = "G", 
                              "Humanities & Social Sciences" = "H", 
                              "Biomed" = "M", 
                              "Sciences" = "S", 
                              "Mega" = "P", 
                              "Unknown" = ""), 
                  selected = c("G","H","M","S", "P","")),
      p("Crawford also graded journals on quality according to several categories."),
      checkboxGroupInput("gradeCheckboxes", "Journal Quality Grade",
                         choices = c("Apparently good" = "A", 
                                     "May need investigation" = "B",
                                     "Highly questionable" = "C",
                                     "Ceased" = "DC",
                                     "Apparently dying" = "DD",
                                     "Erratic" = "DE",
                                     "Hiatus" = "DH",
                                     "New" = "DN",
                                     "Small" = "DS",
                                     "Empty" = "E",
                                     "Empty/ceased" = "EC",
                                     "Hybrid" = "H",
                                     "Not OA" = "N",
                                     "Opaque" = "O",
                                     "Unreachable/unworkable" = "X"),
                         selected = c("A","B")),
      p("A journal's start year is not necessarily the year they offered open access publishing, but in some cases is the date of first publication."),
      sliderInput("Years",
                  label = h3("Year Range"),
                  sep = "",
                  min = 1853, 
                  max = 2014, 
                  value = c(2000,2014),
                  step = 1),
      p("The Article-Processing Charge (APC) is what an author (or institution) pays for publishing in an OA journal."),
      sliderInput("APC",
                label = h3("APC Range"),
                sep = "",
                min = 0, 
                max = 5000, 
                value = c(0,50),
                step = 1)
  ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      plotOutput("apcPlot")
    )
  )
))