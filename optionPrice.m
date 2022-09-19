t=0;
s=100;
N0 = 100; % Amount of time-steps for L = 0
M0 = 2^10; % Amount of simulations
L  = 4; % Amount of levels
dW = sqrt(1 / (2^(L) * N0)) * randn(M0,2^(L) * N0); % Brownian motion
for x = 1 : size(s,2) % Loop for initial stock price
    fa = zeros(1,size(t,(2)));
    for j = 1 : size(t,(2)) % Loop for admissible starting times
        N    = round((1 - t(j)) / (1 / N0)); % Amount of time-steps for [t,T]
        tau  = 1 / N0 + t(j) : 1 / N0 : 1; % Admissible stopping times
        t0   = linspace(0,1,N);
        est  = zeros(1,size(t,(2)));
        for i = 1 : size(tau,2) % Loop for stopping times
            ep0 = MCCode(M0,N,dW,(2^(L)),tau(i),t(j),s(x)); % Expected value when L = 0
            sum = ep0;
            if L == 0 
                est(i)  = max(sum);
            end
            for k = 1 : L % Loop for levels
                tf = linspace(0,1,2^k*N); % Time-steps for fine simulation
                tc = linspace(0,1,2^(k-1)*N); % Time-steps for course simulation
    
            	ep1f    = MCCode(M0/2^(k),2^(k)*N,dW,(2^(L)*N)/(2^(k)*N),tau(i),t(j),s(x)); % Expected fine value when L = k
            	ep0c    = MCCode(M0/2^(k),2^(k-1)*N,dW,(2^(L)*N)/(2^(k-1)*N),tau(i),t(j),s(x)); % Expected course value when L = k-1
            	ep1fInt = interp1(tf,ep1f,t0);
            	ep0cInt = interp1(tc,ep0c,t0);
            	sum     = sum + ep1fInt - ep0cInt; % Estimate the expectation for all levels
            	est(i)  = max(sum);
            end
        end
        fa(j) = max(est);
    end
    fA(x) = max(fa);
end