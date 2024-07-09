% File: lab_exercise_4_3.m

% Parameters for chirp signal
fs = 11025;
t = 0:1/fs:3; % 3 seconds duration
f0 = 5000; % start frequency
f1 = 300; % end frequency

% Generate chirp signal
chirp_signal = chirp(t, f0, 3, f1);

% Plot the chirp signal
figure;
plot(t, chirp_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Chirp Signal');

% Listen to the chirp signal
sound(chirp_signal, fs);

% Spectrogram of the chirp signal
figure;
specgram(chirp_signal, 2048, fs);
colormap(1-gray(256));
title('Spectrogram of Chirp Signal');
