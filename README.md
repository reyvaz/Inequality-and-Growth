<a href="https://rvaz.shinyapps.io/english_predictor/" target="_blank">
<b>CLICK HERE</b></a> to try it online

### Growth Implications of the Political Determination of Transfers and Public Investment (Simulation Scripts)

### About the paper  

The paper inquires into the effects of inequality on economic performance. A key assumption is that public spending is a complement to private inputs in the production process. Heterogeneity on the ability to earn income creates a conflict of interests between agents on public policy. Specifically, some agents differ on their most preferred tax rate, on how much of total tax revenue should be devoted to public investment, and how much should be devoted to income transfers. Results in a parameterized model of endogenous growth suggest that if the agent, who is the median in the distribution of income, is sufficiently poorer than the mean, a political outcome creates distortions that hinder economic growth. The result is mainly driven by the skewness of the income distribution. [See the paper here (pdf)](google.com).

### About the files  

Numerical simulations were programed in Matlab for illustration and to complement parts of the analysis for which mathematical results were no longer practical. The programs have been updated for complete and easy reproducibility.  The main programs are written to each run independently, so when reproducing the entire analysis, some redundant (although quick) set-ups will occur.

### Contents and instructions
* [reproduce.m](reproduce.m) and [reproduce.mlx](reproduce.mlx) will reproduce the entire graphical analysis of the paper. Turn the switches on or off (true or false) to include or skip sections. Each section will run independently.   
* [dist_gen.m](dist_gen.m) creates the (log-normal) productivity distribution.  
* [goldensection.m](godensection.m) contains the Golden Section maximization algorithm.  
* [gral_election.m](gral_election.m) produces the results of the two-issue Condorcet elections, where the winner is the candidate $i$ for which all of its rival votes' satisfy,
$\sum_{\{i \in I: U(\theta, \tau, \lambda_i) - U (\theta^*, \tau^*, \lambda_i)>0\}}  \mu_i \leq \frac{1}{2}$ $\forall (\theta,\tau)$ *in the plane* $\theta \in (0,1] \times \tau \in (0,1]$
* [utilities.m](utilities.m) demonstrates concavity and single-peakedness of the utility function over the policy plane. Depicts indiference curves for select voters over the two issues. 
* [objfun.m](objfun.m) contains the utility function given by equation 15, substituting with earlier definitons of its parts.   

$U^i = \frac{ (c^i_0)^{1-\sigma}}{(1-\sigma)[\rho - \gamma(1-\sigma)]}$  
where  $c_0^i$ is its time invariant version,

$c_0^i = (1-\tau) [r(\theta, \tau)k^i_t + w(\theta, \tau)k_t l^i] + (1-\theta)\tau y_t - \gamma k^i_t$  
and  

$\gamma (\theta, \tau)  \equiv  \frac{1}{\sigma}[(1-\tau)r(\theta, \tau) - \rho] = \frac{1}{\sigma}[(1-\tau)(1-\alpha) (\theta \tau)^{\frac{\alpha}{1-\alpha}}- \rho]$

* [objfun2.m](objfun2.m) contains the same function as objfun.m, but it is used as an auxiliary for utility maximization over $\theta$.  
* [params.m](params.m) contains the main economy parameters. All programs depend on this. Alter values here to make robustness and model-sanity checks, as well as policy evaluations. 
* [pareto_optimum.m](pareto_optimum.m) approximates the Pareto Optimum set of policy pairs.
* [partial_election.m](partial_election.m) shows that the median voter's most preferred one-issue policies are also the Kramer-Shapsle and Stackelberg equilibria (a.k.a. Condorcet victors)  
* [policy_effects.m](policy_effects.m) once the median voter equilibrium has been established, it shows the economy's equilbrium policy pairs for different income distributions. Also shows the effects of these policies on growth.   

* [reaction_fns.m](reaction_fns.m)  calculates and plots the reaction functions $\theta(\tau)$ and $\tau(\theta)$ for each voter over the two policy vectors. 


<br>
<p align="center">
<a href="https://reyvaz.github.io/NLP-English-Predictor/" 
rel="github pages">
<img src="poorutility.eps" alt="Drawing" width = "500"></a>
</p>
<br>