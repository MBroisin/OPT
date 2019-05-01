clc
clear
close all

addpath(genpath('./'));
addpath(genpath('./../'));
addpath(genpath('./functions'));

file = load('artificial_image.mat');
image = file.image;
im = image(:,:,1);

[s1, s2] = size(im);
m1 = s1/2;
m2 = s2/2;

radius = ceil(sqrt(s1^2 + s2^2));
theta = 0;

g1 = @(x0, y0, theta0) x0.*cos(theta0) + y0.*sin(theta0);
g2 = @(x0, y0, theta0) x0.*sin(theta0) - y0.*cos(theta0);


if mod(radius, 2) == 0
    radius = radius+1;
end

midptIM = (radius+1)/2;

p0 = linspace(-midptIM+1, midptIM-1, radius);
q0 = linspace(-midptIM+1, midptIM-1, radius);

p1 = g1(p0, q0, theta);
q1 = g2(p0, q0, theta);

p2 = round(p1 + m1);
q2 = round(q1 + m2);

p3 = min(max(p2, 1), s1);
q3 = min(max(q2, 1), s2);

rotated_image = im(p3, q3);

figure()
subplot(1, 2, 1)
imshow(im)
subplot(1, 2, 2)
imshow(rotated_image)