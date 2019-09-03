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
      textInput("abund",
                "Abundance vector:",
                value = "1,1,7,36,69,89,99,174,308,1616"),
      numericInput("nb_leg", "Number of polynomials",
                   min = 2, max = 10, step = 1, value = 3)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("legestPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$legestPlot <- renderPlot({
    abund <- as.integer(unlist(strsplit(input$abund, ",")))
    
    sad_df <- list(
      provided = abund,
      mete_draw = scads::sample_METE(s = length(abund), n = sum(abund), nsamples = 1)$V1,
      poilog_draw = scads::draw_poilog_samples(abund),
      #fs_draw = scads::sample_feasibleset(s = length(abund), n = sum(abund), nsamples = 1)$V1,
      flat = scads::generate_even_sad(abund),
      stepwise = scads::generate_stepwise_sad(abund),
      expon = scads::generate_exponential_sad(abund),
      prec = scads::generate_precipice_sad(abund)
    ) %>%
      bind_rows() %>%
      mutate(rank = row_number()) %>%
      tidyr::gather(-rank, key = "source", value = "abund")
    
    sads_plot <- ggplot(data = sad_df, aes(x = rank, value = abund, color = source)) +
      geom_line() +
      theme_bw()
    
    sads_plot
    
    
    leg_coeffs <- lapply(as.list(unique(sad_df$source)),
                         FUN = function(source_name) 
                           return(data.frame(coeff = scads::legendre_approx(filter(sad_df, source == source_name)$abund, 
                                                                     nleg = input$nb_leg)$coefficients,
                                             coeff_name = names(scads::legendre_approx(filter(sad_df, source == source_name)$abund, 
                                                                                nleg = input$nb_leg)$coefficients),
                                             source = source_name, stringsAsFactors = F)))
    
    leg_coeffs <- bind_rows(leg_coeffs)
      
    
    
    legplot <- ggplot(data = leg_coeffs, aes(x = coeff_name, y = coeff, color = source)) +
      geom_point() +
      theme_bw() +
      facet_wrap(source ~ .) +
      theme(legend.position = "none")
    
    legplot
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

