clear all
close all

%% Simulate 1-D blur and noise
image_original = im2double(imread('Cameraman256.bmp', 'bmp'));
[H, W] = size(image_original);
blur_impulse = fspecial('motion', 7, 0);
image_blurred = imfilter(image_original, blur_impulse, 'conv', 'circular');
noise_power = 1e-4;
randn('seed', 1);
noise = sqrt(noise_power) * randn(H, W);
image_noisy = image_blurred + noise;

figure; imshow(image_original, 'border', 'tight');
figure; imshow(image_blurred, 'border', 'tight');
figure; imshow(image_noisy, 'border', 'tight');

%% CLS restoration
alpha = 0.1; 
image_cls_restored = cls_restoration(image_noisy, blur_impulse, alpha);
figure; imshow(image_cls_restored, 'border', 'tight');

%% computation of ISNR
e1=image_original-image_noisy;
e2=image_original-image_cls_restored;
E1=mean2(e1.*e1);
E2=mean2(e2.*e2);
result=10*log(E1/E2)/log(10)