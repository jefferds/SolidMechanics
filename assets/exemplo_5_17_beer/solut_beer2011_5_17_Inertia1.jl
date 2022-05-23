# This file was generated, do not modify it. # hide
# Cálculo do momento de Inércia

h = 420.0e-3
bf = 261.0e-3
tf = 11.6e-3
tw = 19.3e-3
d1 = d3 = h/2-tf/2

I1z = (bf * tf^3)/12 + bf*tf*d1^2
I2z = (tf * (h-2*tf)^3)/12
I3z = (bf * tw^3)/12 + bf*tw*d3^2

Iz = I1z + I2z + I3z

println("Iz = $(round(Iz,digits=6)) m^2")