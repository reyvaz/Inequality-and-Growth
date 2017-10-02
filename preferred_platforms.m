% Determines the policy pairs most preferred by each voter.
% 
% Requires that the voters have already been identified in the environment. It
% is used by other programs, it will not act by itself. To see an example of
% its results, run the last section of the reproduce script. 
%
taustar = zeros(n_voters,n); 
for p = 1 : n_voters
  labor = prod(p);
  for i = 1 : n
    share = policy_vector(i);
    taustar(p,i)  = goldensection(@objfun, share, policy_min, policy_max,...
        param, labor,k);
  end
end
thetastar = zeros(n_voters,n);
for p = 1:n_voters
  labor = prod(p);
  for i = 1 : n
    tax = taustar(p,i);
    thetastar(p,i)  = goldensection(@objfun2, tax, policy_min, policy_max,...
        param, labor,k);
  end
end
u = zeros(n_voters,n);
for p = 1:n_voters
  labor = prod(p);
  for i = 1 : n
    share = thetastar(p,i);
    tau = taustar(p,i);
    u(p,i) = objfun(share,tau,param,labor,k);
  end
end
umax = ones(n_voters,1);
posit = ones(n_voters,1);
for p = 1:n_voters
  [umax(p), posit(p)] = max(u(p,:)');
end
taup = ones(n_voters,1);
thetap = ones(n_voters,1);
for p = 1:n_voters
  taup(p) = taustar(p,posit(p));
  thetap(p) = thetastar(p,posit(p));
end