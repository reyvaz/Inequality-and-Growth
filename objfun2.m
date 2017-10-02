function va = objfun2(tau,theta,param, prod,k)
  % Contains the utility (objective) function given by equation 16. Separate,
  % auxiliary script used for utility maximization over theta
  %
  % It has been adapted for simplicity, see notes below
  %
  alpha = param.alpha;
  rho   = param.rho;
  K     = param.K;
  sigma = param.sigma;
  mu    = param.mu;

  product   = theta*tau;
  exp = alpha/(1-alpha);
  consumption  = ((product^exp)*K*(((1-tau)*(((alpha)*prod*mu) +...
        ((((sigma) - 1)/sigma)*(1-alpha)*(k/K)))) +...
        ((1-theta)*tau*mu))) + (rho*k/sigma);
        % consumption is is modified version of c_0, since c's expression is
        % identical, including at time 0, is built from eq. 13,
        % substituting for sigma (growth rate) from eq (11)
  growth  = (1/sigma)*(((1-tau)*(1-alpha)*(product^exp)) - rho);
  u = (consumption^(1-sigma))/((1-sigma)*((growth*(sigma-1)) + rho));
  va = u;
return