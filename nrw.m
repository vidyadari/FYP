%% Calculation of Mu & Epsilon from Data file
% Development Date : 01.05.2022

clear all; 
clc;
close all;
format short;

%% Insertion of Data files.
S11_amp = dlmread('S11_amplitude.txt');
S11_phase = dlmread('S11_phase.txt');
S21_amp = dlmread('S21_amplitude.txt');
S21_phase = dlmread('S21_phase.txt');
C = 3e8;                        % Velocity of light in free space in m/s
Freq = S11_amp(:,1);            % Frequency zone of Operation
lamda0 = C./Freq;                % Free Space Wavelength

d = 0.0016;                       % substrate thickness

% Starting of the calculation...
% Stage - 1 : Calculation of S11 & S21
S11 = S11_amp(:,2).*(cos(S11_phase(:,2)*pi/180)+1i*sin(S11_phase(:,2)*pi/180));
S21 = S21_amp(:,2).*(cos(S21_phase(:,2)*pi/180)+1i*sin(S21_phase(:,2)*pi/180));

% Stage - 2 : Calculation of various relevant parameters
V1 = S21 - S11;
V2 = S21 + S11;
k0 = 1/lamda0;                % wave number of free space

% Stage - 3 : Final calculation of relative permittivity & permiability
Mu_eff = 2*lamda0.*(1-V2)/((1+V2).*1i*d);
Eps_eff = 2*lamda0.*(1-V1)/((1+V1).*1i*d);

% Storing the generated values in a Data file
Filename = ['Cu_Relative Permittivity & Permiability file, dated-', num2str(date), '_Starting freq.-',num2str(Freq(1)/1e9),...
            ' GHz_End freq.-',num2str(Freq(end)/1e9), ' GHz_Substrate thickness-',num2str(d),' m.dat']
% Opening of the File:
            fid1 = fopen(Filename,'w');
% $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $
            % Writing Variable Names:
            dataA1 = ['Frequency', ' Real_S11', ' Imag_S11', ' Real_S21', ' Imag_S21', ' Real_Energy', ' Imag_Energy',...
                       ' Real_Effec._Mu', ' Imag_Effec._Mu', ' Real_Effec.Eps', ' Imag_Effec.Eps'];      
            fprintf(fid1,'%s %s %s %s %s %s %s %s %s%s %s\n',dataA1);
% $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $
% Writing Units corresponding to the Variables:
            dataA2 = [' GHz', ' -', ' -', ' -', ' -', ' Joule', ' -', ' -', ' -', ' -', ' -']';      
            fprintf(fid1,'\n%s %s %s %s %s %s %s %s %s %s %s',dataA2);
% $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $ $
% Writing of the Variables at the end of the programme
            data1 = [(Freq'/1e9); real(S11)'; imag(S11)'; real(S21)'; imag(S21)'; ...
                       real(Mu_eff)'; imag(Mu_eff)'; real(Eps_eff)'; imag(Eps_eff)'];      
            fprintf(fid1,'\n%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f',data1);
            fclose(fid1);

figure(1)
plot(Freq,real(Mu_eff), 'r')
title('Effective Permiability...');
% xlabel('Frequency');
% ylabel('Real Mu');
hold on
plot(Freq,imag(Mu_eff), 'b')
% title('Effective Permiability...');
xlabel('Frequency');
ylabel('Real & img(Permiability)');
L(1) = plot(nan, nan, 'r-');
L(2) = plot(nan, nan, 'b-');
legend(L, {'real', 'imaginary'})
hold off

figure(2)
plot(Freq,real(Eps_eff),'r')
title('Effective Permittivity...');
% xlabel('Frequency');
% ylabel('Real Eps');
hold on
plot(Freq,imag(Eps_eff),'b')
% title('Effective Permittivity...');
xlabel('Frequency');
ylabel('Real & img(Permittivity)');
L(1) = plot(nan, nan, 'r-');
L(2) = plot(nan, nan, 'b-');
legend(L, {'real', 'imaginary'})
hold off


