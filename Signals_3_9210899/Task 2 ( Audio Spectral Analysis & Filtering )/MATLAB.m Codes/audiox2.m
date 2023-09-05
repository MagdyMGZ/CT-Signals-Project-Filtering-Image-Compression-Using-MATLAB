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
%% Plotting against Frequency in HZ x2 Speed
f = (0 : N - 1) * (2*fs) / m;
plot(f,abs(Filtered_NEW) / m);
%% Shifting Zero to the center of Spectrum
f = (-N / 2 : N / 2 - 1) * (2*fs) / m;
%% Plotting against Frequency in HZ
plot(f, abs(fftshift(Filtered_NEW)) / m);
%% Write The Output Audio x2 Speed
audiowrite("filteredx2.wav", filtered, 2*fs);
[z, fss] = audioread("filteredx2.wav");
sound(z, 2*fss);
%% Plotting the Frequency Responce & Impulse Response
impz(Hd);
freqz(Hd);