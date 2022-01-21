clear all
% a 
% Showing the ideal image
P = phantom('Modified Shepp-Logan',500); 
imshow(P)
title("Ideal Image")
figure()
% Showing the magnitude spectrum
F=fft2c(P);
imshow(log(abs(F)+1),[])
title("Magnitude Spectrum of Ideal Image")
figure()
%b
%i)-------------------------
xi=[-249:1:250];
yi=[-249:1:250];
psfi=zeros(500,500);
for k=1:500
    for l=1:500
psfi(k,l)=tri(xi(k)/3,yi(l)/8);
    end
end
surf(xi,yi,psfi)
title("tri(x/3,y/8) PSF")
xlabel("x")
ylabel("y")
figure()
%transfer function which is fourier of impulse response(psf)
Transferi=fft2c(psfi);
imshow(log(abs(Transferi)+1),[])
title("tri(x/3,y/8) Transfer Function Magnitude")
figure()
%ii)-----------------------------------------
xii=[-249:1:250];
yii=[-249:1:250];
psfii=zeros(500,500);
for k=1:500
    for l=1:500
psfii(k,l)=expo2(xii(k),yii(l));
    end
end
surf(xii,yii,psfii)
title("exponential PSF with theta=1")
xlabel("x")
ylabel("y")
figure()
Transferii=fft2c(psfii);
imshow(log(abs(Transferii)+1),[])
title("exponential Transfer Function Magnitude")
figure()
%iii)--------------------------
xiii=[-249:1:250];
yiii=[-249:1:250];
psfiii=zeros(500,500);
for k=1:500
    for l=1:500
        %using seperablity
psfiii(k,l)=sinc(xiii(k)/8)*sinc(yiii(l)/3);
    end
end
surf(xiii,yiii,psfiii)
title("sinc PSF with")
xlabel("x")
ylabel("y")
figure()
Transferiii=fft2c(psfiii);
imshow(log(abs(Transferiii)+1),[])
title("sinc Transfer Function Magnitude")
figure()
%c---------------------------
%With h=tri
IdealImagei=F.*Transferi;
IdealImagei=ifft2c(IdealImagei);
imshow(IdealImagei);
title("Image resulted by using tri function system ")
figure()
%--magnitude
imshow(log(abs(IdealImagei)+1),[])
title("Magnitude Spectrum of Image resulted by using tri function system ")
figure()
%With h=exp
IdealImageii=F.*Transferii;
IdealImageii=ifft2c(IdealImageii);
imshow(IdealImageii);
title("Image resulted by using exp function system ")
figure()
%--magnitude
imshow(log(abs(IdealImageii)+1),[])
title("Magnitude Spectrum of Image resulted by using exp function system ")
figure()
%h=sinc
IdealImageiii=F.*Transferiii;
IdealImageiii=ifft2c(IdealImageiii);
imshow(IdealImageiii);
title("Image resulted by using sinc function system ")
figure()
%--magnitude
imshow(log(abs(IdealImageiii)+1),[])
title("Magnitude Spectrum of Image resulted by using sinc function system ")
figure()
function h=tri(a,b)
if and(abs(a)<=1,abs(b)<=1)
    h=((1-abs(a))*(1-abs(b)));
else
    h=0;
end
end
function h=expo2(a,b)
theta=1;
h=exp(-(a^2+b^2)/(2*theta^2))*1/(2*pi*theta*theta);
end
function d = fft2c(im)
 % d = fft2c(im)
 %
 % fft2c performs a centered fft2
 im = fftshift(fft2(ifftshift(im)));
 d=im;
 end
 function im = ifft2c(d)
 % im = fft2c(d)
 %
 % ifft2c performs a centered ifft2
 im = fftshift(ifft2(ifftshift(d)));
 end