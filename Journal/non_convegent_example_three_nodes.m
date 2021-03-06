clear all;
clc;

vS=[1;exp(-j*2*pi/3);exp(j*2*pi/3)];

sL1a=0.7+1.5i;
sL1b=0.8+1.5i;
sL1c=0.8+2.5i;
sL1=[sL1a;sL1b;sL1c];

sL2a=0.6+2.5i;
sL2b=0.6+0.5i;
sL2c=0.3+0.5i;
sL2=[sL2a;sL2b;sL2c];

sL=0.12*[sL1;sL2];

y1S=0.077-5.33i;
y12=0.056-8.66i;



Y1S=[y1S, 0.01-0.09i, 0.02-0.08i;
       0.01-0.09i, 0.087-8i, 0.03-0.07i;
       0.02-0.08i, 0.03-0.07i, 0.07-1.5i];
   
Y12=[y12, 0 0.02-0.07i;
       0, 0.02-4.8i, 0.03-0.05i;
       0.02-0.07i, 0.03-0.05i, 0.03-3.8i];   
   
% Y1S=y1S*eye(3); 
% Y12=y12*eye(3); 




Y=[Y1S+Y12 -Y12; -Y12 Y12]; 
Y_NS=[-Y1S; zeros(3,3)]; 


maxIt=41;

vIterations=zeros(6,maxIt); 

Z=inv(Y); 
w=-Z*Y_NS*vS;

vIterations(:,1)=w;
err1=zeros(maxIt,1);

for it=2:maxIt
    
    
    fv=-conj(sL./vIterations(:,it-1));
    err1(it-1)= max(abs(fv-Y*vIterations(:,it-1)-Y_NS*vS)); 
    str=[num2str(err1(it-1)), '\n']; 
    fprintf(str);
    vIterations(:,it)=  (Y)\ (fv-Y_NS*vS);
    
    
end
vSol=vIterations(:,end); 
fv=-conj(sL./vSol);
err1(end)=max(abs(fv-Y*vSol-Y_NS*vS)); 



CPQ=max( sum( abs(Z*diag(sL)*diag(1./w)),2)); 
K=1./min(abs(w));

C2PQ=max(sum( abs( Z*diag(sL)*diag(1./w)*diag(1./w)),2)); 
