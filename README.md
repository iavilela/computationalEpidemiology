# Computational Epidemiology

### Repository for the computational epidemiology course 2022, University of Bern 

---

This repository provides the scripts used for the final project of the computatione epidemilogy course along with a brief documentation.

## R script descriptions
The `SIRstandard.R` script is nearly identical to the script provided by the course.
Merely some model parameters have been adjusted to achieve the desired base model without vaccination (described in the report).

The `SIRvaccinatedProportion.R` script is equivalent to `SIRstandard.R` but has adapted initial conditions that reflect a proportion of the population being vaccinated upon disease outbreak.
The script runs two model simulatiosn (generates two output graphs) with different initial conditions (different proportions of vaccinated individuals).

The `SIRvaccinationRate.R` script is similar to the `SIRstandard.R` but the SIR function was adapted such that a vaccination rate is included during the epidemic.
The script runs two simulations (generates two graphs) with two different vaccination rates. 

The `SIRtemporaryImmunization.R` is similar to `SIRvaccinationRate.R` but the SIR function was adapted such that immunization was reversible at an adjustable rate.
The script runs two simulations (generates two graphs) with the same immunization reversibility rate but once with a vaccination rate and once without vaccination rate. 
