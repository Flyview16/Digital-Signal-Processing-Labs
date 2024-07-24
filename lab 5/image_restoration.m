% Load the image
load('echart.mat');  % Assume echart is in echart.mat

% Define the first filter coefficients
q = 0.9;
b1 = [1 -q];

% Apply the first filter horizontally
echart_horiz = firfilt(b1, echart')';
ech90 = firfilt(b1, echart_horiz);

% Truncate the filtered image to match the original dimensions
ech90 = ech90(1:size(echart, 1), 1:size(echart, 2));

% Define the restoration filter parameters
r = 0.9;
M = 22;
b2 = r .^ (0:M);

% Apply the restoration filter
echart_restored = firfilt(b2, ech90')';

% Truncate the restored image to match the original dimensions
echart_restored = echart_restored(1:size(echart, 1), 1:size(echart, 2));

% Display the images
figure;
subplot(1,3,1);
imshow(echart, []);
title('Original Image');

subplot(1,3,2);
imshow(ech90, []);
title('Distorted Image');

subplot(1,3,3);
imshow(echart_restored, []);
title('Restored Image');

% Calculate the error image
error_img = echart - echart_restored;
max_error_img = max(abs(error_img(:)));
fprintf('Worst-case error with M = %d: %f\n', M, max_error_img);

% Second Restoration
% Evaluate different values of M for restoration filter
Ms = [11, 22, 33];

figure;
for i = 1:length(Ms)
    M = Ms(i);
    b2 = r .^ (0:M);
    echart_restored = firfilt(b2, ech90')';
    
    % Truncate the restored image to match the original dimensions
    echart_restored = echart_restored(1:size(echart, 1), 1:size(echart, 2));
    
    subplot(1, length(Ms), i);
    imshow(echart_restored, []);
    title(['Restored with M = ', num2str(M)]);
end

% Calculate and display worst-case error for each filter
for M = Ms
    b2 = r .^ (0:M);
    echart_restored = firfilt(b2, ech90')';
    
    % Truncate the restored image to match the original dimensions
    echart_restored = echart_restored(1:size(echart, 1), 1:size(echart, 2));
    
    error_img = echart - echart_restored;
    max_error_img = max(abs(error_img(:)));
    fprintf('Worst-case error with M = %d: %f\n', M, max_error_img);
end
