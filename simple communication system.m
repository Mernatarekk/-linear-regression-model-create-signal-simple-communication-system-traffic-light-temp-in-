clear;
clc;

% TRANSMITTER
[y,fs]=audioread('Intro.mp3',[1 5*44100]);
x1=input('If you want to play the sound press 1 :');
 if x1==1
     sound(y, fs);
 end

x2=input('If you want to stop the sound press 1 :'); 
 if x2==1
     clear sound
 end
 
%sound signal in time domain
N=size(y,1)
t=linspace(0,5,5*fs);
figure
hold on
plot(t,y);
grid on 
title('Sound signal in TIME domain');
hold off

%sound signal in frequency domain
s=(fftshift(fft(y)));
ymag= abs(s);
yphase = angle(s);
f=linspace(-fs/2,fs/2,length(s));
%the plot of the magnitude 
figure;
subplot(2,1,1);
plot(f , ymag);
title('Plot magnitude of transimetted signal in frequency Domain');
%the plot of the phase
subplot(2,1,2);
plot(f , yphase);
title('Plot phase of transimetted signal in frequency Domain');
 

%CHANNEL
delta= zeros(1,5*44100); 
delta(1)=1;
exp1=exp(-2*pi*5000*t);
exp2=exp(-2*pi*1000*t);
fourth=[2 zeros(1,5*fs-2) 0.5];

fprintf('Which signal you need the impulse response with? %d \n');
imp = ('for delta function press 0 \nfor exp(-2pi*5000t) press 1 \nfor exp(-2pi*1000t) press 2 \nfor 2*delta+0.5*delta(t-1) press 3\n');
impulse=input(imp);
switch impulse 
    case 0 
        fprintf('with delta function');
        yo(:,1)=conv(y(:,1),delta);
        yo(:,2)=conv(y(:,2),delta);
        t2=linspace(0,5,5*fs*2-1);
        figure
        subplot(2,1,1)
        plot(t2,yo(:,1));
        title('impulse response with the 1st signal');
        title('with the left signal');
        subplot(2,1,2);
        plot(t2,yo(:,1));
        title('with the right signal');
        sound(yo,fs);
        pause(6)
    case 1 
        fprintf('with exp(-2pi*5000t)');
        yo(:,1)=conv(y(:,1),exp1);
        yo(:,2)=conv(y(:,2),exp1);
        t2=linspace(0,10,5*fs*2-1);
        figure
        subplot(2,1,1)
        plot(t2,yo(:,1));
        title('impulse response with the 2nd signal');
        title('with the left signal');
        subplot(2,1,2);
        plot(t2,yo(:,1));
        title('with the right signal');
        sound(yo,fs);
        pause(6)
    case 2 
        fprintf('with exp(-2pi*1000t)');
        yo(:,1)=conv(y(:,1),exp2);
        yo(:,2)=conv(y(:,2),exp2);
        t2=linspace(0,10,5*fs*2-1);
        figure 
        subplot(2,1,1)
        plot(t2,yo(:,1));
        title('impulse response with the 3rd signal');
        title('with the left signal');
        subplot(2,1,2);
        plot(t2,yo(:,1));
        title('with the right signal');
        sound(yo,fs);
        pause(6)
        
    case 3 
        fprintf('with f=2*delta+0.5*delta(t-1) \n');
        yo(:,1)=conv(y(:,1),fourth);
        yo(:,2)=conv(y(:,2),fourth);
        t2=linspace(0,6,5*fs*2-1);
        figure
        subplot(2,1,1)
        plot(t2,yo(:,1));
        title('impulse response with the 4th signal');
        title('with the left signal');
        subplot(2,1,2);
        plot(t2,yo(:,1));
        title('with the right signal');
        sound(yo,fs);
        pause(6)
    otherwise 
        fprintf('error in choosing the signal');
end


%ADDING NOISE
s = 'Sigma value: ';
sigma = input(s);
z = sigma * randn(1,length(yo(:,1)));
yo(:,1)=yo(:,1)+z';
yo(:,2)=yo(:,2)+z';

sound(yo,fs);

figure
subplot(2,1,1)
hold on
plot(t2,yo(:,1))
grid on  
title('Left Sound-Noise in TIME domain')
hold off

subplot(2,1,2)
hold on
plot(t2,yo(:,2))
grid on  
title('Right Sound-Noise in TIME domain')
hold off

%sound signal in frequency domain
YON = fftshift(fft(yo));
YO_magnitudeN = abs(YON);
YO_phaseN = angle(YON);
f2 = linspace(-fs/2 , fs/2 , length(YON));

figure
hold on
plot(f2,YON)
grid on  
title('Sound-Noise in frequency domain')
hold off

figure
subplot(2,2,1)
hold on
plot(f2,YO_magnitudeN(:,1))
grid on  
title('Left Magnitude-Noise in frequency domain')
hold off

subplot(2,2,2)
hold on
plot(f2,YO_magnitudeN(:,2))
grid on  
title('Right signal Magnitude-Noise in frequency domain')
hold off

subplot(2,2,3)
hold on
plot(f2,YO_phaseN(:,1))
grid on  
title('Left Phase-Noise in frequency domain')
hold off

subplot(2,2,4)
hold on
plot(f2,YO_phaseN(:,2))
grid on  
title('Right Phase-Noise in frequency domain')
hold off

pause(10)


% RECEIVER
Sig = YON;
remove = ones(length(Sig),1);
%(length(Sig) / fs )*(2.5*10^4 - 3400) = 186499 
remove([1:186499  (length(remove)-186499+1):end]) = 0;  

Sig(:,1) = YON(:,1).*remove;
Sig(:,2) = YON(:,2).*remove;
Final_signal = real(ifft(ifftshift(Sig)));

sound(Final_signal,fs)
pause(8)
figure
subplot(2,1,1)
hold on 
plot(t2,Final_signal(:,1))
grid on  
title('After trying to remove Noise in time domain')
hold off

subplot(2,1,2)
hold on 
plot(t2,Final_signal(:,2))
grid on  
title('After trying to remove Noise in time domain')
hold off

%sound in frequency domain
FINAL = fftshift(fft(Final_signal));
FINAL_magnitude = abs(FINAL);
FINAL_phase = angle(FINAL);
f3 = linspace(-fs/2 , fs/2 , length(FINAL));

figure
hold on
plot(f3,FINAL)
grid on  
title('NOISE REMOVAL in frequency domain')
hold off

figure
subplot(2,2,1)
hold on
plot(f3,FINAL_magnitude(:,1))
grid on  
title('Left Magnitude-Noise REMOVAL in frequency domain')
hold off

subplot(2,2,2)
hold on
plot(f3,FINAL_magnitude(:,2))
grid on  
title('Right Magnitude-Noise REMOVAL in frequency domain')
hold off

subplot(2,2,3)
hold on
plot(f3,FINAL_phase(:,1))
grid on  
title('Left Phase-Noise REMOVAL in frequency domain')
hold off

subplot(2,2,4)
hold on
plot(f3,FINAL_phase(:,2))
grid on  
title('Right Phase-Noise REMOVAL in frequency domain')
hold off

sound(Final_signal,fs)