% File: lab_exercise_4_4.m

% Parameters for chirp signal with negative frequency
fs = 11025;
t = 0:1/fs:3; % 3 seconds duration
f0 = 3000; % start frequency
f1 = -2000; % end frequency

% Generate chirp signal with negative frequency
chirp_signal_negative = chirp(t, f0, 3, f1);

% Plot the chirp signal
figure;
plot(t, chirp_signal_negative);
xlabel('Time (s)');
ylabel('Amplitude');
title('Chirp Signal with Negative Frequency');

% Listen to the chirp signal
sound(chirp_signal_negative, fs);

% Spectrogram of the chirp signal with negative frequency
figure;
specgram(chirp_signal_negative, 2048, fs);
colormap(1-gray(256));
title('Spectrogram of Chirp Signal with Negative Frequency');
