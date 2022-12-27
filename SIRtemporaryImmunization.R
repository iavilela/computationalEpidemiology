library(readr)
library(ggplot2)
library(tidyverse)
library(reshape2)
library(plotly)
library(RColorBrewer)
library(deSolve)

## Create an SIR function with vaccination and temporary immunization
sir <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    dS <- -beta * S * I - alpha * S + epsilon * R
    dI <- beta * S * I - gamma * I
    dR <- gamma * I + alpha * S - epsilon * R
    
    return(list(c(dS, dI, dR)))
  })
}

### Set parameters
## Proportion in each compartment
init <- c(S = 1-1e-6, I = 1e-6, R = 0.0)

## beta: infection parameter; gamma: recovery parameter
parameters1 <- c(alpha = 0, beta = 1.5, gamma = 0.15, epsilon = 0.03)
parameters2 <- c(alpha = 0.06, beta = 1.5, gamma = 0.15, epsilon = 0.03)

## Time frame
times <- seq(0, 70, by = 0.01)

## Solve using ode (General Solver for Ordinary Differential Equations)
out1 <- ode(y = init, times = times, func = sir, parms = parameters1)
out2 <- ode(y = init, times = times, func = sir, parms = parameters2)

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
