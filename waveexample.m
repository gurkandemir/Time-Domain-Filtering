%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   CMPE 362 Homework II-b   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;
                                                % Fs is the frequency = number of samples per second
                                                % y is the actual sound data 
hfile = 'laughter.wav';                         % This is a string, corresponding to the filename
clear y Fs                                      % Clear unneded variables

%% PLAYING A WAVE FILE

[y, Fs] = audioread(hfile);      % Read the data back into MATLAB, and listen to audio.
                                                % nbits is number of bits per sample
sound(y, Fs);                                   % Play the sound & wait until it finishes

duration = numel(y) / Fs;                       % Calculate the duration
pause(duration + 2)                             % Wait that much + 2 seconds

%% CHANGE THE PITCH

sound(y(1:2:end), Fs);                          % Get rid of even numbered samples and play the file
pause(duration/2 + 2)

%% EXERCISE I
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Re-arrange the data so that   %
%   the frequency is quadrupled and play the file   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sizeOfY = size(y,1);
newS = zeros(13159, 1);
i = 1;
while i <= 13159
    newS(i) = y(4*i-3);
    i = i + 1;
end

sound(newS, Fs);
pause(duration/4 + 2);
                                                                       
%% EXERCISE II
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Re-arrange the data so that   %
%   the frequency is halved and play the file  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

newSound = zeros(sizeOfY * 2, 1);
i = 1;
while i < sizeOfY
    newSound(2*i-1) = y(i);
    newSound(2*i) = (y(i)+y(i+1))/2;
   i = i + 1;
end
newSound(2*i-1) = y(i);
newSound(2*i) = y(i);

sound(newSound, Fs);
pause(2*duration + 2);
                                          
%% EXERCISE III 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Double Fs and play the sound  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sound(y, 2*Fs);
pause(duration/2 + 2);

%% EXERCISE IV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Divide Fs by two and play the sound  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sound(y, Fs/2);
pause(2*duration + 2);
