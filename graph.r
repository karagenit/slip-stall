#!/usr/bin/env Rscript

peak <- read.csv("peak-power.csv", header = TRUE)
stall <- read.csv("stall-6v.csv", header = TRUE)

x11()

peak$Torque = (9.5488 * peak$Power) / 2670

plot(peak$Time,
     peak$Torque,
     col="red",
     type="l",
     ylim=c(0, 1.3),
     xlim=c(0, 300),
     xlab="Time (s)",
     ylab="Torque (Nm)",
     main="Torque Output - Stalling vs Slipping")
points(stall$Time,
       stall$Torque,
       col="blue",
       type="l")
legend(x = "bottomright",
       legend = c("Slipping (Peak Power)", "Stalling (6 Volts)"),
       col = c("red", "blue"),
       lty = 1,
       bty = "n",
       cex = 0.8)

dev.print(png, "plot.png", width = 1000, height = 1000)

Sys.sleep(1000)

# Do both draw the same current? We could plot this, or also Torque per Amp.
