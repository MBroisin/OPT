function [proj] = compute_slice_projection(slice, s, theta, lambda, w0)

[sizex, sizez] = size(slice);

x = linspace(1, sizex, sizex);
x = x - round(sizex/2);
z = linspace(1, sizez, sizez);
z = z - round(sizez/2);

[X, Z] = meshgrid(z, x);

g1 = @(x0, z0, theta0) x0.*cos(theta0) + z0.*sin(theta0);
g2 = @(x0, z0, theta0) x0.*sin(theta0) - z0.*cos(theta0);

psf = gaussian_PSF(g1(X, Z, theta)-s, g2(X, Z, theta), lambda, w0);

proj = sum(psf.*slice, 'all');
