shinyServer(function(input, output, session){
  phdDf <- reactive({ 
    phdDf <- df2022[df2022$Degree == "PhD" | df2022$Degree == "Master's", ] 
    return(phdDf)
  })
  
  selectedDf <- reactive({ 
    phdDf <- phdDf()
    phdDf$randomNumberGenerated <- sapply(phdDf$DegreeYears, selectionRun)
    
    phdDf$randomNumberGenerated[phdDf$Tutorial == "yes"] = 1
    # phdDf$randomNumberGenerated[phdDf$rep] = 1
    # phdDf$randomNumberGenerated[phdDf$inNeed] = 1
    
    phdDf <- phdDf[order(phdDf$randomNumberGenerated),]
    selected <-phdDf[1:input$number,c("Name","minority","Affiliation"  , "Degree","DegreeYears","NumGEM","email","AdvName","Adv_email","hotel","airfare","Roommate")]
    return(selected)
  })
  
  advisorDf <- reactive({ 
    advisorDf <- phdDf() %>% 
      group_by(Adv_email) %>%
      summarise(count = n(), name = first(Name))
      })
  
  #table output:
  output$selectedDf <- DT::renderDataTable(DT::datatable(
    selectedDf(),
    # colnames=c("Name","Email", "Advisor","Advisor's email"),
    filter="top",
    caption= htmltools::tags$caption(
      style='caption-side:bottom; text-align:center;', 
      "Financial Support")
  ))
  
  #plot ouput:
  output$minoritypie<-renderPlotly({
    fig <- plot_ly(phdDf(), labels = ~minority, type = 'pie')
    fig <- fig %>% layout(title = 'minority')
    
    fig
  })
  
  output$Degree<-renderPlotly({
    fig <- plot_ly(phdDf(), labels = ~Degree, type = 'pie')
    fig <- fig %>% layout(title = 'Graduate Student Degree')
    
    fig
  })
  
  output$DegreeYears<-renderPlotly({
    fig <- plot_ly(phdDf(), labels = ~DegreeYears, type = 'pie')
    fig <- fig %>% layout(title = 'Years in Degree')
    
    fig
  })
  
  output$DegreeYearsOld<-renderPlotly({
    oldGraduateDf = phdDf()[phdDf()$NumGEM != 1,]
    oldGraduateDf$yearCat = "3~4"
    oldGraduateDf$yearCat[oldGraduateDf$DegreeYears <=2 ] = "1~2"
    oldGraduateDf$yearCat[oldGraduateDf$DegreeYears >=5 ] = ">5"
    
    fig <- plot_ly(oldGraduateDf, labels = ~yearCat, type = 'pie')
    fig <- fig %>% layout(title = 'Degree Years of Non-first Time GEMEE')
    
    fig
  })
  
  output$NumGEM<-renderPlotly({
    fig <- plot_ly(phdDf(), labels = ~NumGEM, type = 'pie')
    fig <- fig %>% layout(title = 'Number of GEM Attendances ')
    
    fig
  })
  
  output$PosterComp<-renderPlotly({
    fig <- plot_ly(phdDf(), labels = ~PosterComp, type = 'pie')
    fig <- fig %>% layout(title = 'Participate in Poster Competition')
    
    fig
  })
  output$Volunteer<-renderPlotly({
    fig <- plot_ly(phdDf(), labels = ~Volunteer, type = 'pie')
    fig <- fig %>% layout(title = 'Apply to be a volunteer')
    
    fig
  })
  output$Tutorial<-renderPlotly({
    fig <- plot_ly(phdDf(), labels = ~Tutorial, type = 'pie')
    fig <- fig %>% layout(title = 'Apply to Give a Tutorial')
    
    fig
  })
  output$airfare<-renderPlotly({
    fig <- plot_ly(phdDf(), labels = ~airfare, type = 'pie')
    fig <- fig %>% layout(title = 'Need Airfare')
    
    fig
  })
  
  output$hotel<-renderPlotly({
    fig <- plot_ly(phdDf(), labels = ~hotel, type = 'pie')
    fig <- fig %>% layout(title = 'Need Hotel')
    
    fig
  })
  output$advisor<-renderPlotly({
    fig <- plot_ly(advisorDf(), labels = ~count, type = 'pie')
    fig <- fig %>% layout(title = 'Number of Students per Advisor')
    
    fig
  })
})
