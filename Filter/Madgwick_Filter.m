function [q_out,aN_old_out]  = Madgwick_Filter(input,aN_old)

   n_IMU        = 15;
   %n_input      = n_IMU*10;
   acc_in       = zeros(3,n_IMU);
   gyro_in      = zeros(3,n_IMU);
   %q            = zeros(n_IMU,4);
   %q_out        = zeros(1,4*n_IMU);
   q_out_matrix = zeros(n_IMU,4);
   %G            = [0 0 0 1];
   Gyro_Th      = 18; 
   beta         = 1;   
   dt           = 1/50;  %
   acc_th_min   = 0.7;
   acc_th_max   = 1.3;
   
   aN_old = reshape(aN_old,[3,n_IMU]); 
   
   for j=0:n_IMU-1
            acc_in(:,j+1) = [input(1+6*j); input(2+6*j); input(3+6*j)]; 
            gyro_in(:,j+1) = [input(4+6*j); input(5+6*j); input(6+6*j)]; 
   end
   
   q = reshape(input(6*n_IMU+1:10*n_IMU),[4,n_IMU]); 
   q = q'; 
   
   gN = [zeros(1,n_IMU); gyro_in]; 
    
   for j = 1:n_IMU
       for i = 2:4
           if abs(gN(i,j)) < Gyro_Th
           gN(i,j) = 0.0;
           end
       end
   end 
    
   gN = gN.* (pi/180);
        
   aN =  acc_in; 
   
   for j=1:n_IMU
        gN_singolo = gN(:,j)'; 
        aN_norm = norm(aN(:,j));
        
        if ((aN_norm < acc_th_min) || (aN_norm>acc_th_max))
            aN(:,j) = aN_old(:,j);
        end 

        aN(:,j) = aN(:,j)/norm(aN(:,j)); 

        q1 = q(j,1); 
        q2 = q(j,2);
        q3 = q(j,3); 
        q4 = q(j,4);

        q_singolo = [q1 q2 q3 q4]; 
        
        dx     = aN(1,j); 
        dy     = aN(2,j); 
        dz     = aN(3,j);  
        
        if j > 1 
            sx     = aN(1,j-1); 
            sy     = aN(2,j-1); 
            sz     = aN(3,j-1); 
        else 
            sx     = 0; 
            sy     = 0; 
            sz     = 1; 
        end
        
        
        fa =  [ 2*dx*(0.5 -q3*q3 -q4*q4) + 2*dy*(q1*q4 + q2*q3) + 2*dz*(q2*q4-q1*q3) - sx; 
                2*dx*(q2*q3 -q1*q4) + 2*dy*(0.5 - q2*q2 - q4*q4) + 2*dz*(q1*q2 + q3*q4) - sy;
                2*dx*(q1*q3 -q2*q4) + 2*dy*(q3*q4 - q1*q2) + 2*dz*(0.5 - q2*q2 -q3*q3) - sz]; 

        Ja = [ 2*dy*q4-2*dz*q3,    2*dy*q3+2*dz*q4,            -4*dx*q3+2*dy*q2-2*dz*q1,   -4*dx*q4+2*dy*q1+2*dz*q2;
               -2*dx*q4+2*dz*q2,   2*dx*q3-4*dy*q2+2*dz*q1,    2*dx*q2+2*dz*q4,            -2*dx*q1-4*dy*q4+2*dz*q3;
               2*dx*q3-2*dy*q2,    2*dx*q4-2*dy*q1-4*dz*q2,    2*dx*q1+2*dy*q4-4*dz*q3,    2*dx*q2+2*dy*q3];

        Napla = Ja' * fa;
             
        qdot = 0.5 * quatmultiply(q_singolo,gN_singolo) - (beta * Napla');
    
        quat = q_singolo + qdot * dt;
        q_singolo = quat/norm(quat);
        
        q_out_matrix(j,:) = q_singolo;
        
   end
    
   q_out = reshape(q_out_matrice',[1,4*n_IMU]); 
   
   aN_old_out = reshape(aN,[1,3*n_IMU]); 
        
end