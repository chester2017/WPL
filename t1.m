%
% Compute diversity of datasets
% John R. Owen, NCRG, Aston University, UK, 16 Mar 2011
%

clear all;

h1 = '..';
h2 = 'common';
h3 = fullfile(h1, h2);
addpath(h3);

h1 = '..';
h2 = 'common';
h3 = 'dataset_l1_l2';
h4 = fullfile(h1, h2, h3);
addpath(h4);

h1 = '..';
h2 = 'common';
h3 = 'dataset_l3';
h4 = fullfile(h1, h2, h3);
addpath(h4);


% Table of diversities
dt = zeros(12, 1);



% NB: Order of libraries is below
% Library A: l11, l14, l22, l24, l25
% Library B: l11, l23, l32, l33, l34


% ---------
% Library A
% ---------

load('l11.mat');
dt(1) = diverse(l11);

load('l14.mat');
dt(2) = diverse(l14);

load('l22.mat');
dt(3) = diverse(l22);

load('l24.mat');
dt(4) = diverse(l24);

load('l25.mat');
dt(5) = diverse(l25);

[x, ~] = load_library('l4');
dt(6) = diverse(x);


% ---------
% Library B
% ---------

load('l11.mat');
dt(7) = diverse(l11);

load('l23.mat');
dt(8) = diverse(l23);

load('l32.mat');
dt(9) = diverse(l32);

load('l33.mat');
dt(10) = diverse(l33);

load('l34.mat');
dt(11) = diverse(l34);

[x, ~] = load_library('l5');
dt(12) = diverse(x);


% ---------
% Library C
% ---------

[x, ~] = load_library('l4l5_5000');
dt(13) = diverse(x);

[x, ~] = load_library('l4l5');
dt(14) = diverse(x);



fprintf('\nLibrary A:\n');
fprintf('%4.2f\n', dt(1:6));

fprintf('\nLibrary B:\n');
fprintf('%4.2f\n', dt(7:12));

fprintf('\nLibrary C:\n');
fprintf('%4.2f\n', dt(13:14));






