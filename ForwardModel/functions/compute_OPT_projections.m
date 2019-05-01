function [proj] = compute_OPT_projections(im, angles, lambda, w0, pixel_size)

[s1, s2, s3] = size(im);
m1 = s1/2;
m2 = s2/2;
m3 = s3/2;

radius = ceil(sqrt(s1^2 + s2^2));
if mod(radius, 2) == 0
    radius = radius+1;
end
midptIM = (radius+1)/2;


x = linspace(-pixel_size*radius, pixel_size*radius, 2*radius+1);
y = linspace(-pixel_size*radius, pixel_size*radius, 2*radius+1);
z = linspace(-pixel_size*s3/2, pixel_size*s3/2, 2*s3);


[X, Y, Z] = meshgrid(y, x, z);

psf = gaussian_PSF_3D(Y, X, Z, lambda, w0);

% image = psf;
% save('./PSF.mat', 'image');

[~, nb_angles] = size(angles);

g1 = @(x0, y0, theta0) x0.*cos(theta0) + y0.*sin(theta0);
g2 = @(x0, y0, theta0) x0.*sin(theta0) - y0.*cos(theta0);

proj = [];

midptPSF = (size(psf, 2)+1)/2;
shift = midptPSF-midptIM;

        
for i = 1:nb_angles
    clc
    disp(['Angle ' num2str(i) '/' num2str(nb_angles) '.'])
    theta = angles(i);
    
%     p0 = linspace(1, s1, s1);
%     q0 = linspace(1, s2, s2);
%     
%     [P, Q] = meshgrid(q0, p0);
%     
%     p = g1(P, Q, theta);
%     q = g2(P, Q, theta);
%     
%     p = round(p + m1);
%     q = round(q + m2);
%     
%     p = min(max(p, 1), s1);
%     q = min(max(q, 1), s2);



    % TO BE REPLACED BY IMROTATE : PAD THE IMAGE TO MAKE IT (radius,
    % radius), THEN ROTATE WITH OPTION CROP TO KEEP THE SAME IMAGE SIZE,
    % FOR EACH DIFFERENT HEIGHT (maybe use of the option 'bilinear' as well)
    
%     p0 = linspace(-midptIM+1, midptIM-1, radius);
%     q0 = linspace(-midptIM+1, midptIM-1, radius);
%     
%     [P0, Q0] = meshgrid(q0, p0);
%     
%     p1 = g1(P0, Q0, theta);
%     q1 = g2(P0, Q0, theta);
% 
%     p2 = round(p1 + m1);
%     q2 = round(q1 + m2);
% 
%     p3 = min(max(p2, 1), s1);
%     q3 = min(max(q2, 1), s2);
%     
%     rotated_image = zeros(radius, radius, s3);
%     for ii = 1:radius
%         for jj = 1:radius
%             for h = 1:s3
%                 rotated_image(ii,jj,h) = im(p3(ii,jj), q3(ii,jj), h);
%             end
%         end
%     end
% %     rotated_image = im(p3, q3, :);

    rotated_image = zeros(radius, radius, s3);
    for h = 1:s3
        current = im(:, :, h);
        rows = radius - size(im, 1);
        cols = radius - size(im, 2);
        mr = 0;
        mr1 = 0;
        mc = 0;
        mc1 = 0;
        resize_needed = 0;
        if (mod(rows, 2) == 0)
            mr = rows/2;
        else
            mr = (rows-1)/2;
            resize_needed = 1;
        end
        
        if (mod(cols, 2) == 0)
            mc = cols/2;
        else
            mc = (cols-1)/2;
            resize_needed = 1;
        end
        
        current = padarray(current, mr, 0, 'pre');
        current = padarray(current, mr, 0, 'post');
        current = padarray(current', mc, 0, 'pre');
        current = padarray(current, mc, 0, 'post')';
        
        if resize_needed == 1
            current = imresize(current, [radius radius]);
        end
        
        rotated_image(:, :, h) = imrotate(current, theta*180/pi, 'crop');
        
    end
    

%     image = rotated_image;
%     name = ['rotated_image'  num2str(theta)  '.mat'];
%     save(name, 'image');
    
    proj2D = zeros(size(rotated_image, 1) + size(psf, 1) - 1, size(rotated_image, 3) + size(psf, 3) - 1);

%     figure()
    for j = 1:radius
        proj2D = proj2D + conv2(squeeze(rotated_image(:,j,:)), squeeze(psf(:,j+shift,:)));
        
%         subplot(1, 2, 1)
        %temp = conv2(squeeze(rotated_image(:,j,:)), squeeze(psf(:,j+shift,:)));
        %imshow(temp)
%         subplot(1, 2, 2)
%         imshow(squeeze(psf(:,j+shift,:)))
    end
    proj = cat(3, proj, proj2D);
end

