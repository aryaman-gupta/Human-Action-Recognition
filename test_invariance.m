clear all
close all
load quadruple % it loads 3x4 matrix 'pin'

alpha = randn(1)*180*pi/180;
Rx     = [1,    0,           0;
    0, cos(alpha), -sin(alpha);
    0, sin(alpha), cos(alpha)];
beta = randn(1)*180*pi/180;
Ry     = [cos(beta),    0,        -sin(beta);
    0,          1,          0;
    sin(beta),   0 ,       cos(beta)];
theta  = randn(1)*180*pi/180;

Rz     = [cos(theta),   -sin(theta)    0;
    sin(theta),    cos(theta)    0;
    0,              0 ,      1];

R = Rx*Ry*Rz;

% a random 3d rotation applies to pin and the quad code is computed

%codeInit = skeletalQuad(pin);
%codeNew = skeletalQuad(R*pin,1);



disp('6D code before rotation');
disp([skeletalQuad(pin,0)]')

disp('6D code after rotation');
disp([skeletalQuad(R*pin,0)]')

disp('5D code before rotation');
disp([skeletalQuad(pin,1)]')

disp('5D code after rotation');
disp([skeletalQuad(R*pin,1)]')
