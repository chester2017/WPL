function [r] = diverse(x)
%DIVERSE  Compute diversity of molecules in dataset
% John R. Owen, NCRG, Aston University, UK, 16 Mar 2011
%
% 
% Inputs:
% x             Dataset of fingerprints
%
% Outputs:
% r             Intradataset distance
%


% No. entries in x
xr = size(x, 1);

% Distance table
dt = zeros(xr, xr); 

fprintf('Computing distance table.....\n');

% Load distance table
for i = 1:xr;
    for j = i:xr;
        h1 = x(i, :);
        h2 = x(j, :);
        dt(i, j) = mol_dis(h1, h2, 'tanimoto');
    end;
end;

% Complete by symmetry
dt = dt + (dt');

% Return intradataset distance
r = mean(mean(dt));




