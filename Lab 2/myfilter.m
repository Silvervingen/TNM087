function [olp, ohp, obr, obp, oum, ohb]=myfilter(im, lp1, lp2)
%
% function [olp, ohp, obr, obp, oum, ohb]=myfilter(im, lp1, lp2)
%
%% LAB2, TASK2
%
%% Performs filtering
%
% Filters the original grayscale image, im, given two different lowpass filters
% lp1 and lp2 with two different cutoff frequencies.
% The results are six images, that are the result of lowpass, highpass,
% bandreject, bandpass filtering as well as unsharp masking and highboost
% filtering of the original image
%
%% Who has done it
%
% Authors: Antonio T�llberg Ilestad (antta839)
%          Ivar Gorenko             (ivago071)
%
%% Syntax of the function
%
%      Input arguments:
%           im: the original input grayscale image of type double scaled
%               between 0 and 1
%           lp1: a lowpass filter of odd size
%           lp2: another lowpass filter of odd size, with lower cutoff
%                frequency than lp1
%
%      Output arguments:
%            olp: the result of lowpass filtering the input image by lp1
%            ohp: the result of highpass filtering the input image by
%                 the highpass filter constructed from lp1
%            obr: the result of bandreject filtering the input image by
%                 the bandreject filter constructed from lp1 and lp2
%            obp: the result of bandpass filtering the input image by
%                 the bandreject filter constructed from lp1 and lp2
%            oum: the result of unsharp masking the input image using lp2
%            ohb: the result of highboost filtering the input image using
%                 lp2 and k=2.5
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 2021-11-25
%
% Gives a history of your submission to Lisam.
% Version and date for this function have to be updated before each
% submission to Lisam (in case you need more than one attempt)
%
%% General rules
%
% 1) Don't change the structure of the template by removing %% lines
%
% 2) Document what you are doing using comments
%
% 3) Before submitting make the code readable by using automatic indentation
%       ctrl-a / ctrl-i
%
% 4) Often you must do something else between the given commands in the
%       template
%
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%
%% Lowpass filtering
% Lowpass filter the input image by lp1. Use symmetric padding in order to
% avoid the dark borders around the filtered image.
% Perform the lowpass filtering here:
%

olp = imfilter(im, lp1, 'replicate', 'conv'); % The lowpass filtered image

%% Highpass filtering
% Construct a highpass filter kernel from lp1, call it hp1, here:

%Check dimensions of the filter
[m,m] = size(lp1);

impuls_matrix = zeros(m);
impuls_matrix((floor(m/2) + 1), (floor(m/2) + 1)) = 1;

hp1= impuls_matrix - lp1; % the highpass filter kernel

% Filter the input image by hp1, to find the result of highpass filtering
% the input image, here:

ohp = imfilter(im, hp1, 'replicate', 'conv'); % the highpass filtered image

%% Bandreject filtering
% Construct a bandreject filter kernel from lp1 and lp2, call it br1,
% IMPORTANT: lp2 has a lower cut-off frequency than lp1
% here:

%Find sizes
[s1, s1] = size(lp1);
[s2, s2] = size(lp2);
dif = s2-s1;

%Zeropadding to get correct matrix dimensions
new_filter_maxtrix = padarray(lp1, [dif/2, dif/2], 0, 'both');

%Create impulse matrix
impuls_matrix2 = zeros(s2);
impuls_matrix2((floor(s2/2) + 1), (floor(s2/2) + 1)) = 1;

br1 = new_filter_maxtrix + (impuls_matrix2 - lp2); % the bandreject filter kernel


% Filter the input image by br1, to find the result of bandreject filtering
% the input image, here:

obr = imfilter(im, br1,'replicate', 'conv'); % the bandreject filtered image

%% Bandpass filtering
% Construct a bandpass filter kernel from br1, call it bp1, here:

bp1 = impuls_matrix2 - br1; % the bandpass filter kernel

% Filter the input image by bp1, to find the result of bandpass filtering
% the input image, here:

obp = imfilter(im, bp1, 'replicate', 'conv'); % the bandpass filtered image


%% Unsharp masking
% Perform unsharp masking using lp2, here:

oum = im + ohp; % the resulting image after unsharp masking


%% Highboost filtering
% Perform highboost filtering using lp2 (use k=2.5), here:

k = 2.5;
ohb = im + k.*ohp; % the resulting image after highboost filtering


%% Test your code
% Test your code on different images using different lowpass filters as
% input arguments. Specially, it is interesting to test your code on the
% image called zonplate.tif. This image contains different frequencies and
% it is interesting to study how different filters pass some frequencies
% and block others. As the filter kernels, it is interesting to
% try different box and Gaussian filters.
%
