clc;close all;clear all;
% stsm singlelink visualizer.
angle = [0:0.1:pi];
radius = 25/2;
distance = 25;
[forces, geometry] = stsm_axial_tension_to_torque(10, radius*2, 1,distance, angle);

% plot(angle,forces(2,:))
% plot(angle,forces(3,:))

a = [0:0.01:2*pi];
x = radius * cos(a);
z = radius * sin(a);
y = zeros(size(x));

i = 1;
dir = 1;
figure;
% for i = 1:length(geometry)
while true
    subplot(1,2,1)
    ax=gca;
    if i >= length(geometry)
        dir = 0;
    elseif i == 0
        i = 1;
        dir = 1;
    end
    plot3(x,y,z,'linewidth',3);
    hold(ax,'on');
    set(gca, 'fontsize', 20);
    plot3(x,y+geometry(2,i), z,'linewidth',3);
    grid on;
    axis([-25 25 -25 25 -25 25]);
    drawnow
    pause(0.01)
    hold off;
    
    subplot(1,2,2)
    plot(angle(i),forces(2,i), '-o', ...
                            'MarkerSize', 10, ....
                            'MarkerFaceColor',[0.5,0.5,0.5])
    hold on;
    set(gca, 'fontsize', 20);
    plot(angle,forces(2,:),'r', 'linewidth', 3)
    plot(angle,forces(3,:),'b', 'linewidth', 3)
    
    grid on;
    hold off;
    drawnow
    pause(0.01)
    
    
    if dir == 1
        i = i+1;
    else
        i = i-1;
    end
end