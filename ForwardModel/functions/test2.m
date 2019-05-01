clc
clear
close all

addpath(genpath('./'));
addpath(genpath('./../'));
addpath(genpath('./functions'));

x = linspace(-10, 10, 100);
z = linspace(-10, 10, 125);

[X, Z] = meshgrid(x, z);

w0 = 1;
lambda = 1;

psf = gaussian_PSF(X, Z, lambda, w0);

g1 = @(x0, z0, theta0) x0.*cos(theta0) + z0.*sin(theta0);
g2 = @(x0, z0, theta0) x0.*sin(theta0) - z0.*cos(theta0);



for theta = 1:360
    theta_rad = theta*pi/180;
    
end