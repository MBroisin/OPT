clc
clear
close all

addpath(genpath('/Users/Matthieu/Documents/OPT2019/code/Matlab/Projection2D'));
addpath(genpath('/Users/Matthieu/Documents/OPT2019/code/Matlab/Projection2D/ForwardModel'));
addpath(genpath('./functions'));

cd('/Users/Matthieu/Documents/OPT2019/code/Matlab/Projection2D/ForwardModel/');

im256 = mean(imread('./../../../../lena.jpg'), 3);
im = im256-min(im256, [], 'all');
im = im/max(im, [], 'all');

DS_ratio = 10;
im = downsample(im, DS_ratio);
im = downsample(im', DS_ratio)';

x0 = 20;
y0 = 20;

%% 
rotated_image1 = image_rotation(im, 45, [x0, y0]);

x1 = reshape(im, [size(im, 1)*size(im, 2), 1]);
y1 = reshape(rotated_image1, [size(rotated_image1, 1)*size(rotated_image1, 2), 1]);

x_prime1 = x1' / (x1'*x1);
A = y1*x_prime1;

A = A-min(A, [], 'all');
A = A/max(A, [], 'all');

%%
% rotated_image2 = image_rotation(im, 180-45, [x0, y0]);
% 
% x2 = reshape(im, [size(im, 1)*size(im, 2), 1]);
% y2 = reshape(rotated_image2, [size(rotated_image2, 1)*size(rotated_image2, 2), 1]);
% 
% x_prime2 = x2' / (x2'*x2);
% B = y2*x_prime2;
% 
% B = B-min(B, [], 'all');
% B = B/max(B, [], 'all');

%%
A_t = A';

x_new = A_t*y1;

x_new = reshape(x_new, [size(im, 1), size(im, 2)]);


%%
close all

% figure()
% imshow(A)

figure()
subplot(1, 3, 1)
imshow(im)

subplot(1, 3, 2)
imshow(rotated_image1)

tim = max(x_new, 100*ones(size(x_new)));
tim = tim - min(tim, [], 'all');
tim = tim/max(tim, [], 'all');

subplot(1, 3, 3)
imshow(tim);

