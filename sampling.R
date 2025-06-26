# sampling.R

set.seed(123)

# Core Acceptance-Rejection function
acceptance_rejection <- function(target_density, proposal_sampler, proposal_density, c, n) {
  samples <- numeric(n)
  accepted <- 0
  count <- 0

  while (accepted < n) {
    y <- proposal_sampler()
    u <- runif(1)
    if (u < target_density(y) / (c * proposal_density(y))) {
      accepted <- accepted + 1
      samples[accepted] <- y
    }
    count <- count + 1
  }

  list(samples = samples, efficiency = accepted / count)
}

# Visualization function
plot_results <- function(samples, target_density_func, proposal_density_func = NULL, c = NULL, title = "") {
  hist(samples, breaks = 30, prob = TRUE, col = "gray", main = title)
  curve(target_density_func(x), add = TRUE, col = "red", lwd = 2)
  if (!is.null(proposal_density_func) && !is.null(c)) {
    curve(c * proposal_density_func(x), add = TRUE, col = "blue", lwd = 2)
  }
}

# Example 1: Uniform proposal, target f(y) = 6y(1 - y)
target1 <- function(y) ifelse(y >= 0 & y <= 1, 6 * y * (1 - y), 0)
proposal1 <- function() runif(1)
dproposal1 <- function(y) ifelse(y >= 0 & y <= 1, 1, 0)
res1 <- acceptance_rejection(target1, proposal1, dproposal1, c = 1.5, n = 1000)
print(paste("Efficiency (Uniform proposal):", res1$efficiency))
plot_results(res1$samples, target1, dproposal1, c = 1.5, title = "g(y) = Unif(0,1), c = 1.5")

# Example 2: Normal proposal
target2 <- target1
proposal2 <- function() rnorm(1, mean = 0.5, sd = 0.05)
dproposal2 <- function(y) dnorm(y, mean = 0.5, sd = 0.05)
res2 <- acceptance_rejection(target2, proposal2, dproposal2, c = 2, n = 1000)
print(paste("Efficiency (Normal proposal):", res2$efficiency))
plot_results(res2$samples, target2, dproposal2, c = 2, title = "g(y) = N(0.5, 0.05), c = 2")

# Example 3: t-distribution target, Uniform proposal
set.seed(789)
target3 <- function(y) dt(y, df = 3)
proposal3 <- function() runif(1)
dproposal3 <- function(y) ifelse(y >= 0 & y <= 1, 1, 0)
res3 <- acceptance_rejection(target3, proposal3, dproposal3, c = 5, n = 1500)
print(paste("Efficiency (t-distribution target):", res3$efficiency))
plot_results(res3$samples, target3, dproposal3, c = 5, title = "g(y) = t3, c = 5")
