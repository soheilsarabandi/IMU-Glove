function [qL, aP, aN]  = my_Madgwick_Filter(imu_sensor, imu_world, qL_old, ...
                                            aP_old, aN_old, filter_par_vec)
beta        = filter_par_vec(1);
sample_f    = filter_par_vec(2);
                                                        
% Retrieving accelerometer acquisition from both imus 
max_acc_norm = filter_par_vec(3);
min_acc_norm = filter_par_vec(4);

imu_world_id = imu_world(1);

aP = zeros(3,1);
aN = zeros(3,1);

aP(1) = imu_sensor(2);
aP(2) = imu_sensor(3);
aP(3) = imu_sensor(4);

% Normalizing accelerometer acquisition
if imu_world_id == 18
    aN(1) = 0;
    aN(2) = 0;
    aN(3) = -1;
else
    aN(1) = imu_world(2);
    aN(2) = imu_world(3);
    aN(3) = imu_world(4);
end

% if norm(aP,2) <= min_acc_norm || norm(aP,2) > max_acc_norm
%     aP = aP_old;
% else
%     aP = aP/norm(aP,2);
% end
% 
% if norm(aN,2) <= min_acc_norm || norm(aN,2) > max_acc_norm
%     aN = aN_old;
% else
%     aN = aN/norm(aN,2);
% end

if norm(aP) < min_acc_norm 
		aP(1) = aP_old(1); 
		aP(2) = aP_old(2); 
		aP(3) = aP_old(3); 
end

if norm(aN) < min_acc_norm 
    aN(1) = aN_old(1); 
    aN(2) = aN_old(2); 
    aN(3) = aN_old(3);
end

if norm(aP) > max_acc_norm 
    aP(1) = aP_old(1); 
    aP(2) = aP_old(2); 
    aP(3) = aP_old(3); 
end	

if  norm(aN) > max_acc_norm 
    aN(1) = aN_old(1); 
    aN(2) = aN_old(2); 
    aN(3) = aN_old(3);
end	

aP = aP/norm(aP);
aN = aN/norm(aN);

% Retrieving gyro acquisition from both imus and defining the gyro
% measurement quaternion

q_gP = [0; imu_sensor(5); imu_sensor(6); imu_sensor(7)];

if imu_world_id == 18
    q_gN = [0; 0; 0; 0];
else
    q_gN = [0; imu_world(5); imu_world(6); imu_world(7)];
end

% Conversion in radians (gyro readings are given in angles)
q_gN = q_gN*pi/180;
q_gP = q_gP*pi/180;

% Angular velocity quaternion update (q_omega)
q_g     = quatmol(quatmol(qL_old, q_gP), quat_conj(qL_old)) - q_gN;
q_omega = 0.5*quatmol(qL_old, q_g);

% Correction quaternion update (q_epsilon)
q1 = qL_old(1);  
q2 = qL_old(2); 
q3 = qL_old(3); 
q4 = qL_old(4);
	
dx = aN(1); 
dy = aN(2); 
dz = aN(3); 
	
sx = aP(1); 
sy = aP(2); 
sz = aP(3); 
	
fa =    [2*dx*(0.5 - q3*q3 - q4*q4) + 2*dy*(q1*q4 + q2*q3) + 2*dz*(q2*q4 - q1*q3) - sx; 
        2*dx*(q2*q3 - q1*q4) + 2*dy*(0.5 - q2*q2 - q4*q4) + 2*dz*(q1*q2 + q3*q4) - sy;
        2*dx*(q1*q3 + q2*q4) + 2*dy*(q3*q4 - q1*q2) + 2*dz*(0.5 - q2*q2 - q3*q3) - sz]; 

Ja =    [2*dy*q4 - 2*dz*q3,   2*dy*q3 + 2*dz*q4,            -4*dx*q3 + 2*dy*q2 - 2*dz*q1,   -4*dx*q4 + 2*dy*q1 + 2*dz*q2;
		-2*dx*q4 + 2*dz*q2,   2*dx*q3 - 4*dy*q2 + 2*dz*q1,  2*dx*q2 + 2*dz*q4,              -2*dx*q1 - 4*dy*q4 + 2*dz*q3;
		2*dx*q3 - 2*dy*q2,    2*dx*q4 - 2*dy*q1 - 4*dz*q2,  2*dx*q1 + 2*dy*q4 - 4*dz*q3,    2*dx*q2 + 2*dy*q3];

Napla       = Ja'*fa;

q_epsilon   = beta*Napla;

% Actual quaternion estimate 
qdot    = q_omega - q_epsilon;
qL      = qL_old + qdot/sample_f;

qL      = qL/norm(qL);

end