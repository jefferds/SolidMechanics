# This file was generated, do not modify it. # hide
# Cálculo da tenssão máxima na viga

σ(x) = (M(x)/Iz) * (h/2)

using Plots
xt = [0, a, a+b, a+b+c, a+b+c+d]
xs = 0.0:0.01:(a+b+c+d)
Plots.plot(xs,σ.(xs),
            w=3,
            color="red",
            label=false,
            xlabel="x",
            ylabel="σ(x)",
            labelfontsize=16,
            tickfontsize=16,
            formatter=:plain)
Plots.plot!(xt, σ.(xt), 
            line=(3,:tomato,:dash,:sticks),
            label=false)
Plots.plot!(xs,zeros(length(xs)),label=false, color="gray50")
Plots.savefig(joinpath(@OUTPUT, "plot_5_17_tensao.png")) # hide