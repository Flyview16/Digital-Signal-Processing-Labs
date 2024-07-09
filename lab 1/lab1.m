% Part (a) - Generate time vector (tt)
f = 4000; % Frequency in Hz
T = 1/f; % Period of the sinusoid
samples_per_period = 25; % At least 25 samples per period
dt = T / samples_per_period; % Time increment
tt = -T:dt:T; % Time vector covering two periods

% Part (b) - Generate two 4000 Hz sinusoids
age = 23; % Example age
A1 = age; % Amplitude 1
A2 = 1.2 * A1; % Amplitude 2
D = 7; % Day of birth
M = 7; % Month of birth

tm1 = (37.2/M) * T; % Time-shift 1
tm2 = -(41.3/D) * T; % Time-shift 2

x1 = A1 * cos(2 * pi * f * (tt - tm1)); % First sinusoid
x2 = A2 * cos(2 * pi * f * (tt - tm2)); % Second sinusoid

% Part (c) - Create the third sinusoid as the sum
x3 = x1 + x2; % Sum of the two sinusoids

% Part (d) - Plot the results
figure;
subplot(3, 1, 1);
plot(tt, x1);
title('First Sinusoid x1(t)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 2);
plot(tt, x2);
title('Second Sinusoid x2(t)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 3);
plot(tt, x3);
title('Sum of Sinusoids x3(t) = x1(t) + x2(t)');
xlabel('Time (s)');
ylabel('Amplitude');

sgtitle('Degadzor Herbert Sitsofe');