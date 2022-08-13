
library(shiny)
library(tidyr)
library(fmsb)
library(googlesheets4)
library(gargle)
library(tidyverse)
library(shinyjs)

options(gargle_oauth_cache = "secrets",
        gargle_oauth_email = "[YOUR EMAIL]")

gs4_auth()

Sys.setlocale("LC_TIME", "en_US.UTF-8")

shinyServer(function(input, output, session) {
  
  useShinyjs()
  
  hideTab(inputId = "tabs", target = "TEST")
  observeEvent(input$showTab, {
    showTab(inputId = "tabs", target = "TEST", select=TRUE)
    hideTab(inputId = "tabs", target = "ABOUT YOU")
  })
  
  observeEvent(input$d1a, {
    updateTabsetPanel(inputId = "switcher", selected = "1. Happiness and Life Satisfaction")
  })
  
  observeEvent(input$d2a, {
    updateTabsetPanel(inputId = "switcher", selected = "2. Mental and Physical Health")
  })
  observeEvent(input$d2b, {
    updateTabsetPanel(inputId = "switcher", selected = "2. Mental and Physical Health")
  })
  
  observeEvent(input$d3a, {
    updateTabsetPanel(inputId = "switcher", selected = "3. Meaning and Purpose")
  })
  observeEvent(input$d3b, {
    updateTabsetPanel(inputId = "switcher", selected = "3. Meaning and Purpose")
  })
  
  observeEvent(input$d4a, {
    updateTabsetPanel(inputId = "switcher", selected = "4. Character and Virtue")
  })
  observeEvent(input$d4b, {
    updateTabsetPanel(inputId = "switcher", selected = "4. Character and Virtue")
  })
  
  observeEvent(input$d5a, {
    updateTabsetPanel(inputId = "switcher", selected = "5. Close Social Relationships")
  })
  observeEvent(input$d5b, {
    updateTabsetPanel(inputId = "switcher", selected = "5. Close Social Relationships")
  })
  
  observeEvent(input$d6a, {
    updateTabsetPanel(inputId = "switcher", selected = "6. Financial and Material Stability")
  })
  
  
  Q1 <- reactive({
    ifelse(input$Q1=="Not Satisfied at All", 0,
               ifelse(input$Q1=="Completely Satisfied", 10,
                      as.numeric(input$Q1)))
  })
  
  Q2 <- reactive({
    ifelse(input$Q2=="Extremely Unhappy", 0,
               ifelse(input$Q2=="Extremely Happy", 10,
                      as.numeric(input$Q2)))
  })
  Q3 <- reactive({
    ifelse(input$Q3=="Poor", 0,
               ifelse(input$Q3=="Excellent", 10,
                      as.numeric(input$Q3)))
  })
  Q4 <- reactive({
    ifelse(input$Q4=="Poor", 0,
               ifelse(input$Q4=="Excellent", 10,
                      as.numeric(input$Q4)))
  })
  Q5 <- reactive({
    ifelse(input$Q5=="Not at All Worthwhile", 0,
               ifelse(input$Q5=="Completely Worthwhile", 10,
                      as.numeric(input$Q5)))
  })
  Q6 <- reactive({
    ifelse(input$Q6=="Strongly Disagree", 0,
               ifelse(input$Q6=="Strongly Agree", 10,
                      as.numeric(input$Q6)))
  })
  Q7 <- reactive({
    ifelse(input$Q7=="Not True of Me", 0,
               ifelse(input$Q7=="Completely True of Me", 10,
                      as.numeric(input$Q7)))
  })
  Q8 <- reactive({
    ifelse(input$Q8=="Not True of Me", 0,
               ifelse(input$Q8=="Completely True of Me", 10,
                      as.numeric(input$Q8)))
  })
  Q9 <- reactive({
    ifelse(input$Q9=="Strongly Disagree", 0,
               ifelse(input$Q9=="Strongly Agree", 10,
                      as.numeric(input$Q9)))
  })
  Q10 <- reactive({
    ifelse(input$Q10=="Strongly Disagree", 0,
                ifelse(input$Q10=="Strongly Agree", 10,
                       as.numeric(input$Q10)))
  })
  Q11 <- reactive({
    ifelse(input$Q11=="Worry All of the Time", 0,
                ifelse(input$Q11=="Do Not Ever Worry", 10,
                       as.numeric(input$Q11)))
  })
  Q12 <- reactive({
    ifelse(input$Q12=="Worry All of the Time", 0,
                ifelse(input$Q12=="Do Not Ever Worry", 10,
                       as.numeric(input$Q12)))
  })
  

    my_data    <- reactive({
    data.frame("Happiness and Life Satisfaction"=c(10,0,(Q1()+Q2())/2), 
                           "Mental and Physical Health"=c(10,0,(Q3()+Q4())/2), 
                           "Meaning and Purpose"=c(10,0,(Q5()+Q6())/2), 
                           "Character and Virtue"=c(10,0,(Q7()+Q8())/2), 
                           "Close Social Relationships"=c(10,0,(Q9()+Q10())/2), 
                           "Financial and Material Stability"=c(10,0,(Q11()+Q12())/2))
    #rownames(my_data) <- c("Max.", "Min.", "Values")
      })
  
  my_text <- reactive({
    tibble(my_data()) %>% slice(3) %>% 
      pivot_longer(1:6, "domains") %>% 
      mutate(domains=str_replace_all(domains, pattern = "\\.", " ")) %>% 
      slice_min(value) %>% pull(domains) %>% paste(., collapse = ", ")
    })
  
    output$distPlot <- renderPlot({
        
              radarchart(my_data(),
                         title=paste0("\n", "\n", "My Flourising Measure", "\n", 
                                      "\n"),
                   axistype = 0,
                   cglty = 1,
                   cglcol = "gray",
                   cglwd = 1,
                   pcol = "#FF3633",
                   plwd = 2,
                   plty =  1,
                   pfcol = "#FF363360",
                   vlcex = 0.9,
                   vlabels = c(
                     "Happiness &\nLife Satisfaction", 
                     "Mental &\nPhysical\nHealth", 
                     "Meaning &\nPurpose", 
                     "Character & Virtue", 
                     "Close\nSocial\nRelationships", 
                     "Financial\n& Material\nStability"
                   ))
        output$textPlot <-  renderText(paste0("Human Flourishing is a complex concept, that can not be measured by a single variable,
                                       but by a composed one. In your case, it is important to improve the domains of ", my_text(), 
                                             ".",
                                             sep=" "))
        output$textPlot2 <-  renderText(paste0("Your Flourishing Index is: ", 
                                               sum(Q1(), Q2(), Q3(), Q4(), Q5(), Q7(), Q8(), Q9(), Q10()), 
                                               "/100, and you have ", (Q11()+Q12())/20*100, 
                                               "% capacity to sustain your flourishing into the future [at ",
                                               format(Sys.Date(), "%A, %B %d, %Y"),
                                               "]."))
    })

    observeEvent(input$data, {
      merge(my_data()[3,], as.data.frame(Sys.time())) %>% 
        cbind(., input$gender) %>% 
        cbind(., input$age) %>%
        cbind(., input$studies) %>%
        cbind(., input$country) %>%
      sheet_append(., ss="[SHEET ID]",
                   sheet = "data")
    })
    
    observe({
      shinyjs::hide("sending")
      if(input$data)
        shinyjs::show("sending")
      })
    
   observe({
     shinyjs::toggleState("showTab", !((input$gender=="-Select an option-")|
                                       (input$studies=="-Select an option-")|
                                         (input$country=="-Select an option-")))
   })

})
