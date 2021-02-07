% housing_vec is an array of vectors normal to the spine that denote the 
% direction of the housing holes. size = (row = 3, col = h_num). Offset
% gives a phase shift. When zero, we assume that the first through hole
% is in the top or north position when viewing from the x-y plane. 
% vec = (0 1 0). Offset is in units of radians.

% We assume that the housing holes are evenly spaced about the spine axis.
% We also assume that the number of holes/stsm mechanisms per segment is 
% greater than 2 for control in 3 dimensions.

% Robert Shi rs36@princeton.edu
function [housing_vec] = housing_structure(h_holes, h_radius, h_dist, offset)
    a = 2*pi/h_holes;
    % rotation by angle a about spine axis (z)
    rot_mat = stsm_make_rot_mat([0 0 a]);
    % initial coordinates of offset;
    housing_vec = [sin(offset)*h_radius; cos(offset)*h_radius; 0];
    for i=1:h_holes-1
        housing_vec = [housing_vec rot_mat * housing_vec(:,end)];
    end
% %     plot the points in the x-y plane.
%     figure
%     plot(housing_vec(1,:), housing_vec(2,:));
end