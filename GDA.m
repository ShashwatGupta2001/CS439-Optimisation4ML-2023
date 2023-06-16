clear

eta = 0.05;

x0 = 5.5;
y0 = 5.5;

%%%Tfo choose the loss function, go to the botton of the file.

%Window size
B=20

v =(-B:0.5:B); Y = v'*ones(1,length(v)); X = Y'; Z = value(X,Y);surfc(X,Y,Z-2)
set(gca,'Xlim',[-B,B], 'Ylim', [-B,B],'Zlim', [-30,30])
view(43,40)

%curve_globalcurve_global = animatedline([0,0],[-B,B],[0-0.5,0-0.5],'Color','r','LineWidth',5)

i=0
title(['i = ' num2str(i)], 'FontSize', 30, 'FontName', 'Times','FontWeight', 'normal')

curve1 = animatedline('LineWidth',4)
curve2 = animatedline('LineWidth',4)

%pause

T = 4001
% T = 20

x1 = x0
y1 = y0
z1= value(x1,y1)

%x2 = 0.6
%y2 = 0.6
%z2= x2*y2

hold on

tim=0

for t = 1:T

    %$
    tic
    %$


    i=t-1

    %$
    tim=tim+toc
    %$

   addpoints(curve1,x1(t),y1(t),z1(t))
   %addpoints(curve2,x2(t),y2(t),z2(t))
    title(['i = ' num2str(i)], 'FontSize', 30, 'FontName', 'Times','FontWeight', 'normal')

   drawnow
    
   %#
   % pause(0.4)
   %# 

   % plot(x(t),y(t),z(t)))
   

    %$
    tic
    %$

    

   y1(t+1) = y1(t) + eta*yGrad(x1(t),y1(t));
   x1(t+1) = x1(t) - eta*xGrad(x1(t),y1(t));
   z1(t+1) = value(x1(t),y1(t));

   [x1; y1]
   
   %x2(t+1) = x2(t) - eta*y2(t);
   %y2(t+1) = y2(t) + eta*x2(t);
   %z2(t+1) = x2(t+1)*y2(t+1);

     
    %$
    tim=tim+toc
    %$  
   
   %
%    frame = getframe(h);
%    im = frame2im(frame);
%    [imind,cm] = rgb2ind(im,256);
%    if t==1
%        imwrite(imind,cm,filename,'gif','Loopcount',inf);
%    else
%        imwrite(imind,cm,filename,'gif','Writemode','append');
%    end

    fid = fopen('b_gda_acc.txt', 'w');
    fprintf(fid, '%d,%d ', [x1; y1]);
    fclose(fid);



end
hold off

fprintf('x: %s\n', x1(t));
fprintf('y: %s\n', y1(t));
fprintf('time: %s\n',tim);
fprintf('t: %d\n',t-1);
fprintf('i: %d\n',i);


%%%Input a formular for the loss function and its gradients

%%%Loss function formula
function z = value(x, y)
%%%%F1
%   z = -3*x.^2 - y.^2 +4*x.*y;
%%%%F2
%     z =  3*x.^2 + y.^2 +4*x.*y; 
%%%%F3
%  z= (4*x.^2 - (y - 3*x +0.05*x.^3).^2 - 0.1*y.^4).*exp(-0.01*(x.^2+y.^2));
%%%%F4
%   z=x.*y - 0.003*y.^3;
%%%%F5
%   z=x.^2 + 3*sin(x)*sin(y) - 4*y.^2 - 10*sin(y);
%%%%F6
%   z=10*x.*y;
%%%%F7
%   z=0.5*x.^2 + 10*x.*y + 0.5*y.^2;
%%%%F8
%    z=10*x.*y - y.^2;
%%%%F9
%    z = sin(x+y);
%%%F10
%     z = 0.2*x.*y - cos(y);      
%%%F11
    z = -0.03*x.^2 + 0.2*x.*y - cos(y);
end

%%%formula for x-gradient
function g = xGrad(x, y)
%%%nabla_x F1
%   g = -6*x + 4*y;
%%%nabla_x F2
%    g = 6*x + 4*y;
%%%nabla_x F3
%   g = -0.02*x*(4*x.^2 - (y - 3*x +0.05*x.^3).^2 - 0.1*y.^4).*exp(-0.01*(x.^2+y.^2)) +(8*x-2*(y - 3*x +0.05*x.^3)*(-3+0.15*x.^2)).*exp(-0.01*(x.^2+y.^2));
%%%nabla_x F4
%    g = y;
%%%nabla_x F5
%    g = 2*x + 3*cos(x).*sin(y) ;
%%%nabla_x F6
%    g = 10*y;
%%%nabla_x F7
%    g = x + 10*y;
%%%nabla_x F8
%    g = 10*y;
%%%nabla_x F9
%    g = cos(x+y);
%%%nabla_x F10
%     g = 0.2*y;
%%%nabla_x F11
    g = -0.06*x + 0.2*y;
end

%formula for y-gradient
function g = yGrad(x, y)
%%%nabla_y F1
%   g = -2*y + 4*x;
%%%nabla_y F2
%      g = 2*y + 4*x;
%%%nabla_y F3
%   g = -0.02*y*(4*x.^2 - (y - 3*x +0.05*x.^3).^2 - 0.1*y.^4).*exp(-0.01*(x.^2+y.^2)) + (-2*(y - 3*x +0.05*x.^3) -0.4*y^3)*exp(-0.01*(x.^2+y.^2));
%%%nabla_y F4
%   g = x - y.^2;
%%%nabla_y F5
%   g = 3*sin(x).*cos(y) - 8*y - 10*cos(y);
%%%nabla_y F6
%    g=10*x;
%%%nabla_x F7
%    g = 10*x + y;
%%%nabla_x F8
%    g = 10*x - 2*y;
%%%nabla_x F9
%    g = cos(x+y);
%%%nabla_x F10
%     g = 0.2*x + sin(y);
%%%nabla_x F11
    g = 0.2*x + sin(y);
end