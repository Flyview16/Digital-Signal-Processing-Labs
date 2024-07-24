% Define the input signal
xx = 256 * (rem(0:100, 50) < 10);

% Define the filter coefficients
bb = [1 -0.9];

% Apply the FIR filter using firfilt
ww = firfilt(bb, xx);

% Determine the lengths of the signals
len_xx = length(xx);
len_ww = length(ww);

% Plot the input and output waveforms
n_xx = 0:len_xx-1;
n_ww = 0:len_ww-1;
figure;
subplot(2,1,1);
stem(n_xx, xx, 'filled');
title('Input Signal x[n]');
xlabel('n');
ylabel('x[n]');
xlim([0 75]);

subplot(2,1,2);
stem(n_ww, ww, 'filled');
title('Output Signal w[n]');
xlabel('n');
ylabel('w[n]');
xlim([0 75]);

% Display lengths
fprintf('Length of x[n]: %d\n', len_xx);
fprintf('Length of w[n]: %d\n', len_ww);


% Define the restoration filter coefficients
M = 22;
r = 0.9;
b2 = r .^ (0:M);

% Apply the restoration filter using firfilt
yy = firfilt(b2, ww);

len_xx = length(xx);
len_yy = length(yy);
min_len = min(len_xx, len_yy);

% Plot w[n] and y[n]
n_ww = 0:length(ww)-1;
n_yy = 0:length(yy)-1;
figure;
subplot(2,1,1);
stem(n_ww, ww, 'filled');
title('Filtered Signal w[n]');
xlabel('n');
ylabel('w[n]');
xlim([0 75]);

subplot(2,1,2);
stem(n_yy, yy, 'filled');
title('Restored Signal y[n]');
xlabel('n');
ylabel('y[n]');
xlim([0 75]);

% Calculate the error
error = xx(1:min_len) - yy(1:min_len); % Match lengths for comparison

% Plot the error
figure;
stem(0:49, error(1:50), 'filled');
title('Error between x[n] and y[n]');
xlabel('n');
ylabel('Error');

% Evaluate the worst-case error
max_error = max(abs(error(1:50)));
fprintf('Worst-case error: %f\n', max_error);
