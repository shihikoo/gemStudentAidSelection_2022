function(request) {
  sidebar <- dashboardSidebar(hr(), sidebarMenu(
    id = "side",
    menuItem(
      "Summary of Applicants",
      tabName = "summary",
      icon = icon("pie-chart")), 
    menuItem(
      "Selected Students",
      tabName = "selected",
      icon = icon("table") )),
    hr(),
    conditionalPanel("input.side == 'selected'",
                     fluidRow(
                       column(1),
                       column(10,
                              # h4("Number of awardees"),
                              sliderInput("number", "Number of awardees", value = 40, min = 1, max=200, step = 1),
                       )
                     )
    ))
  
  body <- dashboardBody(tabItems(
    tabItem(tabName = "summary",
            fluidRow(
              column(
                width = 12,
                box(
                  width = 4,
                  plotlyOutput("Degree"),
                  solidHeader = TRUE,
                  status = "primary"
                ),
                box(
                  width = 4,
                  plotlyOutput("NumGEM"),
                  solidHeader = TRUE,
                  status = "primary"
                ),
                box(
                  width = 4,
                  plotlyOutput("DegreeYears"),
                  solidHeader = TRUE,
                  status = "primary"
                ),
                box(
                  width = 4,
                  plotlyOutput("DegreeYearsOld"),
                  solidHeader = TRUE,
                  status = "primary"
                ),
                box(
                  width = 4,
                  plotlyOutput("advisor"),
                  solidHeader = TRUE,
                  status = "primary"
                ) ,
                box(
                  width = 4,
                  plotlyOutput("minoritypie"),
                  solidHeader = TRUE,
                  status = "primary"
                ),                  
                box(
                  width = 4,
                  plotlyOutput("PosterComp"),
                  solidHeader = TRUE,
                  status = "primary"
                ) ,
                box(
                  width = 4,
                  plotlyOutput("Tutorial"),
                  solidHeader = TRUE,
                  status = "primary"
                ) ,
                box(
                  width = 4,
                  plotlyOutput("Volunteer"),
                  solidHeader = TRUE,
                  status = "primary"
                ),

                box(
                  width = 4,
                  plotlyOutput("hotel"),
                  solidHeader = TRUE,
                  status = "primary"
                ),
                box(
                  width = 4,
                  plotlyOutput("airfare"),
                  solidHeader = TRUE,
                  status = "primary"
                )
              )
            )),
    tabItem(tabName = "selected",
            fluidRow(
              box(
                width = NULL,
                status = "primary",
                solidHeader = TRUE,
                br(),
                DT::dataTableOutput("selectedDf")
              )
            ))))
  
  dashboardPage(dashboardHeader(title = "GEM Financial Aid Application"),
                sidebar,
                body)
  
  
}