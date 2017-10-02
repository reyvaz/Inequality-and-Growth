% Determines the results of the one-issue Condorcet elections.
%
% For every value of theta (or tau), finds the tau (or theta) that would win an
% election between the tau (or theta) most preferred by the median voter, 
% against all other taus (or thetas), one by one, on 2 candidate elections. 
%% Set the main parameters
run('params.m')
run('dist_gen.m')
policy_min = 0.01;
policy_max = 1;
n = 200;
policy_vector = linspace(policy_min,policy_max,n)';
n_voters = 29;
prod = quantile(l_dist, n_voters);
[val, mean_idx] = min(abs(prod - mean(l_dist)));
prod(mean_idx) = mean(l_dist);

%% Find the policies most prefered by the median agent, to compare during
% Condorcet (one issue) elections.
labor   = median(prod);
taustar = zeros(n);
for i = 1 : n
  share = policy_vector(i);
  taustar(i) = goldensection(@objfun, share, policy_min, policy_max,...
                  param, labor,k);
end
thetastar = zeros(n);
for i = 1 : n
  tax = policy_vector(i);
  thetastar(i) = goldensection(@objfun2, tax, policy_min, policy_max,...
                  param, labor,k);
end

%% Utilities of all agents over the entire policy plane
u = zeros(n_voters,n,n);
for p = 1 : n_voters % Utilities of all agents over the entire policy plane
  labor  = prod(p);
  for i = 1 : n
    share = policy_vector(i);
    for j = 1 : n
      tau = policy_vector(j);
      u(p,i,j) = objfun(share,tau,param,labor,k);
    end
  end
end

%% Condorcet elections over tau
u_eqm = zeros(n_voters,n); % Refers to the utility for any agent at the median's
           % most prefered level. For comparison when doing Condorcet elections.
for p = 1 : n_voters
  for i = 1:n
    taxmed = taustar(i);
    share  = policy_vector(i);
    labor  = prod(p);
    u_eqm(p,i) = objfun(share,taxmed,param,labor,k);
  end
end

wins = zeros(n_voters,n,n);
for p = 1 : n_voters
  for i = 1 : n
    for j = 1 : n
      if u(p,i,j) > u_eqm(p,i)
        wins(p,i,j) = 1;
      end
    end
  end
end
votes = sum(wins);
votes = squeeze(votes)';
figure
mesh(votes)
  title('One-issue Elections over \tau')
  axis([0 n 0 n 0.01 16])
  ylabel('\tau','FontSize',18)
  xlabel('\theta', 'FontSize',18)
  zlabel('Votes', 'FontSize',16)
  view(73, 35)
  set(gca,'XTick',0:(n/5):n)
  set(gca,'Xticklabel',linspace(0, 1, 6), 'FontSize',13)
  set(gca,'YTick',0:(n/5):n)
  set(gca,'Yticklabel',linspace(0, 1, 6), 'FontSize',13)
saveas(gcf, 'tax_votes','epsc')

%% Condorcet elections over theta
for p = 1 : n_voters
  for i = 1:n
    tax = policy_vector(i);
    sharemed = thetastar(i);
    labor  = prod(p);
    u_eqm(p,i) = objfun(sharemed,tax,param,labor,k);
  end
end
wins2 = zeros(n_voters,n,n);
for p = 1 : n_voters
  for i = 1 : n
    for j = 1 : n
      if u(p,i,j) > u_eqm(p,j) && policy_vector(i)<1
        wins2(p,i,j) = 1;
      end
    end
  end
end
votes2 = sum(wins2);
votes2 = squeeze(votes2);
figure
mesh(votes2)
  title('One-issue Elections over \theta')
  axis([0 n 0 n 0.01 16])
  xlabel('\tau','FontSize',18)
  ylabel('\theta', 'FontSize',18)
  zlabel('Votes', 'FontSize',16)
  view(45, 35)
  set(gca,'XTick',0:(n/5):n)
  set(gca,'Xticklabel',linspace(0, 1, 6), 'FontSize',13)
  set(gca,'YTick',0:(n/5):n)
  set(gca,'Yticklabel',linspace(0, 1, 6), 'FontSize',13)
saveas(gcf, 'share_votes','epsc')