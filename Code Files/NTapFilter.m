clc; clear;

% Read input
hfile = 'mike.wav';
[y, Fs] = audioread(hfile);

K = 100;

% Constant N and K, change alpha from 0 to 1
% and plot SNR

N = 50;
alpha = 0:0.1:1;
result1 = zeros(length(alpha), 1);

i = 1;
while i <= length(alpha)
    result1(i) = totalCalculator(y, N, Fs, K, alpha(i));
    i = i + 1;
end

figure;
plot(alpha, result1);
title('Constant N(50) and K(100ms), change alpha from 0 to 1');

% Constant alpha and K, change N from 1 to 50
% and plot SNR

alpha = 0.2;
K = 100;
result2 = zeros(50, 1);

i = 1;
while i <= 50
    result2(i) = totalCalculator(y, i, Fs, K, alpha);
    i = i + 1;
end

figure;
plot(1:50, result2);
title('Constant alpha(0.2) and K(100ms), change N from 1 to 50');

% Constant alpha and N, change K between 100,200,300,400
% and plot SNR

N = 50;
alpha = 0.2;
result3 = zeros(4, 1);

i = 1;
while i <= 4
    result3(i) = totalCalculator(y, N, Fs, 100*i, alpha);      
    i = i + 1;
end

figure;
plot(100:100:400, result3);
title('Constant alpha(0.2) and N(50), change K between 100ms 200ms 300ms 400ms');

% Function in order to calculate SNR for given original data,
% N, Fs, K and alpha values. This function calls other functions
% and returns the result of SNR calculation.
function res = totalCalculator(original, N, Fs, K, alpha)
    shifted = delay(original, Fs, K);
    with_delay = original + shifted;
    filt = nTapFilt(with_delay, N, Fs, K, alpha);
    SNR = snrCalculator(original, filt);
    res = SNR;
end

% Function in order to calculate SNR
% Takes original, recovered lists as parameter
% And returns result of calculations.
function val = snrCalculator(original, recovered)
    x = 0;
    y = 0;
    i = 1;
    while i<=length(original)
       x = x + original(i) * original(i);
       y = y + (recovered(i) - original(i)) * (recovered(i) - original(i));
       i = i + 1;
    end
    
    val = 10 * log10(x/y);
end
% Function in order to implement N-Tap-Filter
% Takes signal, Fs, K, N, alpha as parameters
% And returns output with its size.

function filt = nTapFilt(signal, N, Fs, K, alpha)
    filt = signal;
    shifted = signal;
    i = 1;
    while i <= N
        shifted = delay(shifted, Fs, K);
        filt = filt + shifted.*((-1)*alpha)^i;
        i = i + 1;
    end
end

% Function in order to delay a given signal
% Takes signal, Fs, K as parameters
% And returns delayed signal with its size.

function shifted = delay(signal, Fs, K)
    first = (Fs * K) / 1000;
    shifted = [zeros(first, 1); signal(1:length(signal)-first)];
end
