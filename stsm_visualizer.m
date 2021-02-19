clc;close all;clear all;
% stsm singlelink visualizer.
angle = [0:0.1:pi];
radius = 25/2;
distance = 25;
[forces,force_vec, geometry] = stsm_axial_tension_to_torque(10, radius*2, 1,distance, angle);

% plot(angle,forces(2,:))
% plot(angle,forces(3,:))

a = [0:0.01:2*pi];
x = radius * cos(a);
z = radius * sin(a);
y = zeros(size(x));

x_plt = radius * cos(angle);
z_plt = radius * sin(angle);
y_plt = zeros(size(angle));

i = 1;
dir = 1;
figure;
% for i = 1:length(geometry)
pause(2);
while true
    subplot(1,2,1)
    ax=gca;
    if i >= length(geometry)
        dir = 0;
    elseif i == 0
        i = 1;
        dir = 1;
    end
%     plot anchor spacer
    plot3(x,y,z,'linewidth',3);
    hold(ax,'on');
    set(gca, 'fontsize', 20);
    title("Mechanism Animation");
%     plot moving spacer
    plot3(x,y+geometry(2,i), z,'linewidth',3);
%     plot string
    string = [x(1) x_plt(i); y(1) y_plt(i)+geometry(2,i); z(1) z_plt(i)];
    plot3(string(1,:),string(2,:),string(3,:),'-o',...
                            'MarkerSize', 10, ....
                            'MarkerFaceColor',[0.5,0.5,0.5],...
                            'linewidth', 3)
%   plot force components
%     vec_rad = string(:,2) - [0; geometry(2,i) ;0];
%     vec_rad = vec_rad/norm(vec_rad,2);
%     vec_ax = [0;-1;0];
%     vec_tan = cross(vec_rad, vec_ax);
%     vec = [vec_tan vec_ax vec_rad];
%     point = [string(:,2) string(:,2) string(:,2)];
% %     force_vec = vec .* forces(2:4, i) + point;
    force_comp = force_vec(:,i,:);
    
    force_mat = [forces(2,i) 0 0;
                0 forces(3,i) 0;
                0 0 forces(4,i)];
    f = reshape(force_comp,[3,3])*force_mat;
    f = f + [string(:,2) string(:,2) string(:,2)];
    plot3([string(1,2) f(1,1)],[string(2,2) f(2,1)],[string(3,2) f(3,1)], 'linewidth',3);
    plot3([string(1,2) f(1,2)],[string(2,2) f(2,2)],[string(3,2) f(3,2)], 'linewidth',3);
    plot3([string(1,2) f(1,3)],[string(2,2) f(2,3)],[string(3,2) f(3,3)], 'linewidth',3);
    
    grid on;
    axis([-25 25 -25 25 -25 25]);
    drawnow
    pause(0.025)
    hold off;
    
    subplot(1,2,2)
    plot(angle(i),forces(2,i), '-o', ...
                            'MarkerSize', 10, ....
                            'MarkerFaceColor',[0.5,0.5,0.5])
    hold on;
    title("Angle vs total Tangential Force");
    xlabel("Angle(rad)");
    ylabel("Total Tangential Force");
    set(gca, 'fontsize', 20);
    plot(angle,forces(2,:),'r', 'linewidth', 3)
    plot(angle,forces(3,:),'b', 'linewidth', 3)
    
    grid on;
    hold off;
    drawnow
    pause(0.015)
    
    
    if dir == 1
        i = i+1;
    else
        i = i-1;
    end
end