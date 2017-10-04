% Generates the productivity distribution. 
%
% Productivity has a log-normal distribution with mean 1 and corresponding 
% normal distribution variance of 1.2 to resemble a standard income 
% distribution. Modify norm_var to adjust the skewness of the log-normal 
% distribution. Higher is more skewed. 
% Turn the switch at the last section to visualize the productivity distribution
%% Generate Productivity Distribution
rng('default');
norm_mean = 1; 
norm_var = 1.4; % adjust this to skew the distribution. higher is more skewed
dist_mu = log((norm_mean^2)/sqrt(norm_var+norm_mean^2));
dist_var = sqrt(log(norm_var/(norm_mean^2)+1));
l_dist = lognrnd(dist_mu,dist_var,1,1000);   % contains the productivity distr.
mean_ldist = mean(l_dist);

%% Visually check the distribution
check_distribution = false;       % graphical visualization of the distribution
if check_distribution == true
  figure
  plot(quantile(l_dist, 99)) 
    title('Overall Productivity')
    ylabel('Productivity','FontSize',14)
    xlabel('100-tile from poorest to richest','FontSize',14)
  figure
  hist(l_dist,100);
      title('Productivity Distribution')
      ylabel('Count','FontSize',14)
      xlabel('Productivity','FontSize',14)
end