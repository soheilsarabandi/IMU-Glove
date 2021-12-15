% Joint quaternion_j (considering the offset correction) Plots from both 
% filters (original and modified version)


%% Data retrieving from simulink

% Little quaternion_j column index    -> inner 3, middle 2, outer 1
% Ring quaternion_j column index      -> inner 6, middle 5, outer 4
% Medium quaternion_j column index    -> inner 9, middle 8, outer 7
% Index quaternion_j column index     -> inner 12, middle 11, outer 10
% Thumb quaternion_j column index     -> inner 15, middle 14, outer 13

for i = 1:n_filter
    
    if i == 1
        
        quaternion_j_matrix_tmp = qj_matrix.data;
        
        for j = n_phalanges:-1:1
            
            qj_little_matrix(1+4*(j-1):4+4*(j-1),:) = ... 
                                    [   quaternion_j_matrix_tmp(1,j,:);
                                        quaternion_j_matrix_tmp(2,j,:);
                                        quaternion_j_matrix_tmp(3,j,:);
                                        quaternion_j_matrix_tmp(4,j,:)];
                                    
            qj_ring_matrix(1+4*(j-1):4+4*(j-1),:) = ...
                                    [   quaternion_j_matrix_tmp(1,j+3,:);
                                        quaternion_j_matrix_tmp(2,j+3,:);
                                        quaternion_j_matrix_tmp(3,j+3,:);
                                        quaternion_j_matrix_tmp(4,j+3,:)];
                           
            qj_medium_matrix(1+4*(j-1):4+4*(j-1),:) = ...
                                    [   quaternion_j_matrix_tmp(1,j+6,:);
                                        quaternion_j_matrix_tmp(2,j+6,:);
                                        quaternion_j_matrix_tmp(3,j+6,:);
                                        quaternion_j_matrix_tmp(4,j+6,:)];
                                    
            qj_index_matrix(1+4*(j-1):4+4*(j-1),:) = ...
                                    [   quaternion_j_matrix_tmp(1,j+9,:);
                                        quaternion_j_matrix_tmp(2,j+9,:);
                                        quaternion_j_matrix_tmp(3,j+9,:);
                                        quaternion_j_matrix_tmp(4,j+9,:)];
                                    
            qj_thumb_matrix(1+4*(j-1):4+4*(j-1),:) = ...
                                    [   quaternion_j_matrix_tmp(1,j+12,:);
                                        quaternion_j_matrix_tmp(2,j+12,:);
                                        quaternion_j_matrix_tmp(3,j+12,:);
                                        quaternion_j_matrix_tmp(4,j+12,:)];                                                                                                        
        end
    end
    
    if i == 2
        
        quaternion_j_matrix_tmp = qj_matrix_m.data;
        
        for j = n_phalanges:-1:1
            
             qj_little_matrix_m(1+4*(j-1):4+4*(j-1),:) = ... 
                                    [   quaternion_j_matrix_tmp(1,j,:);
                                        quaternion_j_matrix_tmp(2,j,:);
                                        quaternion_j_matrix_tmp(3,j,:);
                                        quaternion_j_matrix_tmp(4,j,:)];
                                    
            qj_ring_matrix_m(1+4*(j-1):4+4*(j-1),:) = ...
                                    [   quaternion_j_matrix_tmp(1,j+3,:);
                                        quaternion_j_matrix_tmp(2,j+3,:);
                                        quaternion_j_matrix_tmp(3,j+3,:);
                                        quaternion_j_matrix_tmp(4,j+3,:)];
                           
            qj_medium_matrix_m(1+4*(j-1):4+4*(j-1),:) = ...
                                    [   quaternion_j_matrix_tmp(1,j+6,:);
                                        quaternion_j_matrix_tmp(2,j+6,:);
                                        quaternion_j_matrix_tmp(3,j+6,:);
                                        quaternion_j_matrix_tmp(4,j+6,:)];
                                    
            qj_index_matrix_m(1+4*(j-1):4+4*(j-1),:) = ...
                                    [   quaternion_j_matrix_tmp(1,j+9,:);
                                        quaternion_j_matrix_tmp(2,j+9,:);
                                        quaternion_j_matrix_tmp(3,j+9,:);
                                        quaternion_j_matrix_tmp(4,j+9,:)];
                                    
            qj_thumb_matrix_m(1+4*(j-1):4+4*(j-1),:) = ...
                                    [   quaternion_j_matrix_tmp(1,j+12,:);
                                        quaternion_j_matrix_tmp(2,j+12,:);
                                        quaternion_j_matrix_tmp(3,j+12,:);
                                        quaternion_j_matrix_tmp(4,j+12,:)];
                                    
        end
    end
end

%% Joint quaternion_j Plotting for each phalanx and each filtering strategy                   
                    
for i = 1:n_chains

    figure

    for k = 1:n_filter

        switch k
            case 1
                st1 = 'Or. Fil., ';
            case 2
                st1 = 'Mod. Fil., ';
        end
        
        switch true
            case i == 1 && k == 1
                st2 = 'Thumb '; matrix_to_plot = qj_thumb_matrix;
            case i == 2 && k == 1
                st2 = 'Ring '; matrix_to_plot = qj_ring_matrix;
            case i == 3 && k == 1
                st2 = 'Medium '; matrix_to_plot = qj_medium_matrix;
            case i == 4 && k == 1
                st2 = 'Index '; matrix_to_plot = qj_index_matrix;
            case i == 5 && k == 1
                st2 = 'Little '; matrix_to_plot = qj_little_matrix;

            case i == 1 && k == 2
                st2 = 'Thumb '; matrix_to_plot = qj_thumb_matrix_m;
            case i == 2 && k == 2
                st2 = 'Ring '; matrix_to_plot = qj_ring_matrix_m;
            case i == 3 && k == 2
                st2 = 'Medium '; matrix_to_plot = qj_medium_matrix_m;
            case i == 4 && k == 2
                st2 = 'Index '; matrix_to_plot = qj_index_matrix_m;
            case i == 5 && k == 2
                st2 = 'Little '; matrix_to_plot = qj_little_matrix_m;
        end

            for j = 1:n_phalanges 

                switch j
                    case 1
                        st3 = 'Outer Ph.';
                    case 2
                        st3 = 'Middle Ph.';
                    case 3
                        st3 = 'Inner Ph.';
                end

                subplot(n_phalanges,n_filter,2*j+k-2)
                hold on
                grid on
                box on
                ax = gca;
                ax.FontSize = f;
                ax.FontWeight = 'bold';
                plot(matrix_to_plot(1+4*(j-1),:),'-k','Linewidth',l);
                plot(matrix_to_plot(2+4*(j-1),:),'-r','Linewidth',l);
                plot(matrix_to_plot(3+4*(j-1),:),'-g','Linewidth',l);
                plot(matrix_to_plot(4+4*(j-1),:),'-b','Linewidth',l);
                %ylabel('Degrees','FontSize',f,'FontWeight','bold')
                % xlim([-4*60, +40*60])
                % ylim([-8, 2])
                %str1 = sprintf(strcat(st1,st2,st3))
                title(strcat(st1,{' '},st2,{' '},st3))
                sgtitle(strcat(st2,{' '},'Joint quaternion'))
                legend('Q_0','Q_x','Q_y','Q_z','Location','SouthEast','FontSize',f,'FontWeight','bold')
                hold off

            end
            

    end

end