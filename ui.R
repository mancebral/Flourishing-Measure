
library(shiny)
library(shinyscreenshot)
library(shinyWidgets)
library(shinyBS)
library(shinythemes)
library(shinyjs)

countries <- c("-Select an option-","Afghanistan", "Albania","Algeria","Andorra","Angola","Antigua and Barbuda","Argentina",
"Armenia", "Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus",
"Belgium","Belize","Benin","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Brunei",
"Bulgaria","Burkina Faso","Burundi","Cabo Verde","Cambodia","Cameroon","Canada","Central African Republic (CAR)",
"Chad","Chile","China","Colombia","Comoros","Congo, Democratic Republic","Costa Rica","Cote d'Ivoire",
"Croatia","Cuba","Cyprus","Czechia","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador",
"Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Eswatini","Ethiopia","Fiji","Finland",
"France","Gabon","Gambia","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea","Guinea-Bissau",
"Guyana","Haiti","Honduras","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel",
"Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Kosovo","Kuwait","Kyrgyzstan",
"Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg",
"Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Mauritania","Mauritius",
"Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Morocco","Mozambique","Myanmar",
"Namibia","Nauru","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","North Korea",
"North Macedonia","Norway","Oman","Pakistan","Palau","Palestine","Panama","Papua New Guinea","Paraguay",
"Peru","Philippines","Poland","Portugal","Qatar","Romania","Russia","Rwanda","Saint Kitts and Nevis",
"Saint Lucia","Saint Vincent and the Grenadines","Samoa","San Marino","Sao Tome and Principe","Saudi Arabia",
"Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia",
"South Africa","South Korea","South Sudan","Spain","Sri Lanka","Sudan","Suriname","Sweden","Switzerland",
"Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor-Leste","Togo","Tonga","Trinidad and Tobago",
"Tunisia","Turkey","Turkmenistan","Tuvalu","Uganda","Ukraine","United Arab Emirates (UAE)","United Kingdom (UK)",
"United States of America (USA)","Uruguay","Uzbekistan","Vanuatu","Vatican City (Holy See)",
"Venezuela","Vietnam","Yemen","Zambia","Zimbabwe")

shinyUI(navbarPage("Flourishing Measure", id="tabs",
                   useShinyjs(),
                   theme = shinytheme("united"),
                   #position = "fixed-top",
                   tabPanel("ABOUT YOU",
                            sidebarLayout(
                              column(width=6, offset=3,
                                     wellPanel(id="sidebar2",width=6,offset=3,
                                               HTML("Before responding to the Flourishing Test, <b>please fill up the next fields</b> providing us statistical information.<br><br>"),
                                               sliderInput("age", "Age:", min = 16, max = 120, value = 18),
                                               selectInput("gender", "Gender:",
                                                           choices = c("-Select an option-", "Male", "Female", "Other"),
                                                           selectize = FALSE),
                                               selectInput("studies", "Studies:", 
                                                           choices = c("-Select an option-","Primary", "Secondary", "Undergraduate",
                                                                       "Graduate", "MSC", "Doctor"),
                                                           selectize = FALSE),
                                               selectInput("country", "Country:", 
                                                           choices = countries,
                                                           selectize = FALSE),
                                               actionButton("showTab", "Go to the test")
                                     )),
                              column(width=9, offset=3,
                                     mainPanel(
                                       HTML('<footer><br>
            All the data collected is anonymmous, and is going to be use just for academic purposes.<br><br>
            This tool has been created by Human Flourishing Projects at <a href="https://tec.mx/es">Tecnologico de Monterrey (México)</a>
            programmed by <a href="https://github.com/mancebral/Flourishing-Measure">cebral-loureda with free code</a>.
            It is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.<br>
            <br>
            <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a>
            <br><br></footer>'
                                       )
                                     ))
                            )
                   ),
                   tabPanel("TEST",
                            tags$head(
                              tags$style(
                                HTML('
                              .navbar-header { width:100% }
                              .navbar-brand {
                              float: left;
                              padding: 15px 15px;
                              font-size: 28px;
                              line-height: 20px;
                              height: 50px;
                              margin-bottom: 10px;
                              }
                              .navbar-default .container-fluid {
                              display: flex;
                              list-style-type: none;
                              justify-content: center;
                              flex-wrap: wrap;
                              }
                              #sidebar {
                               background-color: ##EBECF0;
                              }
                              .nav {
                              margin-bottom: 20px;
                              }
                              .tab-content {
                              font-family: "Arial"; color: #337ab7;
                              }
                              .col-sm-3 {
                              padding-right: 20px;
                              padding-left: 20px;
                              }
                              .shiny-plot-output.shiny-bound-output {
                              width: 100px;
                              height: 400px;
                              margin-left: -20px;
                              padding: 0px;
                              }
                              .navbar-header {
                              display: flex !important;
                              justify-content: center !important;
                              }
                              .nav.navbar-nav.shiny-tab-input.shiny-bound-input {
                              background-color: #e95420;
                              }
                              .navbar-nav>li>a {
                              padding-top: 0px;
                              padding-bottom: 0px;
                              line-height: 0px;
                              }
                              .btn[disabled], fieldset[disabled] .btn {
                              color: #aea79f;
                              background-color: #ffffff;
                              border-color: #aea79f;
                              }
    
                              ')
                              )
                            ),
                            #titlePanel("Flourishing Measure"),
                            sidebarLayout(
                              column(width=6, offset=3,
                                     wellPanel(id="sidebar",
                                               HTML("Please, respond to <b>all the following 12 questions</b> organized in the <b>6 domains</b> shown below.<br><br>"),
                                               tabsetPanel(
                                                 id="switcher",
                                                 type = "hidden",
                                                 tabPanel("1. Happiness and Life Satisfaction",
                                                          HTML("<h4>1. Happiness and Life Satisfaction</h4><br>"),
                                                          sliderTextInput("Q1",
                                                                          "Overall, how satisfied are you with life as a whole these days?:",
                                                                          choices=c("Not Satisfied at All", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Completely Satisfied"),
                                                                          selected = "Not Satisfied at All"),
                                                          sliderTextInput("Q2",
                                                                          "In general, how happy or unhappy do you usually feel?:",
                                                                          choices=c("Extremely Unhappy", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Extremely Happy"),
                                                                          selected = "Extremely Unhappy"),
                                                          HTML("<br>"),
                                                          actionLink("d2a", label = div("Next", icon("angles-right")),
                                                                     style = "position: absolute; bottom: 33px; right: 30px;")),
                                                 tabPanel("2. Mental and Physical Health",
                                                          HTML("<h4>2. Mental and Physical Health</h4><br>"),
                                                          sliderTextInput("Q3",
                                                                          "In general, how would you rate your physical health?",
                                                                          choices=c("Poor", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Excellent"),
                                                                          selected = "Poor"),
                                                          sliderTextInput("Q4",
                                                                          "How would you rate your overall mental health?",
                                                                          choices=c("Poor", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Excellent"),
                                                                          selected = "Poor"),
                                                          actionLink("d1a", "Prev", icon = icon("angles-left")),
                                                          actionLink("d3a", label = div("Next", icon("angles-right")),
                                                                     style = "position: absolute; right: 30px")),
                                                 tabPanel("3. Meaning and Purpose",
                                                          HTML("<h4>3. Meaning and Purpose</h4><br>"),
                                                          sliderTextInput("Q5",
                                                                          "Overall, to what extent do you feel the things you do in your life are worthwhile?",
                                                                          choices=c("Not at All Worthwhile", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Completely Worthwhile"),
                                                                          selected = "Not at All Worthwhile"),
                                                          sliderTextInput("Q6",
                                                                          "I understand my purpose in life:",
                                                                          choices=c("Strongly Disagree", 1, 2, 3, 4, 5, 6, 7, 8, 9,
                                                                                    "Strongly Agree"),
                                                                          selected = "Strongly Disagree"),
                                                          actionLink("d2b", "Prev", icon = icon("angles-left")),
                                                          actionLink("d4a", label = div("Next", icon("angles-right")),
                                                                     style = "position: absolute; right: 30px")),
                                                 tabPanel("4. Character and Virtue",
                                                          HTML("<h4>4. Character and Virtue</h4><br>"),
                                                          sliderTextInput("Q7",
                                                                          "I always act to promote good in all circumstances, even in difficult and challenging situations:",
                                                                          choices=c("Not True of Me", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Completely True of Me"),
                                                                          selected = "Not True of Me"),
                                                          sliderTextInput("Q8",
                                                                          "I am always able to give up some happiness now for greater happiness later:",
                                                                          choices=c("Not True of Me", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Completely True of Me"),
                                                                          selected = "Not True of Me"),
                                                          actionLink("d3b", "Prev", icon = icon("angles-left")),
                                                          actionLink("d5a", label = div("Next", icon("angles-right")),
                                                                     style = "position: absolute; right: 30px")),
                                                 tabPanel("5. Close Social Relationships",
                                                          HTML("<h4>5. Close Social Relationships</h4><br>"),
                                                          sliderTextInput("Q9",
                                                                          "I am content with my friendships and relationships:",
                                                                          choices=c("Strongly Disagree", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Strongly Agree"),
                                                                          selected = "Strongly Disagree"),
                                                          sliderTextInput("Q10",
                                                                          "My relationships are as satisfying as I would want them to be:",
                                                                          choices=c("Strongly Disagree", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Strongly Agree"),
                                                                          selected = "Strongly Disagree"),
                                                          actionLink("d4b", "Prev", icon = icon("angles-left")),
                                                          actionLink("d6a", label = div("Next", icon("angles-right")),
                                                                     style = "position: absolute; right: 30px")),
                                                 tabPanel("6. Financial and Material Stability",
                                                          HTML("<h4>6. Financial and Material Stability</h4><br>"),
                                                          sliderTextInput("Q11",
                                                                          "How often do you worry about being able to meet normal monthly living expenses?:",
                                                                          choices=c("Worry All of the Time", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Do Not Ever Worry"),
                                                                          selected = "Worry All of the Time"),
                                                          sliderTextInput("Q12",
                                                                          "How often do you worry about safety, food, or housing?:",
                                                                          choices=c("Worry All of the Time", 1, 2, 3, 4, 5, 6, 7, 8, 9, 
                                                                                    "Do Not Ever Worry"),
                                                                          selected = "Worry All of the Time"),
                                                          actionLink("d5b", "Prev", icon = icon("angles-left")))),
                                     )),
                              
                              column(width=9,offset=3,
                                     mainPanel(
                                       id="col1",
                                       plotOutput("distPlot", width = "100%", height = "450px"),
                                       textOutput("textPlot"),
                                       HTML('<br>'),
                                       textOutput("textPlot2"),
                                       HTML('<br>'),
                                       actionLink("data", label = "Send your data before download results", icon = icon("envelope")),
                                       HTML('<br><br>'),
                                     column(12,
                                            id="sending",
                                            screenshotButton(id="col1", label = "Download Results", scale = 15, 
                                                             filename= "FlourishingMeasure", timer = 0, ns = shiny::NS(NULL))),
                                            HTML('<footer><br><br><br>
            The questions collected here are an adaptation of the work <a href="http://www.pnas.org/content/114/31/8148">On the promotion of human flourishing: by Tyler J. VanderWeele</a>,
            and <a href="https://hfh.fas.harvard.edu/measuring-flourishing">The Human Flourishing Measure of Harvard University</a>.<br><br>
            This tool has been created by Human Flourishing Projects at <a href="https://tec.mx/es">Tecnologico de Monterrey (México)</a>
            programmed by <a href="https://github.com/mancebral/Flourishing-Measure">cebral-loureda with free code</a>.
            It is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.<br>
            <br>
            <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a>
                 <br><br>
                 </footer>'
                                            ))
                                     ))
                            )
                   )
)

  