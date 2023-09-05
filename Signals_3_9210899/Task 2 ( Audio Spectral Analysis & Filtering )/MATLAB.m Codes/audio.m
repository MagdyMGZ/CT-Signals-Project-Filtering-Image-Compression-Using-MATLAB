%% Read The Input Audio
[x, fs] = audioread('audio.wav');
N = length(x);
%% Plotting against k
k = 0 : N - 1;
y = fft(x,N);
plot(k,abs(y));
%% Plotting against Frequency in HZ
f = (0 : N - 1) * fs / N;
plot(f, abs(y) / N);
%% Shifting Zero to the center of Spectrum 
% then Plotting against Frequency in HZ
f = (-N / 2 : N / 2 - 1) * fs / N;
plot(f, abs(fftshift(y)) / N);
%% Filtering With Fstop ≅ 3000 & Fpass ≅ 2500
filtered = filter(Hd, x);
m = length(filtered);
Filtered_NEW = fft(filtered, m);
%% Plotting against k
plot(k, abs(Filtered_NEW));
%% Plotting against Frequency in HZ
f = (0 : N - 1) * fs / m;
plot(f,abs(Filtered_NEW) / m);
%% Shifting Zero to the center of Spectrum
f = (-N / 2 : N / 2 - 1) * fs / m;
%% Plotting against Frequency in HZ
plot(f, abs(fftshift(Filtered_NEW)) / m);
%% Write The Output Audio
audiowrite("filtered.wav", filtered, fs);
[z, fss] = audioread("filtered.wav");
sound(z, fss);
%% Plotting the Frequency Responce & Impulse Response
impz(Hd);
freqz(Hd);