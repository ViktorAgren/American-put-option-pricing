## About The Project
In this bachelor thesis, we approximate the price of an American Put option using Multilevel Monte carlo simulation.

Assume that the stock value $S(t)$ evolves by the following stochastic differential equation
$$
    dS=\mu Sdt+\sigma SdW,
$$
where $\mu$ and $\sigma$ are the constant average growth rate and volatility, respectively, and $W=W(t)$ is a standard Brownian motion. The aim of the project is to implement the Multilevel Monte Carlo method for valuing American options. The research objective is to approximate,
$$
    f_A(t,s)\equiv \max\limits_{t\leq\tau\leq T}E\left[e^{-r(\tau-t)}\max\left(K-S(\tau),0\right)\mid S(t)=s\right],
$$
by implementing the Multilevel Monte Carlo method, where $K$ is the strike price, $S(t)$ is the spot price of the underlying asset, $\tau$ is the class of admissible stopping times with values in $[t,T]$, $r$ is the risk-free interest rate, and $s$ is the initial stock price.