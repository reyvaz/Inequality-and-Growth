function x = goldensection(fn,given_val,A,D,param,prod,k)
  % Maximization algorithm.
  %
  % Finds the value  between A and D that maximizes the objective function "fn", 
  % given all other arguments. Uses a golden section algorithm.
  %
  convcrit = 1E-9;  % convergence criterion
  diff = 1;         % arbitrary initial value greater than convcrit

    while (diff > convcrit)
      B = A + ((3-(5^0.5))/2)*(D-A);
      C = A + (((5^0.5)-1)/2)*(D-A);
      fB = fn(given_val, B, param, prod,k);
      fC = fn(given_val, C, param, prod,k);
      if fB >= fC
        D = C;
      else
        A = B;
      end 
      diff = abs(A-D);
    end
  x = (B+C)/2;
return