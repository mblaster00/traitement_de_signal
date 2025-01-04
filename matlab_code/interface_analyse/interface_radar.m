clear;   
         % effacr les donnees
clc;       
delete(instrfind); % supprimer les ports series
figure;    % generer une figure
for theta=0:1:180  % definir un demi cercle
for i=1:1:100       % definir une distance (rayon du demi cercle)
    x1(i)=i*cos(theta*3.14/180);   % abscisse d'un point dans le demi cercle
    y1(i)=i*sin(theta*3.14/180);    % ordonne d'un point dans le demi cercle
end
plot(0,0,x1,y1,'color','k','LineWidth',10); % plot l'arriere plan en noir
hold on;
end
xlabel('Distance (cm)'); % dooner la distance en cm
for R=10:10:100
k=1;
for i=0:1:180
    x(k)=R*cos(i*3.14/180);
    y(k)=R*sin(i*3.14/180);
k=k+1;
end
plot(x,y,'color','g','LineWidth',1); %ligne droite delimiteur 
hold on;
end
for theta=0:30:180
for i=1:1:100
    x11(i)=i*cos(theta*3.14/180);
    y11(i)=i*sin(theta*3.14/180);
end
plot(0,0,x11,y11,'color','g','LineWidth',1); % ligne curviligne delimiteur
hold on;
end
labels=cellstr(num2str([0:30:180]')); % label sur chaque 30 degres
% text sur les points
text([100*cos(0);100*cos(3.18/6);100*cos(2*3.18/6);100*cos(3*3.18/6);100*cos(4*3.18/6);100*cos(5*3.18/6);100*cos(3.18)],[100*sin(0);100*sin(3.18/6);100*sin(2*3.18/6);100*sin(3*3.18/6);100*sin(4*3.18/6);100*sin(5*3.18/6);100*sin(3.18)],labels,'BackgroundColor',[.7 .9 .7]);

s=serial('COM4'); % se connecter au port
s.BaudRate=9600;  % taux d'echantillonage du signal(taux de modulation)
fopen(s); % ouvrir le fichier generer par le serial 
while(1)
if (fscanf(s,'%f')=='.')==[1 0 0]
    angle=fscanf(s,'%f');
    distance=fscanf(s,'%f');
 elseif (fscanf(s,'%f')=='.')==[1 0 0]
    angle=fscanf(s,'%f');
    distance=fscanf(s,'%f');
else
    fscanf(s,'%f');
    angle=fscanf(s,'%f');
    distance=fscanf(s,'%f');
end
if distance>100
distance=100;
end
x3=distance*cos(angle*3.14/180);
y3=distance*sin(angle*3.14/180);
x4=100*cos(angle*3.14/180);
y4=100*sin(angle*3.14/180);
x5=distance*cos((angle+2)*3.14/180);
y5=distance*sin((angle+2)*3.14/180);
x6=100*cos((angle+2)*3.14/180);
y6=100*sin((angle+2)*3.14/180);
x7=distance*cos((angle-2)*3.14/180);
y7=distance*sin((angle-2)*3.14/180);
x8=100*cos((angle-2)*3.14/180);
y8=100*sin((angle-2)*3.14/180);
x9=distance*cos((angle+3)*3.14/180);
y9=distance*sin((angle+3)*3.14/180);
x10=100*cos((angle+3)*3.14/180);
y10=100*sin((angle+3)*3.14/180);
x11=distance*cos((angle-3)*3.14/180);
y11=distance*sin((angle-3)*3.14/180);
x12=100*cos((angle-3)*3.14/180);
y12=100*sin((angle-3)*3.14/180);
X3=distance*cos(angle*3.14/180);
Y3=distance*sin(angle*3.14/180);
X4=100*cos(angle*3.14/180);
Y4=100*sin(angle*3.14/180);
X5=0;
Y5=0;
X6=100*cos((angle+2)*3.14/180);
Y6=100*sin((angle+2)*3.14/180);
X7=0;
Y7=0;
X8=100*cos((angle-2)*3.14/180);
Y8=100*sin((angle-2)*3.14/180);
X9=0;
Y9=0;
X10=100*cos((angle+3)*3.14/180);
Y10=100*sin((angle+3)*3.14/180);
X11=0;
Y11=0;
X12=100*cos((angle-3)*3.14/180);
Y12=100*sin((angle-3)*3.14/180);
hold on;
n=plot([X3,X4,X5,X6,X7,X8,X9,X10,X11,X12],[Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12],'color','y','LineWidth',20);
if distance < 100
    m=plot([x3,x4,x5,x6,x7,x8,x9,x10,x11,x12],[y3,y4,y5,y6,y7,y8,y9,y10,y11,y12],'color','r','LineWidth',20);
end
drawnow;
delete(m);
delete(n);
end  
fclose(s);


