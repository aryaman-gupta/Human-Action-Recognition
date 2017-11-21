function Pout = simNorTra(Pin)
% Similarity Normalization Transform
% Pin = [p1 p2 p3 p4]; 3x4 matrix with four 3D points
% Pout is the similarity normalization transform of Pin with respect
% to p1,p2, so that p1 goes to (0,0,0) and p2 goes to (1,1,1). 
% See [1] and [2] for details
%
% References
% ----------
% [1]1 G. Evangelidis, G. Singh, R. Horaud, "Skeletal Quads: Human action 
% recognition using joint quadruples", ICPR, 2014.
% 
% [2] G. Evangelidis, G. Singh, R. Horaud, "Continuous Gesture Recognition 
% from articulated Poses", ChalearnLAP2014 Workshop, ECCV, 2014.
%
% For any bugs or comments, please contact: 
% Gurkirt Singh, guru094@gmail.com
% Georgios Evangelidis, georgios.evangelidis@inria.fr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if size(Pin,1)~=3 || size(Pin,2)~=4
    error('the input matrix must be 3x4');
end

P = Pin;
p1 =P(:,1);
T = -p1(:,[1 1 1]);

%T = -repmat(P(:,1),1,4); %translation

p2 = P(:,2) - P(:,1);

theta1 = atan2(p2(2), p2(1));
phiXY1 = -theta1+pi/4;

c1 = cos(phiXY1);
s1 = sin(phiXY1);

Rz1 = [c1 -s1 0;
    s1 c1 0;
    0 0 1];

%p2 = Rz1*p2;

p2_1 = c1*p2(1)-s1*p2(2);
p2(2) = s1*p2(1)+c1*p2(2);

p2(1) = p2_1;

no2 = sum(p2(1:2).*p2(1:2));
no = 2*(no2+p2(3)*p2(3));

%phi = acos(sum(p2(1:2))/norm(p2)/sqrt(2));
phi = acos(sum(p2(1:2))/sqrt(no));

if p2(3)>0
    phi = -phi+0.615479708670387;
else
    phi = phi+0.615479708670387;
end


% rotation axis
%r = cross(p2,[0 0 1]');

r = [p2(2); -p2(1); 0];

r = r/sqrt(no2);

C = cos(phi);
S = sin(phi);
F = 1-C;

% %rotation around r
% RR = [F*r(1)^2+C, F*r(1)*r(2)-S*r(3), F*r(1)*r(3)+S*r(2);
%     F*r(1)*r(2)+S*r(3), F*r(2)^2+C, F*r(2)*r(3)-S*r(1);
%     F*r(1)*r(3)-S*r(2), F*r(2)*r(3)+S*r(1), F*r(3)^2+C];

% some elements are zero
RR = [F*r(1)^2+C, F*r(1)*r(2), S*r(2);
    F*r(1)*r(2), F*r(2)^2+C, -S*r(1);
    -S*r(2), S*r(1), C];

P = P(:,2:4);

%Translation
P = P + T; % p1 becomes (0,0,0)

%Rotation
P = RR* Rz1*P; % the three coordinates of p2 become equal

%[c1*P(1,2)-s1*P(2,2); s1*P(1,2)+c1*P(2,2); P(3,2)]

%Scaling
P = P./P(1,1); % p2 goes to (1,1,1)

Pout = [zeros(3,1) P];




