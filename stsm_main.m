% stsm_sim
% Description: Graphical simulation of a twisted string driven continuum limb.

% Updated: 07 FEB 2021
% By: Robert Shi rs36@princeton.edu

clc;clear all;close all;

%set parameters. vector order starts with driving spacer -> end/anchor spacer.
s_num = 3; %number of spacers including spacers on the ends
% strings = 6; %number of strands between 
s_diam = 25; %diameter of spacer
s_thick = 2.5; %spacer thickness
str_length_rest = 20; %num_spacers - 1 length array. length of string 
    %between spacers when mechanism is at rest.
h_dist = 50; %distance between housing
h_num = 7; % number of housings = number of "links" or segments.
h_radius = 25; % perpendicular distance from center of housing to spine.
h_holes = 3; % numbrer of throughholes per housing. Same as number of sTSMs per segment.

angle_x = pi/10; % angles to rotate each segment by.
angle_y = 0;
angle_z = 0;
angles = [angle_x angle_y angle_z];
% stsm_make_rot_mat(angles)
offset = pi/4;
housing_vec = housing_structure(h_holes, h_radius, h_dist, offset);
[spine_plot, housing_centers, rot_vec] = stsm_geometric(h_radius,h_dist, h_holes,housing_vec, h_num, angles, 0);
[lengths, stsm_plot_coords] = stsm_lengths(spine_plot, h_num, h_holes);

[stsm_angles_total, stsm_angles_segment, stsm_angles_spacer] = stsm_len_to_angles(lengths,s_num, s_diam, s_thick,s_diam/2, str_length_rest);
plt = true;
if plt
    figure(1)
    ax=gca;
    plot3(spine_plot(1,:),spine_plot(2,:),spine_plot(3,:), 'linewidth',5);
    hold(ax,'on');
    for i = 1:h_holes
        plot3(stsm_plot_coords(1,:,i),stsm_plot_coords(2,:,i),stsm_plot_coords(3,:,i), 'linewidth',2); 
        % plot lengths in the middle of each stsm
        midpoints = diff(stsm_plot_coords,1,2)/2 + stsm_plot_coords(:,1:end-1,:);
        text(midpoints(1,:,i),midpoints(2,:,i),midpoints(3,:,i), string(lengths(:,:,i)),'fontsize',16,'horizontalalignment','center');
    end
    axis equal;
    grid on;
end
disp(">>>DONE<<<");