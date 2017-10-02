% Approximates the Pareto Optimum set of policy pairs.
% 
% This is a computationally (relatively) more intense program. Utility of all  
% voters is compared against the utility of all other voters (in the entire 
% policy plane) so Pareto Optimality can be determined. Increase n to 2000 
% to reproduce the plot exactly as it appears in the article. 200 here will 
% produce a similar outcome but much less accurate. I believe a higher n will
% keep making the set more accurate, perhaps down to the alpha = theta*tau line,
% but it hasn't converged (exactly) to that result in all parameterizations and
% alternative programs ran thus far. The closest estimate was a thin, 10^(-7)
% thick, "line" over the alpha = theta*tau line
%
%% Set the main parameters
run('params.m')
run('dist_gen.m')
n = 300;  
policy_min = 0.01;
policy_max = 1;
n_voters = 9;     % reduced electorate, more voters will yield a similar result
policy_vector = linspace(policy_min,policy_max,n)';
prod = quantile(l_dist, n_voters);                              
[val, mean_idx] = min(abs(prod - mean(l_dist)));
prod(mean_idx) = mean(l_dist);
run('preferred_platforms.m')

%% Utility Matrices over the policy plane
u = zeros(n_voters,n,n);
for p = 1 : n_voters      
  labor = prod(p);
  for i = 1 : n
    share = policy_vector(i);
    for j = 1 : n
      tau = policy_vector(j);
      u(p,j,i) = objfun(share,tau,param,labor,k);
    end
  end
end

%% Set of PO; Assume all PO, then discard        
PO = ones(n,n);
up = zeros(n_voters,n_voters,n_voters);
for p = 1 : n_voters %calculating utility at most prefered policies
  labor = prod(p);
	for i = 1 : n_voters
    share = thetap(i);
    for j = 1 : n_voters
      tau = taup(j);
      up(p,j,i) = objfun(share,tau,param,labor,k);
    end
  end
end
%% Discard Pareto inferior to all agents' most preferred policies for all agents
for j = 1:n  
  for i = 1:n                                          
    for m = 1:n_voters
      for h = 1:n_voters
        if (min(up(:,h,m) - u(:,i,j))) > 0
          PO(i,j) = 0;
        end
      end
    end
  end
end
%% Intense Pareto Discarding
index_o = floor(n*(alpha*(1-alpha))); % Typically policies under this index
% are unpopular and already filtered out above. 
% It is done to minimize calculations. To test the entire range of policies, 
% set index_o = 1.
for j = index_o:n % Intense search. This will test, at every policy, if there's 
% another policy combination that makes at least one voter better off, without 
% making someone else worse off. If there's, it will be switched to a 0, since 
  for i = index_o:n                                 % it is not Pareto Optimum.
    if PO(i,j) > 0
      m = i;
      while PO(i,j) > 0 && m < n
        m = m + 1;
        h = index_o;
        while PO(i,j) > 0 && h < n
        	h = h + 1;
          if PO(h,m) > 0
            if (min(u(:,h,m) - u(:,i,j))) > 0
              PO(i,j) = 0;
            end
          end
        end
      end
    end
  end
end
%% Plot, end
figure
mesh(PO)
    title('Pareto Optimum Set (Approximation) of Policy Pairs')
    axis([0 n 0 n 0.01 1])
    ylabel('\tau','FontSize',16)
    xlabel('\theta', 'FontSize',16)
    view(0, 90)
    colormap(jet)
    set(gca,'Xticklabel',linspace(0, 1, 11))
    set(gca,'Yticklabel',linspace(0, 1, 11))
saveas(gcf, 'po_set20','epsc')