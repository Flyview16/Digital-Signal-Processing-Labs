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
fac = 2;
xp = xx(1:fac:end, 1:fac:end);

% Display the down-sampled image
figure;
show_img(xp, 0, 1);
colormap(gray(256));
title('Down-Sampled Lighthouse Image by Factor of 2');


% Down-sample by a factor of 3
fac = 3;
xx3 = xx(1:fac:end, 1:fac:end);

% Display the down-sampled image
figure;
show_img(xx3, 0, 1);
colormap(gray(256));
title('Down-Sampled Lighthouse Image by Factor of 3');

% Zero-order hold on rows
xholdrows = xx3(ceil((0.999:1:(size(xx3,1)*3))/3), :);

% Zero-order hold on columns
xhold = xholdrows(:, ceil((0.999:1:(size(xholdrows,2)*3))/3));

% Display the zero-order hold reconstructed image
figure;
show_img(xhold, 0, 1);
colormap(gray(256));
title('Zero-Order Hold Reconstructed Image');

% Linear interpolation on rows
tti = 1:size(xx3, 1);
ttinew = linspace(1, size(xx3, 1), size(xx3, 1) * fac);
xx3interp = interp1(tti, xx3, ttinew, 'linear');

% Linear interpolation on columns
tti = 1:size(xx3interp, 2);
ttinew = linspace(1, size(xx3interp, 2), size(xx3interp, 2) * fac);
xxlinear = interp1(tti, xx3interp', ttinew, 'linear')';

% Display the linearly interpolated image
figure;
show_img(xxlinear, 0, 1);
colormap(gray(256));
title('Linearly Interpolated Image');


% ///////////////////////////////////////////////////////////////////////
% Interpolate rows with zero-order hold
xholdrows = repelem(xx3, 1, 3);

% Display the result
figure;
show_img(xx3, 0, 1);
title('Row Interpolated Image (Zero-Order Hold)');

% Interpolate columns with zero-order hold
xhold = repelem(xholdrows, 3, 1);

% Display the result
figure;
show_img(xhold, 0, 1);
title('Full Interpolated Image (Zero-Order Hold)');


% Linear interpolation
n1 = 0:6;
xr1 = (-2).^n1;
tti = 0:0.1:6;
xr1linear = interp1(n1, xr1, tti);

% Plot linear interpolation
figure;
stem(tti, xr1linear);
title('Linear Interpolation');
xlabel('Sample Index');
ylabel('Amplitude');


% Linear interpolation of rows and columns
[row, col] = size(xx3);
xxlinear = interp1(1:col, double(xx3).', 1:1/3:col, 'linear').';
xxlinear = interp1(1:row, double(xxlinear), 1:1/3:row, 'linear');

% Display the result
figure;
show_img(xxlinear, 0, 1);
title('Full Interpolated Image (Linear)');
