clc
clear
close all

x = linspace(-10, 10, 100);
y = linspace(-10, 10, 150);
z = linspace(-10, 10, 50);


[X, Y, Z] = meshgrid(y, x, z);

psf = gaussian_PSF_3D(Y, X, Z, 1, 1);

size(psf)
 
axis = 1;

image = psf;
save('testPSF.mat', 'image');