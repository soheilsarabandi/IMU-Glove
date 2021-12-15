%% Null Space Projection

syms q1 q2 q3 q4 ox oy oz o dx dy dz sx sy sz z omx omy omz dq0 dq0x dq0y dq0z

q = [q1 q2 q3 q4].';
o = [0 ox oy oz].';
omega = [ox oy oz].';
d = [0 dx dy dz].';
s = [0 sx sy sz].';
dq_0 = [dq0 dq0x dq0y dq0z].';


%q_dot = 0.5*quatmultiply(q,o)

q_dot = 0.5*[q(1)*o(1) - q(2)*o(2) - q(3)*o(3) - q(4)*o(4);
             q(1)*o(2) + q(2)*o(1) + q(3)*o(4) - q(4)*o(3);
             q(1)*o(3) + q(3)*o(1) + q(4)*o(2) - q(2)*o(4);
             q(1)*o(4) + q(4)*o(1) + q(2)*o(3) - q(3)*o(2)];
         
%q_d = [qd1 qd2 qd3 qd4].';        
         
J = 0.5*[q1 -q2 -q3 -q4; 
         q2 q1 -q4 q3; 
         q3 q4 q1 -q2; 
         q4 -q3 q2 q1];
     
J_p = simplify(pinv(J));

T_q = 0.5*[-q2 -q3 -q4; 
            q1 -q4 q3; 
            q4 q1 -q2; 
            -q3 q2 q1];
        
%J_q = simplify(pinv(T_q));
J_q = J_p(2:4,:);
q_dot1 = T_q*omega;

% om = simplify(inv(J)*q_dot);

fa = [2*dx*(0.5 -q3*q3 -q4*q4) + 2*dy*(q1*q4 + q2*q3) + 2*dz*(q2*q4-q1*q3) - sx; 
      2*dx*(q2*q3 -q1*q4) + 2*dy*(0.5 - q2*q2 - q4*q4) + 2*dz*(q1*q2 - q3*q4) - sy;
      2*dx*(q1*q3 -q2*q4) + 2*dy*(q3*q4 - q1*q2) + 2*dz*(0.5 - q2*q2 -q3*q3) - sz];
  
FA = [2*(0.5 -q3*q3 -q4*q4), 2*(q1*q4 + q2*q3),         2*(q2*q4-q1*q3)         -1 0 0;
      2*(q2*q3 -q1*q4),      2*(0.5 - q2*q2 - q4*q4),   2*(q1*q2 - q3*q4) 0 -1 0;
      2*(q1*q3 -q2*q4),      2*(q3*q4 - q1*q2),         2*(0.5 - q2*q2 -q3*q3)  0 0 -1];  
  
FA2 = [2*(0.5 -q3*q3 -q4*q4), 2*(q1*q4 + q2*q3),         2*(q2*q4-q1*q3);
      2*(q2*q3 -q1*q4),      2*(0.5 - q2*q2 - q4*q4),   2*(q1*q2 - q3*q4);
      2*(q1*q3 -q2*q4),      2*(q3*q4 - q1*q2),         2*(0.5 - q2*q2 -q3*q3)];   

%simplify(fa-FA2*d(2:4)+ s(2:4)) 
  
%simplify(fa-FA*[d(2:4);s(2:4)])  
 
Ja =  [ 2*dy*q4-2*dz*q3,    2*dy*q3+2*dz*q4,            -4*dx*q3+2*dy*q2-2*dz*q1,   -4*dx*q4+2*dy*q1+2*dz*q2;
        -2*dx*q4+2*dz*q2,   2*dx*q3-4*dy*q2+2*dz*q1,    2*dx*q2+2*dz*q4,            -2*dx*q1-4*dy*q4+2*dz*q3;
        2*dx*q3-2*dy*q2,    2*dx*q4-2*dy*q1-4*dz*q2,    2*dx*q1+2*dy*q4-4*dz*q3,    2*dx*q2+2*dy*q3];  
    
JA =  [ 2*dy*q4-2*dz*q3,    2*dy*q3+2*dz*q4,            -4*dx*q3+2*dy*q2-2*dz*q1,   -4*dx*q4+2*dy*q1+2*dz*q2;
        -2*dx*q4+2*dz*q2,   2*dx*q3-4*dy*q2+2*dz*q1,    2*dx*q2+2*dz*q4,            -2*dx*q1-4*dy*q4+2*dz*q3;
        2*dx*q3-2*dy*q2,    2*dx*q4-2*dy*q1-4*dz*q2,    2*dx*q1+2*dy*q4-4*dz*q3,    2*dx*q2+2*dy*q3];      

Nabla = Ja.'*fa;

N = [(2*dx*q4 - 2*dz*q2)*(sy + 2*dx*(q1*q4 - q2*q3) - 2*dz*(q1*q2 + q3*q4) + 2*dy*(q2^2 + q4^2 - 1/2)) - (2*dx*q3 - 2*dy*q2)*(sz - 2*dx*(q1*q3 - q2*q4) + 2*dy*(q1*q2 - q3*q4) + 2*dz*(q2^2 + q3^2 - 1/2)) - (2*dy*q4 - 2*dz*q3)*(sx - 2*dy*(q1*q4 + q2*q3) + 2*dz*(q1*q3 - q2*q4) + 2*dx*(q3^2 + q4^2 - 1/2));
    (2*dy*q1 - 2*dx*q4 + 4*dz*q2)*(sz - 2*dx*(q1*q3 - q2*q4) + 2*dy*(q1*q2 - q3*q4) + 2*dz*(q2^2 + q3^2 - 1/2)) - (2*dx*q3 - 4*dy*q2 + 2*dz*q1)*(sy + 2*dx*(q1*q4 - q2*q3) - 2*dz*(q1*q2 + q3*q4) + 2*dy*(q2^2 + q4^2 - 1/2)) - (2*dy*q3 + 2*dz*q4)*(sx - 2*dy*(q1*q4 + q2*q3) + 2*dz*(q1*q3 - q2*q4) + 2*dx*(q3^2 + q4^2 - 1/2));
    (4*dx*q3 - 2*dy*q2 + 2*dz*q1)*(sx - 2*dy*(q1*q4 + q2*q3) + 2*dz*(q1*q3 - q2*q4) + 2*dx*(q3^2 + q4^2 - 1/2)) - (2*dx*q2 + 2*dz*q4)*(sy + 2*dx*(q1*q4 - q2*q3) - 2*dz*(q1*q2 + q3*q4) + 2*dy*(q2^2 + q4^2 - 1/2)) - (2*dx*q1 + 2*dy*q4 - 4*dz*q3)*(sz - 2*dx*(q1*q3 - q2*q4) + 2*dy*(q1*q2 - q3*q4) + 2*dz*(q2^2 + q3^2 - 1/2));
    (2*dx*q1 + 4*dy*q4 - 2*dz*q3)*(sy + 2*dx*(q1*q4 - q2*q3) - 2*dz*(q1*q2 + q3*q4) + 2*dy*(q2^2 + q4^2 - 1/2)) - (2*dy*q1 - 4*dx*q4 + 2*dz*q2)*(sx - 2*dy*(q1*q4 + q2*q3) + 2*dz*(q1*q3 - q2*q4) + 2*dx*(q3^2 + q4^2 - 1/2)) - (2*dx*q2 + 2*dy*q3)*(sz - 2*dx*(q1*q3 - q2*q4) + 2*dy*(q1*q2 - q3*q4) + 2*dz*(q2^2 + q3^2 - 1/2))];

D = [0 -dx -dy -dz; dx 0 -dz dy; dy dz 0 -dx; dz -dy dx 0];
Q = [q1 q2 q3 q4; -q2 q1 q4 -q3; -q3 -q4 q1 q2; -q4 q3 -q2 q1];

%simplify(D*q - quatmol(d,q))

align = quatmol(quat_conj(q),quatmol(d,q));
align = simplify(align);

align2 = simplify(quatmol(quat_conj(q),quatmol(d,q)) - s);

% d = [0 0 dy dz];
% align2x = simplify(quatmol(quat_conj(q),quatmol(d,q)) - s);
% d = [0 dx 0 dz];
% align2y = simplify(quatmol(quat_conj(q),quatmol(d,q)) - s);
% d = [0 dx dy 0];
% align2z = simplify(quatmol(quat_conj(q),quatmol(d,q)) - s);

Js = [  jacobian(fa(1),[q1,q2,q3,q4]);
        jacobian(fa(2),[q1,q2,q3,q4]);
        jacobian(fa(3),[q1,q2,q3,q4])];
   
 
% simplify(quatmol(d,q))
% simplify(quatmol(q,d))
% simplify(quatmol(quat_conj(q),d))
simplify(align-Q*(D*q))
simplify(align-(Q*D)*q)

% A = Q*D;
% rank(A)
% Ai = simplify(inv(A));
% %Ap = simplify(pinv(A));
% 
% A_p = [  (dx*q2 + dy*q3 + dz*q4)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)),  (dx*q1 + dy*q4 - dz*q3)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)),  (dy*q1 - dx*q4 + dz*q2)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)),  (dx*q3 - dy*q2 + dz*q1)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2));
%         -(dx*q1 + dy*q4 - dz*q3)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)),  (dx*q2 + dy*q3 + dz*q4)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)),  (dx*q3 - dy*q2 + dz*q1)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)), -(dy*q1 - dx*q4 + dz*q2)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2));
%         -(dy*q1 - dx*q4 + dz*q2)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)), -(dx*q3 - dy*q2 + dz*q1)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)),  (dx*q2 + dy*q3 + dz*q4)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)),  (dx*q1 + dy*q4 - dz*q3)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2));
%         -(dx*q3 - dy*q2 + dz*q1)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)),  (dy*q1 - dx*q4 + dz*q2)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)), -(dx*q1 + dy*q4 - dz*q3)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2)),  (dx*q2 + dy*q3 + dz*q4)/((dx^2 + dy^2 + dz^2)*(q1^2 + q2^2 + q3^2 + q4^2))];

% q_corr = simplify(A_p*s.')
% 
% simplify(A_p-Ai)

q_dot_o = simplify(T_q*omega+(eye(4) - T_q*J_q)*dq_0);

%% Projection along modelled joint axis 1

syms qj1 qj2 qj3 qj4 ql1 ql2 ql3 ql4  

qj = [qj1 qj2 qj3 qj4].';   %% qJ, completo
% qjx = [qj1 qj2 0 0].';
% qjy = [qj1 0 qj3 0].';
% qjz = [qj1 0 0 qj4].';
ql = [ql1 ql2 ql3 ql4].';  %% qL_old, q is qL

f = simplify(quatmol(quat_conj(qj),quatmol(ql,qj)) - q);

% fx = simplify(quatmol(quat_conj(qjx),quatmol(ql,qjx)) - q);
% fy = simplify(quatmol(quat_conj(qjy),quatmol(ql,qjy)) - q);
% fz = simplify(quatmol(quat_conj(qjz),quatmol(ql,qjz)) - q);

J = [  jacobian(f(1),[qj1 qj2 qj3 qj4]);
       jacobian(f(2),[qj1 qj2 qj3 qj4]);
       jacobian(f(3),[qj1 qj2 qj3 qj4]);
       jacobian(f(4),[qj1 qj2 qj3 qj4])];

J = simplify(J);

Jx = subs(J,[qj3,qj4],[0,0]);
Jy = subs(J,[qj2,qj4],[0,0]);
Jz = subs(J,[qj2,qj3],[0,0]);

fx = subs(f,[qj3,qj4],[0,0]);
fy = subs(f,[qj2,qj4],[0,0]);
fz = subs(f,[qj2,qj3],[0,0]);

Naplax = simplify(Jx.'*fx);
Naplay = simplify(Jy.'*fy);
Naplaz = simplify(Jz.'*fz);

%% Projection along modelled joint axis 1

syms qj1 qj2 qj3 qj4 ql1 ql2 ql3 ql4  

qj  = [qj1 qj2 qj3 qj4].';   %% qJ, completo
qj  = [qj1 qj2 0 0].';   %% qJ, completo
% qjx = [qj1 qj2 0 0].';
% qjy = [qj1 0 qj3 0].';
% qjz = [qj1 0 0 qj4].';
ql  = [ql1 ql2 ql3 ql4].';  %% qL
q   = [q1 q2 q3 q4].';  %% qL_old

f = simplify(quatmol(ql,quat_conj(q)) - qj);

% fx = simplify(quatmol(q,quat_conj(q)) - qjx);
% fy = simplify(quatmol(q,quat_conj(q)) - qjy);
% fz = simplify(quatmol(q,quat_conj(q)) - qjz);

J = [  jacobian(f(1),[qj1 qj2 qj3 qj4]);
       jacobian(f(2),[qj1 qj2 qj3 qj4]);
       jacobian(f(3),[qj1 qj2 qj3 qj4]);
       jacobian(f(4),[qj1 qj2 qj3 qj4])];
   
   J = [  jacobian(f(1),[qj1 qj2]);
       jacobian(f(2),[qj1 qj2]);
       jacobian(f(3),[qj1 qj2]);
       jacobian(f(4),[qj1 qj2])];

J = simplify(J);

% Jx = subs(J,[qj3,qj4],[0,0]);
% Jy = subs(J,[qj2,qj4],[0,0]);
% Jz = subs(J,[qj2,qj3],[0,0]);
% 
% fx = subs(f,[qj3,qj4],[0,0]);
% fy = subs(f,[qj2,qj4],[0,0]);
% fz = subs(f,[qj2,qj3],[0,0]);
% 
% Naplax = simplify(Jx.'*f);
% Naplay = simplify(Jy.'*f);
% Naplaz = simplify(Jz.'*f);

Napla = simplify(J.'*f);

%% 

syms theta

qJ_star = [cos(theta)/2; sin(theta)/2; 0; 0];

qP = simplify(quatmol(qJ_star,quat_conj(qj)));