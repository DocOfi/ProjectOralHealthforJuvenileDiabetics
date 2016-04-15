library(rCharts)
shinyUI(fluidPage(
  titlePanel(
    "Oral Health of Children and Youth with Type 1 Diabetes"
  ),
  sidebarLayout(
    sidebarPanel(
      p(span("DMFT", style = "color:blue"), "stands for Decayed, 
        Missing, and Filled Teeth. It is an index of oral health 
        that allows for comparison across different populations or 
        age groups. A simple count of the number of D, M, and F teeth are 
        added to come up with the DMFT score."),
      selectInput("varName", label = h3("Compare"), 
                  choices = list("no. of decayed teeth", "no. of missing teeth", "no. of filled teeth", "total dmft"), selected = 
                                 "no. of decayed teeth"),
      img(src="pohjd.png", height = 50, width = 100),
      p(span("Please take note of the range of the y-axis of each 
             plot. The height of the bars may look the same but the 
             upper limit is different for each plot", style = 
             "color:red"))
    ),
    mainPanel(
      h3('You selected'),
      verbatimTextOutput('ovarName'),
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot", plotOutput("plot")), 
                  tabPanel("Summary", verbatimTextOutput("summary")), 
                  tabPanel("Table", tableOutput("table")),
      plotOutput('plot')
    )
  )
  )
))

