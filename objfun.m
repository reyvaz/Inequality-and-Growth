function va = objfun(theta,tau,param,labor,k)
  % Contains the utility (objective) function given by equation 16.
  %
  % It has been adapted for simplicity, see notes below
  %
  alpha = param.alpha;
  rho   = param.rho;
  K     = param.K;
  sigma = param.sigma;
  mu    = param.mu;
  product = theta*tau; % To construct MPL and MPK (w & r) more easily
  exp = alpha/(1-alpha);
  consumption = ((product^exp)*K*(((1-tau)*(((alpha)*labor*mu) +...
        ((((sigma) - 1)/sigma)*(1-alpha)*(k/K)))) +...
        ((1-theta)*tau*mu))) + (rho*k/sigma);
        % consumption is is modified version of c_0, since c's expression is
        % identical, including at time 0, is built from eq. 13,
        % substituting for sigma (growth rate) from eq (11)
  growth = (1/sigma)*(((1-tau)*(1-alpha)*(product^exp)) - rho); % Equation 11
  u  = (consumption^(1-sigma))/((1-sigma)*((growth*(sigma-1)) + rho));
  va = u;
return