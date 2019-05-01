clc
clear 
close all

im = imread('/Users/Matthieu/Documents/OPT2019/lena.jpg');

im = im(:, :, 1);

figure()
imshow(im)

