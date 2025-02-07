function metropolis(n_iterations, n_parameters, f)

    # standard deviation in parameter sample
    sigma = 1.0

    # define a generic burn-in period
    burn_in = Int(floor(n_iterations / 4))

    # pre-allocate memory for the x values
    xs = zeros(n_iterations, n_parameters)
    # used a pivot
    # first value indicates the currently accepted value
    # second value indicates the value under consideration
    pivot = zeros(2)

    # iterate over the maximum number of iterations
    for i in 1:n_iterations

        # generate initial parameters
        if i == 1
            xs[1,:] = randn(n_parameters) .* sigma
            pivot[1] = f(xs[1,:])
            continue
        end

        # set a proposal and evaluate it
        proposal = randn(n_parameters) .* sigma .+ xs[i-1,:]
        pivot[2] = mean(f(proposal))

        # acceptance / rejection phase
        if rand() <= pivot[2] / pivot[1]
            xs[i,:] = proposal
            pivot[1] = pivot[2]
        else
            xs[i,:] = xs[i-1,:]
        end

    end

    xs[burn_in:end,:]

end
