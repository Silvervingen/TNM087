function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )
%function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )

%   Implement gamma correction:
%   Truncate the original gray values using lower and upper quantiles
%   (Lower, Upper) and then apply gamma correction with exponent Gamma
%   to the input image OImage,
%   the result is the double image GImage with maximum gray value one
%
%% Who has done it
%
% Authors: Ivar Gorenko (ivago071) Antonio Ilestad (Antta839)
%
%% Syntax of the function
%
%   Input arguments:
%       OImage: Grayscale image of type uint8 or double
%       Gamma: exponent used in the gamma correction,
%       Lower: value in the range 0, 1
%       Upper: value in the range 0, 1 and lower < upper
%       Lower and Upper are quantile values.
%   Output argument: GImage: gamma corrected gray value image of type double
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 2021-11-10
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
%% Image class handling
% Make sure that you can handle input images of class uint8, uint16 and double
TImage = im2double(OImage); % convert the input image to double, call it TImage

%% Compute lower and upper gray value boundaries.
% Use the parameteers Lower and Upper to find the corresponding gray values
% for the boundaries
% Look at the help function for the command quantile
%
lowgv = quantile(TImage(:), Lower); % Lower-bound gray value of TImage
uppgv = quantile(TImage(:), Upper); % Upper-bound gray value of TImage

%% Compute a scaled version GImage of the image, where:
% the lower-bound gray value is zero
% the upper-bound gray value is one
% because 0^Gamma = 0 and 1^Gamma = 1
%

TImage = (TImage - lowgv)/(uppgv - lowgv); % contrast stretching

%% Gamma mapping of the previous result
% Make sure that your image is in the range [0,1] before applying gamma
% correction!
%
TImage = min(1,max(0,TImage)); % To limit the range between 0 and 1
% use the formula s = cr^gamma, assume c is 1
GImage = TImage.^Gamma; % apply gamma correction (which is an elementwise operation)


end

%% Experiments with your code
%
% Use your code to modify the images 'aerialview-washedout.tif' and
% 'spillway-dark.tif' for different values for Gamma, Lower and Upper
% Write some comments on your experiments and propose some good parameters
% to use (don't forget to comment your text so that the code will work)
%
% 'spillway-dark.tif':
% Lower 0.0, Upper 1.0, Gamma = 0.8
%
%
%
% 'aerialview-washedout.tif'
% Lower 0.01, Upper 0.99, Gamma = 2
%
%
%
% The image ?IntensityRampGamma25.tif? illustrates the effect of an intensity
% ramp displayed on a monitor with gamma =2.5.
% Which value for gamma should you use in your code to correct the image to appear as a linear intensity ramp?
% (Set Lower=0 and Upper=1)
% Gamma = 0.4 because 1/2.5 = 0.4




