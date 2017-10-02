% Calculates and plots the reaction functions theta(tau) and tau(theta)
%
% For each voter, it searches for her most preferred tax for a given share, and
% her most preferred share for a given tau. n_voters = 9 has been picked for
% aesthetical purposes. Its value will not alter the underlying conclusions.
%
%% Set the main parameters
run('params.m')
run('dist_gen.m')
policy_min = 0.001; % min value of policy to be evaluated. i.e. min tax
policy_max = 1; 
n = 200;
policy_vector = linspace(policy_min, policy_max,n)';
n_voters = 9;
prod = quantile(l_dist, n_voters);  % Pick 9 representative individuals. each 
% representing 1 of 9 quantiles. Then I will replace the individual closest to 
% the mean, by the mean individual. Increase number for smoother curve,
% however, larger number offers no extra information to the analysis,
% except sanity checks. 
[val, mean_idx] = min(abs(prod - mean(l_dist))); % find index of closest to the
% mean to replace
prod(mean_idx) = mean(l_dist);
%% Visualize voters to be used
figure
plot(prod)
  title('(Chosen 9-tiles) Productivity')
  ylabel('Productivity','FontSize',14)
  xlabel('9-tiles from poorest to richest','FontSize',14)

%% Estimate the reaction functions 
taustar = zeros(n_voters,n);
for j = 1 : n_voters
  labor = prod(j);
  for i = 1 : n
    share = policy_vector(i);
    taustar(j,i)  = goldensection(@objfun, share, policy_min, policy_max,...
        param, labor,k);
  end
end

thetastar = zeros(n_voters,n);
for j = 1 :n_voters
  labor = prod(j);
  for i = 1 : n
    tax = policy_vector(i);
    thetastar(j,i)  = goldensection(@objfun2, tax, policy_min,policy_max,...
        param, labor,k);
  end
end
%% Plot the reaction functions
%figure
plot(policy_vector, taustar')
  title('Reaction Function, \tau (\theta)')
  ylabel('\tau (\theta)','FontSize',15)
  xlabel('\theta', 'FontSize',15)
  xlim([0 1])
  ylim([0 1])
  text(0.6, 0.59, 'poorest','FontSize',14)
  text(0.35, 0.45, 'richest', 'FontSize',14)
saveas(gcf, 'reaction_tau','epsc')
figure
plot(policy_vector, thetastar')
  title('Reaction Function, \theta(\tau)')
  xlabel('\tau','FontSize',15)
  ylabel('\theta (\tau)', 'FontSize',15)
  xlim([0 1])
  ylim([0 1])
  text(0.47, 0.56, 'poorest','FontSize',14)
  text(0.65, 0.7, 'richest', 'FontSize',14)
saveas(gcf, 'reaction_theta','epsc')   
figure
plot(policy_vector, taustar', thetastar', policy_vector)
  title('Reaction Functions, Combined')
  ylabel('\tau (\theta)','FontSize',15)
  xlabel('\theta (\tau)', 'FontSize',15)
  xlim([0 1])
  ylim([0 1])
  text(0.12, 0.74, 'poorest','FontSize',14)
  text(0.2, 0.50, 'richest', 'FontSize',14)
  text(0.36, 0.81, 'poorest','FontSize',14)
  text(0.8, 0.58, 'richest', 'FontSize',14)
saveas(gcf, 'reaction_mix','epsc')