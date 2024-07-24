% Echo filter
% Load the speech signal
load('labdat.mat');  % Assume x2 is in labdat.mat

% Define the echo filter parameter
fs = 8000;  % Sampling frequency in Hz
delay = 0.2;  % Echo delay in seconds
r = 0.9;  % Echo strength
P = round(fs * delay);  % Echo delay in samples
fprintf('r: %f, P: %d\n', r, P);

% Define the echo filter coefficients
b_echo = [1 zeros(1, P-1) r];

% Apply the echo filter
y_echo = firfilt(b_echo, x2);

% Play the original and echoed signals
sound(x2, fs);
pause(length(x2)/fs + 1);
sound(y_echo, fs);
