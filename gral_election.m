% Determines the result of the two-issue Condorcet elections.
%
% Compares, one by one, the utility for each agent on the entire policy (tax 
% and share) plane against the utility at the policy pair most preferred by the 
% median voter in 2 candidate elections.
%% Set the main parameters
run('params.m')
run('dist_gen.m')
policy_min  = 0.2;
policy_max = 1;
n = 200;
n_voters = 29;
policy_vector = linspace(policy_min,policy_max,n)';
prod = quantile(l_dist, n_voters);
[val, mean_idx] = min(abs(prod - mean(l_dist))); % find index of closest to the
prod(mean_idx) = mean(l_dist);                   % mean to replace
%% Find the most prefered platforms
% (to extract that of the median)
run('preferred_platforms.m')

%% Calculate the utility of all agents over the policy plane
u = zeros(n_voters,n,n);
for p = 1 : n_voters
  labor = prod(p);
  for i = 1 : n
    share = policy_vector(i);
    for j = 1 : n
      tau = policy_vector(j);
      u(p,i,j) = objfun(share,tau,param,labor,k);
    end
  end
end

%% Calculate the utility of all agents at the median's most prefered platform
u_eqm = zeros(n_voters,1);
med_index = ceil(n_voters/2);
taxmed = taup(med_index);     % these two are the policy most prefered by the median,
sharemed = thetap(med_index); % will be used to compete against all other platforms
for p = 1 : n_voters
  labor = prod(p);
  u_eqm(p) = objfun(sharemed,taxmed,param,labor,k);
end

%% Voting
better = ones(n_voters,n,n);
for p = 1 : n_voters % tests if the alternative platform is better than the
  for i = 1 : n      % median's most preferred
    for j = 1 : n
      if u(p,i,j) >= u_eqm(p)
        better(p,i,j) = 1;
      else
        better(p,i,j) = 0;
      end
    end
  end
end
votes = sum(better);
votes = squeeze(votes)';
figure
mesh(votes)
  title('Elections over the Two-Issues')
  axis([0 n 0 n 0.01 16])
  ylabel('\tau','FontSize',18)
  xlabel('\theta', 'FontSize',18)
  zlabel('Votes', 'FontSize',16)
  view(-170, 40)
  set(gca,'XTick',0:(n/5):n)
  set(gca,'Xticklabel',linspace(0, 1, 6), 'FontSize',13)
  set(gca,'YTick',0:(n/5):n)
  set(gca,'Yticklabel',linspace(0, 1, 6), 'FontSize',13)
saveas(gcf, 'platform_votes', 'epsc')