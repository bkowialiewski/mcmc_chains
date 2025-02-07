function get_r_hat(chains)

    m = length(chains)
    n = length(chains[1])

    within = within_variance(chains)
    between = between_variance(n, m, chains)
    V_hat = estimated_variance(n, within, between)

    # final r_hat value
    sqrt(V_hat / within)

end

within_variance(chains) = mean(var.(chains))
between_variance(n, m, chains) = (n / (m-1)) * sum(mean.(chains) .- mean_hat(chains))
estimated_variance(n, within, between) = ((n-1)/n)*within + (1/n)*between
mean_hat(x) = mean(mean.(x)) # grand average - more efficient
