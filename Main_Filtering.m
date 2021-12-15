% Main for the glove filtering process, using the simulink scheme
% IMU_filtering
clc;
clear all;
close all;

T           = .025;
offset_step = 200;

% see the config.yaml file for this numerical values
beta            = 2;
sample_f        = 50;

max_acc_norm    = 1.45;
min_acc_norm    = 0.85;

gyro_th         = 18; 

t_calibration   = offset_step*T;
t_experiment    = 10;

% n_imus = 4;
% n_orientations = 3;

n_imus          = 17;
n_orientations  = 15;
n_chains        = 5;
n_phalanges     = 4;
n_accelerations = n_chains*n_phalanges;

filter_par_vec  = [beta, sample_f, max_acc_norm, min_acc_norm, gyro_th,...
                    n_imus, n_orientations, n_chains, n_phalanges];

q_init_matrix_1 = ones(1,n_orientations);
q_init_matrix_3 = zeros(3,n_orientations);
q_init_matrix   = [q_init_matrix_1; q_init_matrix_3]; 

q_init_matrix_m   = [q_init_matrix_1; q_init_matrix_3]; 

acc_init_matrix_1 = zeros(2,n_accelerations);
acc_init_matrix_2 = ones(1,n_accelerations);
acc_init_matrix   = [acc_init_matrix_1; acc_init_matrix_2]; 
%acc_init_matrix = min_acc_norm*ones(3,20);

q_off_matrix = zeros(4,n_orientations);

thumb_chain    = [14, 13, 12, 16] + 1;
index_chain    = [11, 10, 9, 15] + 1;
medium_chain   = [8, 7, 6, 15] + 1;
ring_chain     = [5, 4, 3, 15] + 1;
little_chain   = [2, 1, 0, 15] + 1;

chain_id_matrix = [little_chain;
                 ring_chain;
                 medium_chain;
                 index_chain;
                 thumb_chain];
             
%chain_id_matrix = little_chain;             
             
calibration_flag = 0;             

while calibration_flag < 2
    
    t_tot = t_calibration;
    
    if calibration_flag == 0
        
       disp('Beginning Calibration Phase... push a key')
       pause;
       
    end
   
    warning off 
    
    sim('IMU_Filtering');
        
    q_init_matrix = q_matrix.data(:,:,end);
    
    if calibration_flag < 1
        
       disp('Change Hand Orientation and push a key')   
       pause;
       
    end
    
    if calibration_flag == 1
        
       disp('Change Hand Orientation and push a key to begin!')
       pause;
       
    end
    
    calibration_flag = calibration_flag+1;
    
end


q_off_matrix = q_matrix.data(:,:,end);
%q_init_matrix   = [q_init_matrix_1; q_init_matrix_3]; 

t_tot = t_experiment;

disp('Beginning Reconstruction Phase!')

warning off
sim('IMU_Filtering')

disp('Reconstruction Phase Finished, with Success!')

%% Result plotting and visualization
% disp('Plotting results...')
% filter_plot_angles;
% filter_plot_qj;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mm=hand_angle_matrix.data;
n=size(mm);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1:n(3)
%     jj=mm(:,:,i)
%     angle1(i)=jj(1,14);
%     angle2(i)=jj(2,14);
%     angle3(i)=jj(3,14);
% end
% i=1:1:n(3);
% plot(i,angle1)
% hold on;
% plot(i,angle2)
% plot(i,angle3)
% legend({'1','2','3'},'Location','southwest')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
for i=1:1:n(3)
    jj=mm(:,:,i);
    SimulationPlot(jj);
    pause(0.1)
    if i<n(3)
    clf
    end
end

    

