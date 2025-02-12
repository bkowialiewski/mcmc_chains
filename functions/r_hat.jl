function get_r_hat(chains)

    # number of samples
    n = length(chains[1])

    within = within_variance(chains)
    between = between_variance(n, chains)
    estimated = estimated_variance(n, within, between)

    sqrt(estimated / within)

end

within_variance(chains) = mean(var.(chains, corrected = true))
between_variance(n, chains) = n * var(mean.(chains), corrected = true)
estimated_variance(n, within, between) = ((n - 1) / n) * within + (1.0 / n) * between
