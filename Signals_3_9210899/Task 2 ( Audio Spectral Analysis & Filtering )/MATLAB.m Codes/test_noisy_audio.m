%% Test Input Audio File To get Fstop & Fpass
clc;
close all;
[x, fs] = audioread('audio.wav');
N = length(x);

%% Plotting against k
k = 0 : N - 1;
y = fft(x, N);
plot(k, abs(y));

%% Plotting against Frequency in HZ
f = (0 : N - 1) * fs / N;
plot (f, abs(y) / N);

%% Shifting Zero to the center of Spectrum then Plotting against Frequency in HZ
f = (-N/2 : N/2 - 1) * fs / N;
plot(f, abs(fftshift(y)) / N);