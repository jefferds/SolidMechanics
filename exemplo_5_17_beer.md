@def reeval = true

# Exemplo: Exercício 5.17 do Beer.

**Conteúdo:**

\toc

## O problema:

**5.17** Para a viga e o carregamento mostrados na figura, determine a  tensão normal ao longo da viga.

\figenv{Figura 1 - Viga carregada.}{/assets/beer2011-fig-5-17.png}{width:50%;}{fig-beer2011-fig-5-17}
@@fonte
Fonte: Modificado de \citep{Beer2011}.
@@

## Solução:

### Equações utilizadas: 

$$\sigma = \dfrac{My}{I}, \quad I = \dfrac{bh^3}{12} \label{Eq-tensoes}$$

$$\sum{F} = 0, \quad \sum{M} = 0 \label{Eq-equilibrio}, \quad V=\dfrac{dM}{dx}$$

### Cálculo das reações

#### Diagrama de corpo livre:

\figenv{Figura 2 - Diagrama de corpo livre.}{/assets/dcl-5-17.png}{width:50%;}{fig-dcl-5-17}

Na Figura \reffig{#fig-dcl-5-17}{2}, considere:

$$\begin{aligned}
P1 &= P2 = 112,2\;kN \\ 
ω &= 73\;kN/m \\ 
a &= b = c = 762 \; mm\\
d &= 2286 \; mm 
\end{aligned}$$

```julia:./solut_beer2011_5_17_a.jl
# Entrada de dados no código julia.
P1 = P2 = 112.2e3    # N 
ω = 73e3             # N/m  
a = b = c = 762e-3   # m
d = 2286e-3          # m 
println("Entrada de dados realizada com sucesso!")
```

~~~<br>~~~

A força concentrada $W$ será calculada por 

$$W = \omega . d$$

```julia:./solut_beer2011_5_17_b.jl
# Cálculdo força concentrada W
W = ω*d;      # N
println("A força concentrada será igual a $W N");
```

As reações $RA$ e $RB$ obtidas com o auxílio das equações \eqref{eq-equilibrio} e

$$\begin{aligned}
&\sum M_A = 0 \\ 
&- P1.a - P2.(a+b) - W.(a+b+c+d/2) + \\ 
& \hspace{14em}RB.(a+b+c+d) = 0 \\
&RB = \dfrac{P1.a + P2.(a+b) + W.(a+b+c+d/2)}{a+b+c+d}
\end{aligned}$$


```julia:./solut_beer2011_5_17_c.jl
# Cálculdo da força RB
RB = (P1*a + P2*(a+b) + W*(a+b+c+d/2))/(a+b+c+d);

println("A força de reação RB será igual a $(RB) N");
```

$$\begin{aligned}
&\sum F_y = 0 \\ 
&RA + RB - P1 - P2 - W = 0 \\
&RA = - RB + P1 + P2 + W
\end{aligned}$$

```julia:./solut_beer2011_5_17_d.jl
# Cálculdo da força RB
RA = -RB + P1 + P2 + W;

println("A força de reação RA será igual a $(RA) N");
```

### Cálculo dos esforços internos

Para o cálculo dos esforços internos, utilizaremos a equação de equilibrio \eqref{eq-equilibrio} e o método das seções, seccionando a viga nos setores $I$, $II$, $III$, e $IV$. Conforme mostrado na Figura \reffig{#fig-dcl-secoes-5-17}{3}, temos:

\figenv{Figura 3 - Posição das seções para cálculo dos esforços internos.}{/assets/dcl-secoes-5-17.png}{width:60%;}{fig-dcl-secoes-5-17}

1. Setor $I$:

~~~<hr>~~~

\figenv{Figura 4 - Esforços internos na seção I.}{/assets/dcl-secoes-5-17-I.png}{width:30%;}{fig-dcl-secoes-5-17-I}

$$\begin{aligned}
&\sum M_{I} = 0 \\ 
&M - RA.x = 0 \\
&M(x) = RA.x \\
\end{aligned}$$

$$\begin{aligned}
&V = \dfrac{dM}{dx} \\
&V(x) = RA\\
\end{aligned}$$


```julia:./solut_beer2011_5_17_I.jl
# Funções Momento e Esforço cortante no setor I.
MI(x) = RA*x;
VI(x) = RA;
```

1. Setor $II$:

~~~<hr>~~~

\figenv{Figura 5 - Esforços internos na seção II.}{/assets/dcl-secoes-5-17-II.png}{width:30%;}{fig-dcl-secoes-5-17-II}

$$\begin{aligned}
&\sum M_{II} = 0 \\ 
&M - RA.x + P1.(x-a) = 0 \\
&M(x) = RA.x - P1.(x-a)\\
\end{aligned}$$

$$\begin{aligned}
&V = \dfrac{dM}{dx} \\
&V(x) = RA - P1\\
\end{aligned}$$

```julia:./solut_beer2011_5_17_II.jl
# Funções Momento e Esforço cortante no setor II.
MII(x) = RA*x - P1*(x-a);
VII(x) = RA - P1;
```


1. Setor $III$:

~~~<hr>~~~

\figenv{Figura 6 - Esforços internos na seção III.}{/assets/dcl-secoes-5-17-III.png}{width:30%;}{fig-dcl-secoes-5-17-III}

$$\begin{aligned}
&\sum M_{III} = 0 \\ 
&M - RA.x + P1.(x-a) + P2.(x-a-b)= 0 \\
&M(x) = RA.x - P1.(x-a) - P2.(x-a-b)\\
\end{aligned}$$

$$\begin{aligned}
&V = \dfrac{dM}{dx} \\
&V(x) = RA - P1 - P2\\
\end{aligned}$$

```julia:./solut_beer2011_5_17_III.jl
# Funções Momento e Esforço cortante no setor III.
MIII(x) = RA*x - P1*(x-a) - P2*(x-a-b);
VIII(x) = RA - P1 - P2;
```

1. Setor $IV$:

~~~<hr>~~~

\figenv{Figura 7 - Esforços internos na seção IV.}{/assets/dcl-secoes-5-17-IV.png}{width:50%;}{fig-dcl-secoes-5-17-IV}

$$\begin{aligned}
&W0 = ω*(x-a-b-c)
\end{aligned}$$

$$\begin{aligned}
&\sum M_{IV} = 0 \\ 
&M - RA.x + P1.(x-a) + P2.(x-a-b) + W0.\dfrac{1}{2}.(x-a-b-c) = 0 \\
&M - RA.x + P1.(x-a) + P2.(x-a-b) + ω.\dfrac{1}{2}.(x-a-b-c)^2 = 0 \\
&M(x) = RA.x - P1.(x-a) - P2.(x-a-b) - ω.\dfrac{1}{2}.(x-a-b-c)^2
\end{aligned}$$

$$\begin{aligned}
&V = \dfrac{dM}{dx} \\
&V(x) = RA - P1 - P2 - ω.(x-a-b-c)\\
\end{aligned}$$

```julia:./solut_beer2011_5_17_III.jl
# Funções Momento e Esforço cortante no setor III.
MIV(x) = RA*x - P1*(x-a) - P2*(x-a-b) - (ω/2)*(x-a-b-c)^2;
VIV(x) = RA - P1 - P2 - ω*(x-a-b-c);
```

Para gerar os valores do momento fletor e esforço cortante em todo a viga vamos criar as funções `M(x)` e `V(x)` que retornem os valores para todos os setores.

```julia:./solut_beer2011_5_17_MV.jl
# Funções Momento e Esforço

function M(x)
    if x <= a
        return MI(x);
    elseif x <= a+b
        return MII(x);
    elseif x <= a+b+c
        return MIII(x);
    else
        return MIV(x);
    end
end;
    
function V(x)
    if x <= a
        return VI(x);
    elseif x <= a+b
        return VII(x);
    elseif x <= a+b+c
        return VIII(x);
    else
        return VIV(x);
    end
end;

```

### Diagramas de momento fletor e esforço cortante.

**Gráfico de momento fletor:**

```julia:plot_5_17_M
# Gráfico de momento fletor.
using Plots
using LaTeXStrings
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
```

\fig{plot_5_17_M}


```julia:plot_5_17_V
# Gráfico de momento fletor.
using Plots
using LaTeXStrings
xt = [0, a, a+b, a+b+c, a+b+c+d]
xs = 0.0:0.01:(a+b+c+d)
Plots.plot(xs,V.(xs),
            w=3,
            color="tomato",
            label=false,
            xlabel="x",
            ylabel="V(x)",
            labelfontsize=16,
            tickfontsize=16,
            formatter=:plain)
Plots.plot!(xt, V.(xt), 
            line=(3,:tomato,:dash,:sticks),
            label=false)
Plots.plot!(xs,zeros(length(xs)),label=false, color="gray50")
Plots.savefig(joinpath(@OUTPUT, "plot_5_17_V.png")) # hide
```

\fig{plot_5_17_V}

### Cálculo do momento de inércia

O perfil $W\;410 \times 114$ tem suas dimensões definidas (ver [LABCIV-UERJ](http://www.labciv.eng.uerj.br/rm4/tabelaW.pdf)) e são mostradas na figura abaixo.

\figenv{Figura 10 - Dimensões da secção.}{/assets/beer2011-fig-5-17-section.png}{width:80%;}{fig-dcl-5-17}

Onde

~~~<table border="0" cellpadding="0" cellspacing="0">
            <tr height="14" hidden>
                <td colspan="14"></td><td colspan="14"></td>
            </tr>
            <tr height="14">
                <td colspan="14"> h </td> <td colspan="14"> 420 mm </td>
            </tr>
            <tr height="14">
                <td colspan="14"> bf </td> <td colspan="14"> 261 mm </td>
            </tr>
            <tr height="14">
                <td colspan="14"> tw </td> <td colspan="14"> 19,3 mm</td>
            </tr>
            <tr height="14">
                <td colspan="14"> tf </td> <td colspan="14"> 11,6 mm </td>
            </tr>
    </table>~~~

Para o cálculo do momento de inércia temos que 

$$\begin{aligned}
I_z &= I_{1z} + I_{2z} + I_{3z}\\
\\
I_{nz} &= \dfrac{b \times h^3}{12} + A.d_n^2 \\ 
\\
I_{1z} &= \dfrac{b_f \times t_f^3}{12} + b_f.t_f.d_1^2 \\ 
I_{2z} &= \dfrac{t_f \times (h-2.t_f)^3}{12}\\
I_{3z} &= \dfrac{b_f \times t_w^3}{12} + b_f.t_w.d_3^2
\end{aligned}$$

```julia:./solut_beer2011_5_17_Inertia1.jl
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

```

### Cálculo das tensões máximas

As tensões máximas em cada seção ocorrem para $y = y_{maximo} = h/2$. Assim,

$$
\sigma = \dfrac{M \times y_{maximo}}{I_{z}} = \dfrac{M }{I_{z}} \times \dfrac{h}{2}
$$

```julia:plot_5_17_tensao
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

```

\fig{plot_5_17_tensao}

~~~<br>~~~

Logo, a máxima tensão na viga ocorre para $x = a + b$ e terá valor de 

```julia:./solut_beer2011_5_17_max.jl
# Cálculo da tensão máxima na viga

println("A máxima tensão será σ_max = $(round(σ(a+b)/1e6,digits = 2)) Mpa")

```




## Referências

* \biblabel{Beer2011}{Beer (2011)} BEER, Ferdinand P. et al. [**Mecânica dos materiais**](https://scholar.google.com.br/scholar?hl=pt-BR&as_sdt=0%2C5&q=Numerical+simulation+for+next+generation+thermal+power+plants&btnG=). Porto Alegre: AMGH, 2011.
