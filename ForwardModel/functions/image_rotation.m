function [rot_im] = image_rotation(im, angle, pos_rotation_axis)

% pos_rotation_axis should be multiples of 0.5

if isempty(pos_rotation_axis)
    pos_rotation_axis = [(size(im, 1)+1)/2, (size(im, 2)+1)/2];
else
    if (pos_rotation_axis(1)>size(im, 1)+0.5 || pos_rotation_axis(2)>size(im, 2)+0.5 || pos_rotation_axis(1)<0.5 || pos_rotation_axis(2)<0.5)
        disp('Error : For each axis, the center of rotation must live in [0.5; size(axis)+0.5]');
        rot_im = 0;
        return
    end
    
end

[sz1, sz2] = size(im);
c11 = [0.5; 0.5];
c12 = [0.5; sz2+1.5];
c21 = [sz1+1.5; 0.5];
c22 = [sz1+1.5; sz2+1.5];

corners = [c11, c12, c21, c22];

P = [pos_rotation_axis(1); pos_rotation_axis(2)];

dist = @(p, c) (p(1)-c(1))^2 + (p(2)-c(2))^2;

d11 = dist(P, c11);
d12 = dist(P, c12);
d21 = dist(P, c21);
d22 = dist(P, c22);

dists = [d11, d12, d21, d22];

[~, argmax] = max(dists);

farthest_corner = corners(:,argmax);
% disp(farthest_corner);

side_dists = abs(farthest_corner-P);
pads = 2*side_dists - [sz1; sz2];

switch argmax
    case 1
        im = padarray(im, pads(1), 0, 'post');
        im = padarray(im', pads(2), 0, 'post')';
    case 2
        im = padarray(im, pads(1), 0, 'post');
        im = padarray(im', pads(2), 0, 'pre')';
    case 3
        im = padarray(im, pads(1), 0, 'pre');
        im = padarray(im', pads(2), 0, 'post')';
    case 4
        im = padarray(im, pads(1), 0, 'pre');
        im = padarray(im', pads(2), 0, 'pre')';
end


[s1, s2] = size(im);


radius = ceil(sqrt(s1^2 + s2^2));
if mod(radius, 2) == 0
    radius = radius+1;
end

current = im;
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

rot_im = imrotate(current, angle, 'bilinear', 'crop');
