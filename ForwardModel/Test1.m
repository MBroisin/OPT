clc
clear
close all

addpath(genpath('./'));
addpath(genpath('./../'));
addpath(genpath('./functions'));

x = linspace(-10, 10, 100);
z = linspace(-10, 10, 100);

[X, Z] = meshgrid(x, z);
%%
w0 = 1;
lambda = 1;

psf = gaussian_PSF(X, Z, lambda, w0);

% figure()
% surf(X, Z, psf)
% xlabel('X')
% ylabel('Z')
% zlabel('PSF')
% title('GAUSSIAN PSF')

im = load('artificial_image.mat');
im = im.image;

[sz1, sz2, sz3] = size(im);

proj = zeros(129, 91, sz3);

for h = 1:sz3
    i = 1;
    for s = -64:64
        j = 1;
        for theta = 0:1:360
            proj(i, j, h) = compute_slice_projection(im(:,:,h), s, theta*pi/180, 1, 1);
            j = j+1;
        end
        i=i+1;
    end
end

proj = (proj - min(proj, [], 'all'))/max(proj, [], 'all');
%% 

% figure()
% imshow(proj)

%% 
image = proj;
save('./../proj.mat', 'image');


