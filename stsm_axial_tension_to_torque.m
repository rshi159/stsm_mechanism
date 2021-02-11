function [forces, geometry] = stsm_axial_tension_to_torque(ax_tension, s_diam, s_num,s_len_rest, angle)
    s_rad = s_diam/2;
    s_dist = sqrt(s_len_rest.^2 - 2*s_rad^2.*(1-cos(angle)));
    % from the axial tension and the angle of rotation, we can get the 
    % radial force and the tangential force, after computing the tension
    % in the string. We can assume that net radial force is zero due to
    % evenly spaced holes. Tangential force is the sum of the tangential
    % forces acting on each string in the sTSM, so we can model it as
    % all of the tangential force acting on a single string.
    
    % Calculate the tension in the strings between the spacers.
    
    % see figure for c. makes a right triangle with l and d.
    c = sqrt(2*s_rad^2.*(1-cos(angle)));
    % length of string between spacers
    l = s_len_rest;
    % Distance between spacers
    d = sqrt(l.^2-c.^2);
    
    % decompose c into radial and tangential components.
    alpha = (pi - angle)/2;
    c_rad = c.*cos(alpha);
    c_tan = c.*sin(alpha);
    
    % we are given the axial tension in the stsm mechanism.
    f_ax = ones(size(angle))*ax_tension;
    geom_to_force = f_ax ./ d;
    
    f_total = geom_to_force .* l;
    % the total force acting on the spacer in the radial direction.
    % divide by number of strings to get the axial force on a single string
    % currently not used.
    f_radial = geom_to_force .* c_rad;
    % sum of force acting tangent to the spacer. Multiply by the radius to
    % get the torque.
    f_tan = geom_to_force .* c_tan;
    forces = [f_total; f_tan; f_ax; f_radial];
    geometry = [ones(size(d))*l; d; c];
    
end