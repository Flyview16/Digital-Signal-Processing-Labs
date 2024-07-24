% Define the filter coefficients
q = 0.9;
r = 0.9;
M = 22;
b1 = [1 -q];
b2 = r .^ (0:M);

% Get the impulse response of the cascaded system
impulse = [1 zeros(1, 100)];
h1 = firfilt(b1, impulse);
h2 = firfilt(b2, h1);

% Plot the impulse response
figure;
stem(0:length(h2)-1, h2, 'filled');
title('Impulse Response of the Cascaded System');
xlabel('n');
ylabel('h[n]');
