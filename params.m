
% Sets the main parameters
%
% Adjust parameters for robustness checks and other policy evaluations
% To see the results in a Krusell, Rios-Rull (1999) economy,  use 
% alpha = ¼,  sigma = 2
%
alpha = 1/3;
rho   = 0.02;
sigma = 3;
n  = 200;
policy_min = 0.001; % min value of policy to be evaluated. i.e. min tax
policy_max = 1; 
n = 200;
policy_vector = linspace(policy_min, policy_max,n)';
K  = 1; % K, k, mu are left here for convenience when testing for wealth distr.
k  = 1;
mu = 1; 
param.alpha = alpha;
param.rho   = rho;
param.sigma = sigma;
param.K  = K;
param.mu = mu;
