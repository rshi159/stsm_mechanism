% computes the number of rotations in each stsm provided in
% the matrix of stsm lengths. Returns matrix on success. returns TODO 
% in case distance is unreachable.
function [stsm_angles_total, stsm_angles_segment, stsm_angles_spacer] = stsm_len_to_angles(stsm_lengths,s_num, s_diam, s_thick,s_radius, str_len)
%     take entire stsm length, subtract total thickness of spacers,
%     divide by number of spacers in the stsm segment
    len_single = (stsm_lengths - s_num * s_thick) / s_num;
%     see notes for derivation. Find the rotation necessary between
%     two spacers to get the desired length.
    stsm_angles_spacer = acos((len_single.^2 - str_len^2)/(2*s_radius^2) + 1);
    stsm_angles_segment = stsm_angles_spacer * s_num;
    stsm_angles_total = sum(stsm_angles_segment,2);
end