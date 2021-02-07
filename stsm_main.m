% stsm_sim
% Description: Graphical simulation of a twisted string driven continuum limb.

% Updated: 05 FEB 2021
% By: Robert Shi rs36@princeton.edu

clc;clear;close all;

%set parameters. vector order starts with driving spacer -> end/anchor spacer.
s_num = 3; %number of spacers including spacers on the ends
% strings = 6; %number of strands between 
s_diam = 25; %diameter of spacer
s_thick = 2.5; %spacer thickness
str_length_rest = 20; %num_spacers - 1 length array. length of string 
    %between spacers when mechanism is at rest.
h_dist = 50; %distance between housing
h_num = 3; % number of housings = number of "links" or segments.
h_radius = 25; % perpendicular distance from center of housing to spine.
h_holes = 8; % numbrer of throughholes per housing. Same as number of sTSMs per segment.

angle_x = pi/10; % angles to rotate each segment by.
angle_y = 0;
angle_z = 0;
angles = [angle_x angle_y angle_z];
% stsm_make_rot_mat(angles)
offset = 0;
housing_vec = housing_structure(h_holes, h_radius, h_dist, offset);
[spine_plot, housing_centers] = stsm_geometric(h_radius,h_dist, h_holes,housing_vec, h_num, angles, 0);
    
figure(1)
plot3(spine_plot(1,:),spine_plot(2,:),spine_plot(3,:));
% axis equal;
grid on;