% Numerically and visually determines the concavity of the utility function.
%
% Creates 3D utility plots for select voters
% Creates isoutility plots for select voters
%
%% Set the main parameters
run('params.m')
run('dist_gen.m')
policy_min = 0.001;
policy_max = 1;
prod = quantile(l_dist, 23);
[val, mean_idx] = min(abs(prod - mean(l_dist))); % find index of closest to the
% mean to replace
prod(mean_idx) = mean(l_dist);
n = 300;
policy_vector = linspace(policy_min, policy_max,n)';

% The following calculates the utility of different specific workers over the
% entire policy plane. These utility matrices are then used to ilustrate single
% peakedness of the utility function by plotting its shape and showing some
% indiference curves. 

%% Calculate and plot the utility of the mean worker (for ilustration)
labor = mean(l_dist);
u_mean = zeros(n,n);
for i = 1 : n
  share = policy_vector(i);
  for j = 1 : n
    tau = policy_vector(j);
    u_mean(i,j) = objfun(tau,share,param,labor, k);
  end
end

u_mean_mt = (u_mean+200)/171; % mt for monotonic transformation
figure
mesh(u_mean_mt)
axis([0 n 0 n 0.6 1.01])
caxis([0.6 1])
colormap(spring)
  title('Utility of Mean Voter')
  ylabel('\tau','FontSize',18)
  xlabel('\theta', 'FontSize',18)
  zlabel('Utility', 'FontSize',16)
  set(gca,'XTick',0:(n/5):n)
  set(gca,'Xticklabel',linspace(0, 1, 6), 'FontSize',13)
  set(gca,'YTick',0:(n/5):n)
  set(gca,'Yticklabel',linspace(0, 1, 6), 'FontSize',13)
  set(gca,'Zticklabel',[])
  view(32, 9)
saveas(gcf, 'mean_utility','epsc')

%% Calculate the utility of a "poor" worker
labor = prod(2);
u1 = zeros(n,n);
for i = 1 : n
  share = policy_vector(i);
  for j = 1 : n
    tau = policy_vector(j);
    u1(i,j) = objfun(tau,share,param,labor,k);
  end
end
%% Calculate the utility of a "not so poor" worker
labor = prod(7);
u2 = zeros(n,n);
for i = 1 : n
  share = policy_vector(i);
  for j = 1 : n
    tau = policy_vector(j);
    u2(i,j) = objfun(tau,share,param,labor,k);
  end
end

%% Calculate the utility of a worker close to the median
labor = prod(11);
u3 = zeros(n,n);
for i = 1 : n
  share = policy_vector(i);
  for j = 1 : n
    tau = policy_vector(j);
    u3(i,j) = objfun(tau,share,param,labor, k);
  end
end

%% Plot utility of the "poor" worker
% The following transforms variables for illustration. Transformations do not
% affect the numerical analysis. 
u1_mt = (u1+200)/171;
figure
mesh(u1_mt)
axis([0 n 0 n -0.5 1])
caxis([-0.5 1])
colormap(spring)
  title('Utility of a Poor Voter')  
  ylabel('\tau','FontSize',18)
  xlabel('\theta', 'FontSize',18)
  zlabel('Utility', 'FontSize',16)
  set(gca,'XTick',0:(n/5):n)
  set(gca,'Xticklabel',linspace(0, 1, 6), 'FontSize',13)
  set(gca,'YTick',0:(n/5):n)
  set(gca,'Yticklabel',linspace(0, 1, 6), 'FontSize',13)
  set(gca,'Zticklabel',[])
  view(45, 45)
saveas(gcf, 'poorutility','epsc')

%% Prepare utility values for isoutilities curve
v_max = max(max(u1_mt));
v_min = v_max - (v_max*.004);
v = linspace(v_min, v_max, 6);
% Normalize the other 2 utilities to have max as u1_mt, so they can be plotted
% in the same plane.
u2_mt  = (u2+200)/171;
v2_max = max(max(u2_mt));
dif12  = v2_max - v_max;
u2_normalized = u2_mt - dif12;

u3_mt  = (u3+200)/171;
v3_max = max(max(u3_mt));
dif13  = v3_max - v_max;
u3_normalized = u3_mt - dif13;
locus = alpha*(policy_vector.^(-1));
locus(locus > 1.1) = NaN;

%% Plot the 3 isoutilities
figure
contour(u1_mt, v) 
hold on;
contour(u2_normalized, v)
contour(u3_normalized, v)
plot(locus*n)
axis([0 n 0 n])
  title('Isoutilites for Select Voters')
  xlabel('\theta','FontSize',18)
  ylabel('\tau','FontSize',18)
  text(.45*n, .8*n, '\alpha = \theta\tau','FontSize',15)
  set(gca,'Xticklabel',linspace(0, 1, 11))
  set(gca,'Yticklabel',linspace(0, 1, 11))
saveas(gcf, 'isoutilities','epsc')