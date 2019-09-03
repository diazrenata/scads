#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Just an SAD"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30),
         numericInput("nb_leg", "Number of polynomials",
                      min = 2, max = 10, step = 1, value = 3)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"),
         plotOutput("legestPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
    portal_data <- isds::get_toy_portal_data(download=T, years = c(1990:1995))
    portal_sad <- portal_data %>%
      select(species) %>%
      group_by(species) %>%
      summarize(abund = n()) %>%
      ungroup() %>%
      select(abund) %>%
      arrange(abund)
    
    
    
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- portal_sad$abund 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   }, width = 300, height = 300)
   
   output$legestPlot <- renderPlot({
     
     leg_estimate <- scads::legendre_approx(portal_sad$abund, nleg = input$nb_leg)
     
     leg_coeffs <- data.frame(
       coeff_name = names(leg_estimate$coefficients),
       coeff = leg_estimate$coefficients
     )
     
     sse <- sum(leg_estimate$residuals ^ 2)
     
     legplot <- ggplot(data = leg_coeffs, aes(x = coeff_name, y = coeff)) +
       geom_point() +
       theme_bw() +
       ggtitle(paste0("Sum squared error: ", sse))
     
     legplot
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

