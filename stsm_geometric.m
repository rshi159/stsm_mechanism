% takes input of physical properties of the continuum limb and 
% returns matricies of housing. housing_vec is an array of
% vecotrs normal to the spine that denote the direction of the 
% housing holes. size = (row = 3, col = h_num).
function [spine_plot, housing_centers, prev_vec] = stsm_geometric(h_rad,h_dist, h_holes,housing_vec, h_num, angles, dampening)
    
%     terminal point of last segment
    rot_mat = stsm_make_rot_mat(angles);
    prev_terminal = [0;0;0];
    prev_vec = [0; 0; h_dist];
    housing_centers = [prev_terminal];
    %setup for mechanism at origin.
    len = size(housing_vec);
    temp = zeros(3, 2*len(2));
    idx = 1:len(2);
    temp= repmat([0;0;0], 1, len(2)*2);
    temp(:,idx*2) = housing_vec;
    spine_plot = [temp [0;0;0]];
    for i=1:h_num
        prev_vec = [prev_vec rot_mat * prev_vec(:,end)];
        prev_terminal = [prev_terminal prev_vec(:,end) + prev_terminal];
        housing_centers = [housing_centers prev_terminal(:,end)];
        temp= repmat(prev_terminal(:,end), 1, len(2)*2);
        temp(:,idx*2) = rot_mat^i * housing_vec+prev_terminal(:,end);
        spine_plot = [spine_plot temp prev_terminal(:,end)];
    end
end