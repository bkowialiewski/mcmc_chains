function plot_chains(chains)

    n_chains = length(chains)
    n_parameters = size(chains[1], 2)

    p = plot(layout = (n_parameters,2), size = (600, 600), dpi = 500)

    for i in 1:n_parameters

        current_chains = map(j -> chains[j][:,i], 1:n_chains)

        R_hat = round(get_r_hat(current_chains), digits = 4)
        println(R_hat)
        plot!(p[i,1], current_chains, legend = false, alpha = 0.6)

        # plot the probability density function
        density!(p[i,2], current_chains, legend = false,
                 annotations = (1.0, 1.0, Plots.text("R_hat = " * string(R_hat), 8)))

    end
    savefig(p, "plots/chains.png")

    return nothing

end
