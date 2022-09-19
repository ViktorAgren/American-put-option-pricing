function [ep]  = MCCode(M,N,dW,k,tau,t,s)
%Basic Monte Carlo for calculating simulated prices
%   
%   [ep] = MCCode(M,N,dW,k,tau,t,s)
%
%   Inputs:
%   M           - Amount of simulations
%   N           - Amount of time-steps
%   dW          - Brownian motion path
%   k           - Level specific variable for the amount of brownian steps
%   tau         - Admissible stopping times
%   t           - Admissible starting times
%   s           - Current price of the underlying asset
%   
%   Outputs:
%   ep          - mean values of simulated prices
%
%   Notes:
%    (1) Default strike price K = 100, dt = 0.01, and L = 4. Edit function
%    to change desired parameters.

    K     = 95;
    T     = 1; 
    dt    = T/N;
    r     = 0.05; 
    sigma = 0.3;
    S     = s*ones(M,1); % S(0) for all realizations
	for j=1:N % 
        if  j == 1
            kindex = 1:k;
        else
            kindex = kindex(end):j*k;
        end
        S         = S + S.*(r*dt+sigma*sum(dW(1:M,kindex),2)); % Processes at next time step
        ep(j) = mean((exp(-r*(tau-t))*max(K-S(:),0))); % Mean calculation of the estimated prices
	end
end