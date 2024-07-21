% Load lighthouse image
load ('lighthouse.mat');
whos xx;

% Display the lighthouse image
figure;
show_img(xx, 0, 1);
colormap(gray(256));
title('Original Lighthouse Image');

% Extract the 200th row
xx200 = xx(200, :);

% Plot the 200th row
figure;
plot(xx200);
title('200th Row of the Lighthouse Image');
xlabel('Pixel Index');
ylabel('Gray Level');

% Generate a simple test image
xpix = ones(256, 1) * cos(2 * pi * (0:255) / 16);

% Display the synthetic image
figure;
show_img(xpix, 0, 1);
colormap(gray(256));
title('Synthetic Image with Cosine Pattern');

% Down-sample by a factor of 2
p = 2;
xp = xx(1:p:end, 1:p:end);

% Display the down-sampled image
figure;
show_img(xp, 0, 1);
colormap(gray(256));
title('Down-Sampled Lighthouse Image by Factor of 2');


% Down-sample by a factor of 3
p = 3;
xx3 = xx(1:p:end, 1:p:end);

% Display the down-sampled image
figure;
show_img(xx3, 0, 1);
colormap(gray(256));
title('Down-Sampled Lighthouse Image by Factor of 3');

% Zero-order hold interpolation
xr1 = (-2).^(0:6);
L = length(xr1);
nn = ceil((0.999:1:4*L)/4);
xr1hold = xr1(nn);

% Plot zero-order hold
figure;
stem(xr1hold);
title('Zero-Order Hold Interpolation');
xlabel('Sample Index');
ylabel('Amplitude');


% /////////////////////////////////////////////////////////////////////

% Perform zero-order hold interpolation on rows
tti = 1:size(xx3, 1);
ttinew = linspace(1, size(xx3, 1), size(xx3, 1) * p);
xholdrows = interp1(tti, xx3, ttinew, 'nearest');


% Display the result
figure;
show_img(xholdrows, 0, 1);
colormap(gray(256));
title('Zero-Order Hold Interpolated Rows');

% Perform zero-order hold interpolation on columns
tti = 1:size(xholdrows, 2);
ttinew = linspace(1, size(xholdrows, 2), size(xholdrows, 2) * 3);
xhold = interp1(tti, xholdrows', ttinew, 'nearest')';

% Display the result
figure;
show_img(xhold, 0, 1);
colormap(gray(256));
title('Zero-Order Hold Interpolated Columns');

% Linear interpolation on rows
[rows, cols] = size(xx3);
tti = 1:1/3:cols; % Interpolation points
xxlinear_rows = zeros(rows, length(tti));

for r = 1:rows
    xxlinear_rows(r, :) = interp1(1:cols, xx3(r, :), tti, 'linear');
end

% Linear interpolation on columns
tti = 1:1/3:rows; % Interpolation points
xxlinear = zeros(length(tti), size(xxlinear_rows, 2));

for c = 1:size(xxlinear_rows, 2)
    xxlinear(:, c) = interp1(1:rows, xxlinear_rows(:, c), tti, 'linear');
end

% Display the result
figure;
show_img(xxlinear, 0, 1);
colormap(gray(256));
title('Linear Interpolated Image');
