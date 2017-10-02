% Determines de equilibrium policy pairs and the effects on growth for different
% income distributions.
%
% It determines different electoral outcomes by altering the productivity of 
% the median voter relative to that of the mean (which is ~1). Then it
% determines the effects of such outcomes on growth. Assumes a median voter
% equilibrium determined by the Condorcet/Stackelberg criteria, which has been 
% established in the accompanying programs. 
% 
%% Set the main parameters
run('params.m')
policy_min = 0.001;
policy_max = 1;
n = 300;
policy_vector = linspace(policy_min,policy_max,n)';
n_voters = 300; % will keep this name, although it is just one voter with  
% n_voters different productivites
prod = linspace(0,1,n_voters)'; % levels for the productivity of the median

%% Find the platform most prefered by the median agent with different
% distribution characteristics, "relative" to the mean. 
eqm_platform = zeros(n_voters,4);
growth = zeros(n_voters,2); % To calculate also policy effects on growth. 
exp = alpha/(1-alpha);
for s = 1:2 % will report effects for two common values of sigma
  sigma = 2+s;
  param.sigma = sigma;
  run('preferred_platforms.m')
  eqm_platform(:,s) = taup;
  eqm_platform(:,(s+2)) = thetap;
  product = taup.*thetap;
  growth(:,s) = (1/sigma)*((1-taup).* ((1-alpha)*(product.^exp)) - rho);
end

%% Plotting equilibrium Policies
figure
plot(prod, eqm_platform(:,1),'m', prod, eqm_platform(:,2),'b',...
    prod, eqm_platform(:,3),'m', prod, eqm_platform(:,4),'b',...
    prod, product, 'k--')
    title('Political Equilibrium Policies')
    xlabel('median as percentage of the mean','FontSize',14)
    ylabel('equilibrium policy', 'FontSize',14)
    xlim([0 1])
    ylim([0 1.03])
    text(0.52, 0.46, '\tau*','FontSize',16)
    text(0.52, 0.74, '\theta*', 'FontSize',16)
    text(0.2, 0.28, '\theta*\tau* = \alpha', 'FontSize',16)
    legend({'\sigma = 3', '\sigma = 4'},'FontSize',15, 'Location', 'southeast')
saveas(gcf, 'eqm_pcy','epsc')

%% Plotting growth effects of the equilibrium Policies
figure
normalize = 1/max(growth(:,1));
plot(prod, growth(:,1)*normalize, 'm', prod, growth(:,2)*normalize)
    title('Growth over Different Distributions')
    xlabel('median as percentage of the mean','FontSize',14)
    ylabel('growth percentual variation', 'FontSize',14)
    legend({'\sigma = 3', '\sigma = 4'},'FontSize',15, 'Location', 'southeast')
    saveas(gcf, 'growth','epsc')
sigma = 3;
param.sigma = sigma; % return sigma to its main value

%% The following, if true will perform further equilibrium analysis
eqm_policy = false; 
if eqm_policy == true
  run('preferred_platforms.m')
  p_axis = prod; % need a vector of lenght prod from 0 to 1
  products = taup.*thetap;
  figure
  plot(thetap, taup)
    title('Equilibrium \tau, \theta Relationship')
    ylabel('\tau','FontSize',14)
    xlabel('\theta', 'FontSize',14)
  figure
  plot(p_axis, products) % it can be seen that the product is ~alpha
    title('Product \theta\tau ')
    xlabel('productivity', 'FontSize', 14)
    ylabel('\theta\tau ', 'FontSize',14)
  figure
  plot(p_axis, taup,'r', p_axis, thetap,'b');      % plots the corresponding 
    title('Equilibrium \tau, \theta')              % theta for each tau
    ylabel('\tau, \theta', 'FontSize',14)
    xlabel('productivity', 'FontSize',14)
end