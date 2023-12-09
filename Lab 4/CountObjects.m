function [IMG, noRice, noSmallMacs, noLargeMacs]=CountObjects(in)
%% Lab4, Task 3
%% Finds the number of rows of bricks
%
% Counts objects of different class and displays them in different colors. 
% Input images containing three classes of ojects: grains of rice, snall
% macaronis and large macaronis
%
%% Who has done it
%
% Author: Antta839
% Co-author: Ivago071
%
%% Syntax of the function
%      Input arguments:
%           in: the original input RGB color image of type double scaled between 0 and 1
%          
%      Output arguments:
%           IMG: the output RGB color image, displaying the three
%           diffferent classes of objects in different colors
%           noRice: Number of grains of rice in the input image
%           noSmallMacs: Number of small macaromis in the input image
%           noLargeMacs: Number of large macaromis in the input image
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 2021-12-09
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

%% Make the input color image grayscale, 
% by choosing its most appropriate channel 

bgray = in(:,:,3); % The grayscale version of the input color image
    
%% Threshold your image
% to separate the objects from the backgroound

thresh = graythresh(bgray);
b_thresh=imbinarize(bgray,thresh); % The thresholded image
    
%% Clean up the binary image 
% Use morphological operations to clean up the binary image from noise. 
% Especially make syre that your cleaned image don't contain any false object
% (i.e. single foreground pixels, or groups of connected foreground pixels, 
% that do not belong to the object classes  

SE =strel('disk',4);
IM1 = imclose(b_thresh, SE);
IM2 = imopen(IM1, SE);
IM2 = (IM2 == 0);

b_clean=IM2; % Cleaned up binary image
imshow(b_clean)

%% Labelling
%  Use labelling to assign every object a unique number

L = bwlabel(b_clean); % Labelled image
    
%% Object features
% Compute relevant object features that you can use to classify 
% the three classes of objects

Stats = regionprops(L, 'Area'); % Create struct with relevant object properties
for n=1:length(Stats)
    Area(n)=Stats(n).Area;
end

%% Object classification
% Based on your object features, classify the objects, i.e. for each
% labelled object: decide if it belongs to the three classes: Rice, SmallMacs, or LargeMacs 
% In case you didn't suceed in cleaining up all false objects, you should
% discard them here, so they don't count as the classes of objects

Rice = find(Area < 2000); % Vector containing the labels of all objects classifies as rice
SmallMacs = find(Area < 8000 & Area > 2000); % Vector containing the labels of all objects classifies as SmallMacs
LargeMacs = find(Area > 8000);% Vector containing the labels of all objects classifies as LargeMacs

%% Count the objects for each class.

noRice = length(Rice); % Number of rices
noSmallMacs = length(SmallMacs); % Number of small macoronis
noLargeMacs = length(LargeMacs);% Number of large macoronis

disp(noRice)
disp(noSmallMacs)
disp(noLargeMacs)

%% Create an RGB-image, IMG, displaying the different classes of objects in different colors
% Use for example: Colored objects on black background, colored objects on
% the original background, highlight the borders of the objects in the
% original image in different colors (or some other way of displayig the
% objects)
[r, c] = size(L);

Riceim = zeros(r, c);
for n=1:length(Rice)
    Riceim(L==Rice(n))= 1;
end

smallMacin = zeros(r,c);
for n=1:length(SmallMacs)
   smallMacin( L == SmallMacs(n))= 1; 
end

bigMacin = zeros(r,c);
for n=1:length(LargeMacs)
   bigMacin( L == LargeMacs(n))= 1; 
end

IMG = zeros (r,c,3);  % Output RGB-image displaying the three classes of objects in different colors  % Output RGB-image displaying the three classes of objects in different colors
IMG = cat(3,Riceim,smallMacin,bigMacin);

%% Test your code on the three test images
% % Your code is supposed to work for the three images:
%
% Image          noRice   noSmallMacs   noLargeMacs
% MacnRice1.tif  48       12            6
% MacnRice2.tif  60       14            6
% MacnRice3.tif  42       11            5



