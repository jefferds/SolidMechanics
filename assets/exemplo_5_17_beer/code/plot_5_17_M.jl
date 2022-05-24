# This file was generated, do not modify it. # hide
# Gráfico de momento fletor.
using Plots
xt = [0, a, a+b, a+b+c, a+b+c+d]
xs = 0.0:0.01:(a+b+c+d)
Plots.plot(xs,M.(xs),
            w=3,
            color="blue",
            label=false,
            xlabel="x",
            ylabel="M(x)",
            labelfontsize=16,
            tickfontsize=16,
            formatter=:plain)
Plots.plot!(xt, M.(xt), 
            line=(3,:blue,:dash,:sticks),
            label=false,)
Plots.plot!(xs,zeros(length(xs)),label=false)

Plots.savefig(joinpath(@OUTPUT, "plot_5_17_M.png")) # hide