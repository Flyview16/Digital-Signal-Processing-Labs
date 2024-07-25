% Coefficients for the nulling filters
b1 = [1, -2*cos(0.44*pi), 1];
b2 = [1, -2*cos(0.7*pi), 1];

% Generate the input signal x[n]
n = 0:149;
x = 5*cos(0.3*pi*n) + 22*cos(0.44*pi*n - pi/3) + 22*cos(0.7*pi*n - pi/4);

% Apply the first filter
y1 = firfilt(b1, x);

% Apply the second filter
y2 = firfilt(b2, y1);

% Plot the output signal (first 40 points)
figure;
plot(n(1:40), y2(1:40));
title('Output Signal (First 40 Points)');
xlabel('n');
ylabel('y[n]');

% Plotting mathematical formula
y_exact = 5 * cos(0.3*pi*n);

figure;
plot(n(5:40), y2(5:40), 'b', n(5:40), y_exact(5:40), 'r--');
legend('Filtered Output', 'Exact Formula');
title('Filtered Output vs Exact Formula');
xlabel('n');
ylabel('Amplitude');


% Generate the bandpass filter
L = 10;
h = cos(0.44 * pi * (0:L-1));

% Frequency response
[H, w] = freqz(h, 1, 1024);

% Plot frequency response
figure;
plot(w/pi, abs(H));
title('Frequency Response of Bandpass Filter (L=10)');
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('|H(e^{j\omega})|');

% Determine passband width
passband = find(abs(H) >= 0.707 * max(abs(H)));
passband_width = (w(passband(end)) - w(passband(1))) / pi;

% Display passband width
disp(['Passband width: ', num2str(passband_width)]);

% Generate a longer bandpass filter
% Increase L till desired attenuation is achieved
L = 60;
h = cos(0.44 * pi * (0:L-1));

% Frequency response
[H, w] = freqz(h, 1, 1024);

% Plot frequency response
figure;
plot(w/pi, abs(H));
title('Frequency Response of Bandpass Filter (L=60)');
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('|H(e^{j\omega})|');

% Check attenuation
attenuation_03pi = 20 * log10(abs(H(find(w >= 0.3 * pi, 1))));
attenuation_07pi = 20 * log10(abs(H(find(w >= 0.7 * pi, 1))));
disp(['Attenuation at 0.3π: ', num2str(attenuation_03pi), ' dB']);
disp(['Attenuation at 0.7π: ', num2str(attenuation_07pi), ' dB']);


% Filter the signal with the longer bandpass filter
y = firfilt(h, x);

% Plot input and output signals
figure;
subplot(2,1,1);
plot(n(1:100), x(1:100));
title('Input Signal (First 100 Points)');
xlabel('n');
ylabel('x[n]');

subplot(2,1,2);
plot(n(1:100), y(1:100));
title('Output Signal (First 100 Points)');
xlabel('n');
ylabel('y[n]');


% Plot the frequency response of the filter
figure;
plot(w/pi, abs(H));
title('Frequency Response of Long Bandpass Filter');
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('|H(e^{j\omega})|');

% Connect the mathematical description to the output signal
magnitude_03pi = abs(H(find(w >= 0.3 * pi, 1)));
magnitude_044pi = abs(H(find(w >= 0.44 * pi, 1)));
magnitude_07pi = abs(H(find(w >= 0.7 * pi, 1)));

disp(['Magnitude at 0.3π: ', num2str(magnitude_03pi)]);
disp(['Magnitude at 0.44π: ', num2str(magnitude_044pi)]);
disp(['Magnitude at 0.7π: ', num2str(magnitude_07pi)]);
