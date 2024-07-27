% Define parameters
fs = 8000;
fb = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
L1 = 40;
L2 = 80;

% Generate filters
hh1 = dtmfdesign(fb, L1, fs);
hh2 = dtmfdesign(fb, L2, fs);

% Plot frequency responses
figure;
subplot(2, 1, 1);
hold on;
for k = 1:8
    H = freqz(hh1(:, k), 1, 1024, fs);
    plot(linspace(0, pi, length(H)), abs(H));
end
title('Frequency Response of BPFs with L = 40');
xlabel('Normalized Frequency (\pi rad/sample)');
ylabel('Magnitude');
legend(arrayfun(@(f) sprintf('%d Hz', f), fb, 'UniformOutput', false));

subplot(2, 1, 2);
hold on;
for k = 1:8
    H = freqz(hh2(:, k), 1, 1024, fs);
    plot(linspace(0, pi, length(H)), abs(H));
end
title('Frequency Response of BPFs with L = 80');
xlabel('Normalized Frequency (\pi rad/sample)');
ylabel('Magnitude');
legend(arrayfun(@(f) sprintf('%d Hz', f), fb, 'UniformOutput', false));
