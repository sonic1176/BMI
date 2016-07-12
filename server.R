library(shiny)
library(ggplot2)

shinyServer(  
    function(input, output) {  
        output$myChart <- renderPlot({    
            if (input$metric=="Imperial") {
                h <- input$hi * 0.3048
                w <- input$wi * 0.45359237
            } else {
                h <- input$hm
                w <- input$wm
            }
            bmi <- w/(h^2)

            x <- seq(1.45,2.15, 0.005)
            plot(h, w, xlim=c(1.5, 2.1), ylim=c(50, 120), main="BMI Table", xlab="Height (in metre)", ylab="Weight (in kg)", xaxt='n')
            xticks <- pretty(h, 50)
            axis(1, at=xticks, labels=sprintf("%1.2f",xticks)) 
            polygon(c(min(x),max(x),max(x),min(x)), c(0,0,150,150), col="thistle", border=NA)
            polygon(c(min(x),x,max(x)), c(0,x^2*31,0), col="lightpink", border=NA)
            polygon(c(min(x),x,max(x)), c(0,x^2*25,0), col="#CCFFCC", border=NA)
            polygon(c(min(x),x,max(x)), c(0,x^2*18,0), col="lightcyan", border=NA)
            points(h, w, pch="o", col="deeppink", cex=1.5)
            text(h+0.04, w, round(bmi, 1), cex = 2)
            legend("topright", lty=1, lwd=2, col=c("thistle", "lightpink", "#CCFFCC", "lightcyan"), legend = c("Obese", "Overweight", "Normal", "Underweight"))
        }) 
        output$calc <- renderText({ 
            if (input$metric=="Imperial") {
                h <- input$hi * 0.3048
                w <- input$wi * 0.45359237
            } else {
                h <- input$hm
                w <- input$wm
            }

            bmi <- round(w/(h^2), 1)
            out <- paste0("")
            if (input$metric=="Imperial") {
                out <- paste0("<p>Your height is considered as ",sprintf("%1.2f",h)," metres.</p>") 
                out <- paste0(out, "<p>Your weight is considered as ",round(w, 1)," kilograms.</p>")    
            }
            out <- paste0(out, "<p>Your calculated BMI is ", round(bmi, 1), "</p>")
            if (input$bmi<bmi) {
                out <- paste0(out, "<p>To ensure your desired BMI you should decrease your weight by ", round(w-(h^2)*input$bmi, 1), " kg to ", round((h^2)*input$bmi, 1), " kg.</p>")
            }   else if (input$bmi==bmi) {
                out <- paste0(out, "<p>Your BMI is your desired level.</p>")
            }   else {
                out <- paste0(out, "<p>To ensure your desired BMI you should raise your weight by ", round((h^2)*input$bmi-w, 1), " kg to ", round((h^2)*input$bmi, 1), " kg.</p>")
            }                              
            
        }) 
    }
)