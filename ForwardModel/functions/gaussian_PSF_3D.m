function [psf] = gaussian_PSF_3D(x, y, z, lambda, w0)

zr = pi/lambda*(w0^2);
    
normalization_term = 1 ./ sqrt(1 + (y./zr).^2);
    
exponential_term = - (x.^2 + z.^2) ./ (w0^2) ./ (1 + (y./zr).^2);

psf = normalization_term.*exp(exponential_term);

psf = abs(psf).^2;