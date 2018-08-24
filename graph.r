#!/usr/bin/env Rscript

args = commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
    stop("Provide Motor Type (cim, 775) as Command Line Argument.")
}

if (args[1] == "cim") {
    rpm = 2670
} else if (args[1] == "775") {
    rpm = 9370
} else {
    rpm = 1
}

peakFile = paste(args[1], "-peak-power.csv", sep="")
stallFile = paste(args[1], "-stall-6v.csv", sep="")

peak <- read.csv(peakFile, header = TRUE)
stall <- read.csv(stallFile, header = TRUE)

x11()

peak$Torque = (9.5488 * peak$Power) / rpm

plot(peak$Time,
     peak$Torque,
     col="red",
     type="l",
     ylim=c(0, 1.3),
     xlim=c(0, 300),
     xlab="Time (s)",
     ylab="Torque (Nm)",
     main="Torque Output - Slipping vs Stalling")
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

dev.print(png, "torque.png", width = 1000, height = 1000)

x11()

plot(peak$Time,
     peak$Current,
     col="red",
     type="l",
     ylim=c(0,70),
     xlim=c(0,300),
     ylab="Current (A)",
     xlab="Time(s)",
     main="Current Draw, Slipping vs Stalling")
points(stall$Time,
       stall$Amps,
       col="blue",
       type="l")

dev.print(png, "current.png", width = 1000, height = 1000)

x11()

peak$TorquePerAmp = 1000 * peak$Torque / peak$Current
stall$TorquePerAmp = 1000 * stall$Torque / stall$Amps

plot(peak$Time,
     peak$TorquePerAmp,
     col="red",
     type="l",
     ylim=c(0,30),
     ylab="Torque per Amp (mNm/A)",
     xlab="Time (s)",
     main="Torque per Amp, Slipping vs Stalling")
points(stall$Time,
       stall$TorquePerAmp,
       col="blue",
       type="l")

dev.print(png, "torque-per-amp.png", width = 1000, height = 1000)

Sys.sleep(1000)

# Do both draw the same current? We could plot this, or also Torque per Amp.
