library(readr)
library(ggplot2)
library(tidyverse)
library(reshape2)
library(plotly)
library(RColorBrewer)
library(deSolve)

## Create an SIR function 
sir <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    dS <- -beta * S * I 
    dI <-  beta * S * I - gamma * I
    dR <-                 gamma * I
    
    return(list(c(dS, dI, dR)))
  })
}

### Set parameters
## Proportion in each compartment
init1 <- c(S = 1-1e-6 - 0.5, I = 1e-6, R = 0.5)
init2 <- c(S = 1-1e-6 - 0.75, I = 1e-6, R = 0.75)

## beta: infection parameter; gamma: recovery parameter
parameters <- c(beta = 0.9, gamma = 0.15)

## Time frame
times <- seq(0, 90, by = 0.01)

## Solve using ode (General Solver for Ordinary Differential Equations)
out1 <- ode(y = init1, times = times, func = sir, parms = parameters)
out2 <- ode(y = init2, times = times, func = sir, parms = parameters)

## change to data frame
out1 <- as.data.frame(out1)
out2 <- as.data.frame(out2)

head(out1)
head(out2)

names(out1) = c("Time","Susceptible","Infected","Removed")
names(out2) = c("Time","Susceptible","Infected","Removed")

dat.SIR1 = melt(out1,id="Time",measure = c("Susceptible","Infected","Removed"))
dat.SIR2 = melt(out2,id="Time",measure = c("Susceptible","Infected","Removed"))

head(dat.SIR1)
names(dat.SIR1) = c("Time","Compartment","Value")
head(dat.SIR2)
names(dat.SIR2) = c("Time","Compartment","Value")

## Plotting
pp1 = ggplot(dat.SIR1) +
  geom_line(aes(x = Time,y = Value,color=Compartment),size=1.2) +
  theme_minimal()+
  xlab ("Time")  +
  ylab("Proportion of Population")+
  theme_classic() + 
  theme(text = element_text(size = 20)) +
  ylim(0,1)+ 
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) 

pp2 = ggplot(dat.SIR2) +
  geom_line(aes(x = Time,y = Value,color=Compartment),size=1.2) +
  theme_minimal()+
  xlab ("Time")  +
  ylab("Proportion of Population")+
  theme_classic() + 
  theme(text = element_text(size = 20)) +
  ylim(0,1)+ 
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) 

show(pp1)
show(pp2)
