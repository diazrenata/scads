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
  titlePanel("Generate an SAD from Legendre estimation coefficients"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("nleg", "Number of polynomials",
                   min = 2, max = 6, step = 1, value = 6),
      numericInput("nspp", "Number of species", 
                   min = 2, max = 25, step = 1, value = 10),
      numericInput("intercept", "Intercept",
                   min = 0, max = .25, step = .0000001, value = 0.06407689), 
      numericInput("c1", "Coeff1",
                   min = 0, max = .25, step = .0000001, value = 0.10854914),
      numericInput("c2", "Coeff2",
                   min = 0, max = .25, step = .0000001, value = 0.07617611),
      numericInput("c3", "Coeff3",
                   min = 0, max = .25, step = .0000001, value = 0.06540432),
      numericInput("c4", "Coeff4",
                   min = 0, max = .25, step = .0000001, value = 0.04968723),
      numericInput("c5", "Coeff5",
                   min = 0, max = .25, step = .0000001, value = 0.03400953),
      numericInput("c6", "Coeff6",
                   min = 0, max = .25, step = .0000001, value = 0.01832946),
      checkboxInput("use_abund", "Use overlay abundance vector?", value = TRUE) ,
      textInput("abund",
                "Overlay abundance vector:",
                value = "1,1,7,36,69,89,99,174,308,1616"),
      h6("Here are some useful abundance vectors:"),
      p("Portal rodents 1990-1995: 1,1,7,36,69,89,99,174,308,1616"),
      p("Portal winter annuals 1994: 1,1,1,1,4,4,4,4,4,5,8,8,9,13,19,20,31,35, 40,48,56,108,111,169,224,402,428,431,867,1719")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("legSadPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$legSadPlot <- renderPlot({
    
    coeff_values <- c(input$intercept,
                      input$c1,
                      input$c2,
                      input$c3,
                      input$c4,
                      input$c5,
                      input$c6)[1:(input$nleg + 1)]
    
    leg_sad <- data.frame(
      abund = scads::legendre_generate(coeff_values = coeff_values, nleg = input$nleg, nspp = input$nspp),
      rank = 1:input$nspp)
    
    
    leg_sad_plot <- ggplot(data = leg_sad, aes(x = rank, y = abund)) +
      geom_point() +
      theme_bw()
    
    if(input$use_abund) {
      scaled_abund <- as.integer(unlist(strsplit(input$abund, ",")))
      scaled_abund <- data.frame(
        rank = 1:length(scaled_abund),
        abund = scaled_abund / sum(scaled_abund)
      )
      
      ssqe <- scads::ssqe(leg_sad$abund, scaled_abund$abund)
      
      leg_sad_plot <- leg_sad_plot +
        geom_point(data= scaled_abund, aes(x = rank, y = abund), color = "red") +
        annotate("text", x = 2, y = max(leg_sad$abund), label = paste0("SSQE: ", signif(ssqe, 3)), size = 5)
    }
    
    leg_sad_plot
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

