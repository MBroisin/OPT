clc
clear
close all

addpath(genpath('/Users/Matthieu/Documents/OPT2019/code/Matlab/Projection2D'));
addpath(genpath('/Users/Matthieu/Documents/OPT2019/code/Matlab/Projection2D/ForwardModel'));
addpath(genpath('./functions'));

file = load('artificial_image_modified.mat');
image = file.image;

angles = linspace(1, 360, 360)*pi/180;

tic;
proj = compute_OPT_projections(image, angles, (125*1e-6)*2*0.027, 6*1e-6, 5/300*(1e-3));
% proj = compute_OPT_projections(image, angles, 1, 1, 1);

timeElapsed = toc;
% disp(['Elapsed time : ' num2str(timeElapsed) ' s']);

%%

image = proj;
save('proj3D_modified.mat', 'image');

%% 

if timeElapsed > 60
    if timeElapsed > 3600
        h = floor(timeElapsed/3600);
        m = (timeElapsed - 3600*h)/60;
        s = timeElapsed - m*60;
        
        disp(['Elapsed time : ' num2str(h) ' h, ' num2str(m) ' m, ' num2str(s) ' s']);
    else
        m = floor(timeElapsed/60);
        s = timeElapsed - m*60;
        disp(['Elapsed time : ' num2str(m) ' m, ' num2str(s) ' s']);
    end
end
