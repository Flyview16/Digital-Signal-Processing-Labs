% File: lab_exercise_4_2.m

% Parameters for beat signal
A = 1;
B = 1;
fc = 2000;
delf = 32;
fsamp = 11025;
dur = 0.26;

% Generate beat signal
[xx, tt] = beat(A, B, fc, delf, fsamp, dur);

% Plot the beat signal
 figure;
 plot(tt, xx);
 xlabel('Time (s)');
 ylabel('Amplitude');
 title('Beat Signal');

% Spectrogram with window length 2048
 figure;
 specgram(xx, 2048, fsamp);
 colormap(1-gray(256));
 title('Spectrogram with Window Length 2048');

% Spectrogram with window length 16
 figure;
 specgram(xx, 16, fsamp);
 colormap(1-gray(256));
 title('Spectrogram with Window Length 16');
