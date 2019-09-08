clc; clear;

% Set name of figure for problem 9
f = figure('Name', 'Advanced Peak Finder', 'NumberTitle', 'off');
figure(f);

% Open file named exampleSignal.csv which is in the same directory.
fileID = fopen('exampleSignal.csv', 'r');

%Read file
A = fscanf(fileID, '%f');
A = A(4:length(A));

samples = 1:30;

numOfPeaks = zeros(1, 30);

%Find peaks without moving average filter
peaks = findpeaks(A);

numOfPeaks(1) = length(peaks);

for i = 2:30
    B = (1/i)*ones(i,1);
    out = filter(B, 1, A);
    
    peaks = findpeaks(out);
    numOfPeaks(i) = length(peaks);
end

plot(samples, numOfPeaks);
title('Number of peaks versus N');