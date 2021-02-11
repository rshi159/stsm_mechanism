close all; clc
Length=10; samples=4096;
tprime=linspace(0,Length,samples+1); t=tprime(1:samples);
signal=(7*cos(3*t)+2*tanh(0.5*(t-7))+4*sin(5*(t-5).^2)+0.33*exp(-(t-2).^2))/9+(t/23).^2;
k=(2*pi/Length)*[0:samples/2-1 -samples/2:-1];
kshift=fftshift(k);
signalfftd=fft(signal);
pause(4);
tau=0:0.5:2*Length;
window=0.1;
window_limit=10;
for k=1:window_limit
    window=window*2;
    for j=1:length(tau)
        gabor=exp(-window*(t-tau(j)/2).^2);
        signalgabor=gabor.*signal;
        signalgabord=fft(signalgabor);
        subplot(3,1,1), plot(t,signal,'k',t,gabor,'r')
        subplot(3,1,2), plot(t,signalgabor,'k')
        subplot(3,1,3), plot(kshift,abs(fftshift(signalgabord))/max(abs(signalgabord)))
        axis([-100 100 0 1])
        drawnow
        pause(window*0.001)
    end
end