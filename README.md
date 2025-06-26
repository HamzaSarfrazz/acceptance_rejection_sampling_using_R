# Acceptance-Rejection Sampling in R

This project demonstrates acceptance-rejection sampling using different proposal distributions and target densities.

## 📊 Overview

Acceptance-Rejection Sampling is a technique for generating samples from a complex target distribution by using a simpler proposal distribution.

We compare:

- **Uniform proposal** with a Beta-like target `f(y) = 6y(1 - y)`
- **Normal proposal** with the same target
- **Uniform proposal** with a **t-distribution** target

Each example reports the **efficiency** and plots:

- A histogram of the sampled data
- The target and scaled proposal densities

## 🧮 Files

- `sampling.R`: Main R script with modular functions
- `plots/`: Suggested location to save your output plots (not auto-saved in this version)

## 🚀 How to Run

In R or RStudio:

```R
source("sampling.R")
```

You will see efficiency values printed and plots displayed.

## 📁 Suggested Project Structure

```
acceptance_rejection_sampling/
├── README.md
├── sampling.R
├── plots/               # Create this folder to save your plots
```

## 📄 License

This project is provided under the MIT License.
