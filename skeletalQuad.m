function [ quad ] = skeletalQuad(points,fullInvFlag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ QUAD ] = SKELETALQUAD(POINTS, FULLINVFLAG)
% SKELETALQUAD computes the skeletal quad descriptor (code) that encodes
% the geometric structure of the quadruple in POINTS. When FULLINVFLAG is 
% true (~0), the full similarity invariance is enabled.
% When FULLINVFLAG is 0 (default), similarity invariance is enabled up to a
% rotation around the axis defined by the two first columns of POINTS 
% (control points). For details, please see [1] and [2].
%
% --> Input
% POINTS:       A 4x3 matrix that contains the four 3D points of the
%               quadruple
% FULLINVFLAG:  A flag that defines the extent of the similarity invariance
%               (see above)
%
%
% --> Output
% QUAD:         The descriptor that encodes the geometric relation between
%               the entries of POINTS (the points of the quadruple). When 
%               FULLINVFLAG is 0 (default), a 6D descriptor is returned.
%               Otherwise (FULLINVFLAG = 1), the function returns a 5D
%               descriptor.
%
% References
% ----------
% [1]1 G. Evangelidis, G. Singh, R. Horaud, "Skeletal Quads: Human action 
% recognition using joint quadruples", ICPR, 2014.
% 
% [2] G. Evangelidis, G. Singh, R. Horaud, "Continuous Gesture Recognition 
% from articulated Poses", ChalearnLAP2014 Workshop, ECCV, 2014.
% ----------
% For any bugs or comments, please contact: 
% Gurkirt Singh, guru094@gmail.com
% Georgios Evangelidis, georgios.evangelidis@inria.fr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if size(points,1)~=3 || size(points,2)~=4
    error('the first argument should be a matrix 3x4 (a quadruple of 3D points)');
end

if nargin==1
    fullInvFlag = 0; %default value
end
    % compute the Similarity normalized code from Quadruple ("points")
    pointsNew = simNorTra(points);
    pointsNew = pointsNew(:,3:4); %keep only the last two columns
    
if fullInvFlag
    %% Normalize the rotation
    temp = normalize_rotation(pointsNew(:));
    quad = temp(2:end); % 5D code
    
else
    %% Return the code as computed without rotation normalization
    quad = pointsNew(:); % 6D code
end


