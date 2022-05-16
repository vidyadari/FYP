clear % Clear workspace
c = 3e8; % Speed of light in vacuum
per = input('Substrate Permitivity='); % Substrate dielectric constant
h = input('Substrate thickness(mm)=').*1e-3; % Substrate thickness
fr = input('Resonant frequency(hz)='); % Resonant frequency
w = c.*1e3./(2.*fr.*sqrt((per+1)./2)) % width of the patch in mm
eper = ((per+1)./2)+(((per-1)./2).*((1+12.*(h./w)).^-0.5)); % Effective permittivity
dl = (0.412.*h).*(((eper+0.3).*((w/h)+0.264))./((eper-0.258).*((w./h)+0.8))); % To calculate effective length
l = c.*1e3./(2.*fr.*sqrt(eper))-(2.*dl) % length of the patch in mm
lg = ((l*1e-3)+6*h)*1e3 % length of the ground in mm
wg = ((w*1e-3)+6*h)*1e3 % width of the ground in mm
wf = exp(7.48*h*1e3/(50*sqrt((per+1.41)/87))-(1.25/fr)) % width of the feed in mm
wi = w/2 % width of the inset in mm
li = l/(2*sqrt(eper)) % lenght of the inset in mm

