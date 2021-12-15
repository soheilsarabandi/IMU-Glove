function angle_matrix  = Filtering_Process(imu_matrix, filter_param_struct)

% IMU chain definitions
imu_chain_matrix = glove_start(imu_matrix, filter_param_struct);

chain_struct{1}.vec = filter_param_struct.little_chain;
chain_struct{2}.vec = filter_param_struct.ring_chain;
chain_struct{3}.vec = filter_param_struct.medium_chain;
chain_struct{4}.vec = filter_param_struct.index_chain;
chain_struct{5}.vec = filter_param_struct.thumb_chain;

for i = 1:5
    for k = 1:lenght(chain_struct{i}.vec) 
        for j = 1:17
            if j == chain_struct{i}.vec(k)
                imu_chain_struct{i}.imu(k) = imu_matrix(:,j);
            end
        end
    end
end

% Glove calibration procedure
%glove_offset;

% RPY angle computation from IMU readings via the Madgwick filter
%angle_matrix = glove_compute_angles(imu_chain_matrix, filter_param_struct);

angle_matrix = imu_chain_struct;