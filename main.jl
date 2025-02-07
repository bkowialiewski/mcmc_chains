include("functions/to_include.jl")

function main()

    n_chains = 3
    n_iterations = 1_000_000
    # number of parameters in the objective function
    n_parameters = 4

    # define the name of the objective function as a string
    objective_function = "mv_normal"
    # this line of code allows to have a generic function
    f = getfield(Main, Symbol(objective_function))

    # we pass this generic function in the metropolis algorithm
    # the first argument is the number of iterations
    # this is where the magic happens
    @time chains = map(_ -> metropolis(n_iterations, n_parameters, f), 1:n_chains)

    plot_chains(chains)

    nothing

end

mv_normal(x) = pdf(multivariate(x), x)
multivariate(x) = MvNormal(zeros(length(x)), Diagonal(ones(length(x))) * 0.1)

main()
