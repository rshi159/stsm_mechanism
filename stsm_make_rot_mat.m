% creates a rotation matrix given rotations about x , y , (z should be 0
% if anchored). Returns a rotation matrix.
function [rot_mat] = make_rot_mat(angles)
    x = [1 0 0;
        0 cos(angles(1)) -sin(angles(1));
        0 sin(angles(1)) cos(angles(1))];
    y = [cos(angles(2)) 0 sin(angles(2));
        0 1 0;
        -sin(angles(2)) 0 cos(angles(2))];
    z = [cos(angles(3)) -sin(angles(3)) 0;
        sin(angles(3)) cos(angles(3)) 0;
        0 0 1];
    rot_mat = x*y*z;
end