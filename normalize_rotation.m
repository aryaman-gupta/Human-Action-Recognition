function [newQuad] = normalize_rotation(quad)
% This function normalizes any rotation of the quad around the vector
% [1,1,1]. It is a helper function of skeletalQuad that is used when full
% similariy invariance is required.

if numel(quad)~=6
    error('The input os not a valid 3D quad descriptor (check the length)');
end

if size(quad,1) == 1
    quad = quad';
end


A = [1;1;1]; % second point of the quadruple

v = quad(1:3); % third point of the quadruple
nv = norm(v);
sro2 = sqrt(2);
sro3 = sqrt(3);
sov = sum(v);


% find x that is the rotation of v around A until it lies on the plane
% x=y
x = zeros(3,1);

% angle between A and XY plane.
%theta = acos(dot([1,1,1],[1 1 0])/sro3/sro2);
theta = acos(2/sro3/sro2);% above dot is always 2

% angle between v and A
%wmega = acos(dot([1,1,1],v)/sro3/nv);
wmega = acos(sov/sro3/nv); % above dot is sum of v


a = nv*cos(wmega)*ones(3,1)/sro3; %projection of v into A

cc = cos(wmega+theta); % angle between x and XY plane

x(1) = nv*sro2*cc/2;
x(2) = x(1);
x(3) = sov-2*x(1);

% angle of final rotation
cosPhi = dot(x-a,v-a)/norm(x-a)/norm(v-a);

% rotation axis
r = A/sro3;

C = cosPhi;
F = 1-C;
S = sqrt(1-cosPhi*cosPhi); % sin(Phi)


% non-ambiguous part of 3D rotation around r
R0 = [F*r(1)^2+C, F*r(1)*r(2), F*r(1)*r(3)
     F*r(1)*r(2), F*r(2)^2+C, F*r(2)*r(3)
     F*r(1)*r(3), F*r(2)*r(3), F*r(3)^2+C];

 
% There is a sign ambiguity for this part owing to sin
Smat = [0, S*r(3), -S*r(2);
     -S*r(3), 0, S*r(1);
     S*r(2), -S*r(1), 0];

term = dot(Smat*v,x);
 
if term>0
    RR = R0+Smat;
else
    RR = R0-Smat;
end

% rotate the third and forth points with RR to normalize any rotation 
q3 = RR*v;
q4 = RR*quad(4:6);

newQuad = [q3;q4];

  
