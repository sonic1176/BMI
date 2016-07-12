library(shiny)
shinyUI(pageWithSidebar(  
    headerPanel(
        h2('Calculate your Body Mass Index (BMI)')
    ),
    sidebarPanel(    
        radioButtons('metric', 'Metric System:', c("Imperial", "International System")),
        conditionalPanel (
            condition="input.metric=='Imperial'",
            sliderInput('hi', 'Height (in feet):', value=5.9, min=5, max=7, step=0.05),
            sliderInput('wi', 'Weight (in pound):', value=165, min=110, max=270, step=1)
        ),
        conditionalPanel (
            condition="input.metric!='Imperial'",
            sliderInput('hm', 'Height (in metre):', value=1.8, min=1.5, max=2.1, step=0.01),
            sliderInput('wm', 'Weight (in kg):', value=75, min=50, max=120, step=0.5)
        ),
        sliderInput('bmi', 'Desired BMI:',value = 22, min = 18.5, max = 25, step = 0.5)
    ), 
    mainPanel( 
        h3("Calculation"),
        htmlOutput('calc'),
        plotOutput('myChart'),  
        h3('Instructions'),
        p('The BMI is a unit to classify a combination of weight and height with the formula'),
        h3(withMathJax('$$BMI = \\frac{kg}{m^{2}}$$')),
        p("A common classification is defined as:"),
        HTML("<table width=250 border=1>
            <tr><th width=80>BMI</th><th width=120>category</th><tr>
            <tr><td>&lt; 18.5</td><td>underweight</td></tr>
            <tr><td>18.5 - 25.0</td><td>normal</td></tr>      
            <tr><td>25.0 - 30.0</td><td>overweight</td></tr>
            <tr><td>&gt;30.0</td><td>obese</td></tr>
            </table>"
        ), 
        h4('How to'),
        p('Choose your measurements on the left to see as a result your BMI located in the areas for BMI classification.'),
        p('As BMI uses the metric system, you can also input your imperial measuresments and they will be calculated to metric.'),
        p('For further details look here:'), 
        a('Wikipedia', href='https://en.wikipedia.org/wiki/Body_mass_index')
    )
))


# setwd("~/R/09 Developing Data Products/A1")
