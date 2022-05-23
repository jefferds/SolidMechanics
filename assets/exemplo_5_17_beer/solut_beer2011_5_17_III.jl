# This file was generated, do not modify it. # hide
# Funções Momento e Esforço cortante no setor III.
MIV(x) = RA*x - P1*(x-a) - P2*(x-a-b) - (ω/2)*(x-a-b-c)^2;
VIV(x) = RA - P1 - P2 - ω*(x-a-b-c);