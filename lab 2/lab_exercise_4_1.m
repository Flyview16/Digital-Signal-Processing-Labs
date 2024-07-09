% File: lab_exercise_4_1.m

% Parameters
A = 10;
B = 10;
fc = 1000;
delf = 20;
fsamp = 11025;
dur = 1;

% Generate beat signal
[xx, tt] = beat(A, B, fc, delf, fsamp, dur);

% Plot the first 0.2 seconds
figure;
plot(tt(1:round(0.2*fsamp)), xx(1:round(0.2*fsamp)));
xlabel('Time (s)');
ylabel('Amplitude');
title('Beat Signal - First 0.2 seconds for delf = 20(higher)');
