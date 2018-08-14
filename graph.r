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
     xlim=c(0, 300))
points(stall$Time,
       stall$Torque,
       col="blue",
       type="l")

Sys.sleep(1000)

# Do both draw the same current? We could plot this.
