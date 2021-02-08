% Calculates each stsm length in each segment. Numbering goes idx 1 is the 
% topmost as defined by offset given in housing_strictire.m. Increment by 
% clockwise about spine axis as viewed from the origin.

% returns a matrix of lengths and 3-d matrix with coordinates for plotting.
function [lengths, stsm_plot_coords] = stsm_lengths(spine_plot, h_num, h_holes)
    len = size(spine_plot);
    % starting index for each segment
    seg_idx = 1:h_holes*2+1:len(2);
    % number of holes
    hole_idx = 1:h_holes; 
    % index offset of hole from starting index of segment.
    index_offset = hole_idx * 2 -1;
    stsm_plot_coords = zeros(3, h_num+1,h_holes);
    % 
    for i=hole_idx
        stsm_plot_coords(:,:,i) = spine_plot(:,seg_idx + index_offset(i));
    end
    lengths = vecnorm(diff(stsm_plot_coords,1,2),2,1);
end