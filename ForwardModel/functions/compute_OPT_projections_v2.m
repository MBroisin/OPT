function [proj] = compute_OPT_projections_v2(im, angles, lambda, w0, pixel_size, pos_rotation_axis)

if isempty(pos_rotation_axis)
    pos_rotation_axis = [size(im, 1)/2, size(im, 2)/2];
else
    if (pos_rotation_axis(1)>size(im, 1)+0.5 || pos_rotation_axis(2)>size(im, 2)+0.5 || pos_rotation_axis(1)<0.5 || pos_rotation_axis(2)<0.5)
        disp('For each axis, the center of rotation must live in [0.5; size(axis)+0.5]');
        return
    end
    
end

[s1, s2, s3] = size(im);

[~, nb_angles] = size(angles);


rotated_image = [];
for i = 1:nb_angles
    clc
    disp(['Rotation : Angle ' num2str(i) '/' num2str(nb_angles) '.'])
    theta = angles(i);
    

    rotated_image_theta = [];
    for h = 1:s3
        rot_im = image_rotation(im(:, :, h), theta, pos_rotation_axis);
        rotated_image_theta = cat(3, rotated_image_theta, rot_im);
    end
%     image = rotated_image_theta;
%     save('roat.mat', 'image');
    rotated_image = cat(4, rotated_image, rotated_image_theta); % modifier ça pour pas avoir un tableau trop grand
end


radius = size(rotated_image, 1);


x = linspace(-pixel_size*radius, pixel_size*radius, 2*radius+1);
y = linspace(-pixel_size*radius, pixel_size*radius, 2*radius+1);
z = linspace(-pixel_size*s3/2, pixel_size*s3/2, 2*s3);


[X, Y, Z] = meshgrid(y, x, z);

psf = gaussian_PSF_3D(Y, X, Z, lambda, w0);

% image = psf;
% save('./PSF.mat', 'image');


proj = [];

midptIM = (radius+1)/2;
midptPSF = (size(psf, 2)+1)/2;
shift = midptPSF-midptIM;
    

for i = 1:nb_angles
    clc
    disp(['Convolution : Angle ' num2str(i) '/' num2str(nb_angles) '.'])
    rotated_image_theta = rotated_image(:, :, :, i);
    proj2D = zeros(size(rotated_image_theta, 1) + size(psf, 1) - 1, size(rotated_image_theta, 3) + size(psf, 3) - 1);

    for j = 1:radius
        proj2D = proj2D + conv2(squeeze(rotated_image_theta(:,j,:)), squeeze(psf(:,j+shift,:)));
    end
    proj = cat(3, proj, proj2D);
end

