clc
clear
close all

szx = 128;
szy = 128;
szz = 128;

mx = szx/2;
my = szy/2;
mz = szz/2;

radius = 32;
bead_radius = 4;

im = zeros(szx, szy, szz);

% im(mx, my, mz) = 1;

n = 8;

for h = 1:szz
    for i = 1:szx
        for j = 1:szy
            for ii = 1:n
                iii = ii/n;
                for jj = 1:n
                    jjj = jj/n;
                    
                    if((i+iii-mx)^2 + (j+jjj-my)^2 < radius^2)
                        im(i, j, h) = im(i, j, h) + 0.1/n/n;
                    end
                end
            end
        end
    end
end

beads = round(2*radius*rand(2,12) - radius*ones(2,12));
beads_height = round((szz-2*(bead_radius+1))*rand(1,12))+bead_radius+1;
beads = cat(1, beads, beads_height);

for b = 1:size(beads, 2)
    bead = beads(:, b);
    if (bead(1)^2 + bead(2)^2 < (radius-bead_radius)^2)
        val = 0.9*rand(1,1);
        for i = -bead_radius:bead_radius
            for j = -bead_radius:bead_radius
                for h = -bead_radius:bead_radius
                    for ii = 1:n
                        iii = ii/n;
                        for jj = 1:n
                            jjj = jj/n;
                            for hh = 1:n
                                hhh = hh/n;
                                if((i+iii)^2 + (j+jjj)^2 + (h+hhh)^2 < bead_radius^2)
                                    im(i+bead(1)+mx, j+bead(2)+my, h+bead(3)) = im(i+bead(1)+mx, j+bead(2)+my, h+bead(3)) + val/n/n/n;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
    
% im(mx+bead(1), my+bead(2), h) = 0.1 + 0.9*rand(1,1);
im = min(im, ones(size(im)));
image = im;
save('artificial_image_modified.mat', 'image');
%%
% figure(1)
% imshow(im(:,:,1));

