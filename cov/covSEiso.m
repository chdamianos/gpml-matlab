function [A, B] = covSEiso(hyp, x, z)

% Squared Exponential covariance function with isotropic distance measure. The 
% covariance function is parameterized as:
%
% k(x^p,x^q) = sf^2 * exp(-(x^p - x^q)'*inv(P)*(x^p - x^q)/2) 
%
% where the P matrix is ell^2 times the unit matrix and sf^2 is the signal
% variance. The hyperparameters are:
%
% hyp = [ log(ell)
%         log(sf)  ]
%
% For more help on design of covariance functions, try "help covFunctions".
%
% Copyright (c) by Carl Edward Rasmussen and Hannes Nickisch, 2009-12-17.
%
% See also COVFUNCTIONS.M.

if nargin<2, A = '2'; return; end                  % report number of parameters

ell = exp(hyp(1));                                 % characteristic length scale
sf2 = exp(2*hyp(2));                                           % signal variance

if nargin==2
  A = sf2*exp(-sq_dist(x'/ell)/2);
elseif nargout==2                                 % compute test set covariances
  A = sf2*ones(size(z,1),1);
  B = sf2*exp(-sq_dist(x'/ell,z'/ell)/2);
else                                                 % compute derivative matrix
  if z==1                                                      % first parameter
    A = sf2*exp(-sq_dist(x'/ell)/2).*sq_dist(x'/ell);  
  else                                                        % second parameter
    A = 2*sf2*exp(-sq_dist(x'/ell)/2);
  end
end