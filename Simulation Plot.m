function SimulationPlot(jj)
% figure('Name','Simulation Plot','NumberTitle','off');
grid on;
hold on;
view([-160 30]);
xlabel('X') 
ylabel('Y') 
zlabel('Z') 
axis equal
% t15_0=deg2rad([-0.10641;5.1822;0.37504]);
t15_0=deg2rad([0;0;-2]);
t0_1=deg2rad(jj(:,3));
t1_2=deg2rad(jj(:,2));
t2_end=deg2rad(jj(:,1));

% t15_3=deg2rad([-2.5281;-2.087;0.4092])
t15_3=deg2rad([0;0;0]);
t3_4 =deg2rad(jj(:,6))
t4_5 =deg2rad(jj(:,5))
t5_end =deg2rad(jj(:,4))

% t15_6=deg2rad([1.4764;-1.0764;0.42378]);
t15_6=deg2rad([0;0;2]);
t6_7 =deg2rad(jj(:,9));
t7_8 =deg2rad(jj(:,8));
t8_end =deg2rad(jj(:,7));

% t15_9=deg2rad([7.7633;0.40933;0.52135]);
t15_9=deg2rad([0;0;4]);
t9_10 =deg2rad(jj(:,12));
t10_11 =deg2rad(jj(:,11));
t11_end =deg2rad(jj(:,10));


% t15_12=deg2rad([12.248;-0.19729;-2.0445])
t15_12=deg2rad([0;0;45]);
t12_13=deg2rad(jj(:,15))
t13_14=deg2rad(jj(:,14))
t14_end=deg2rad(jj(:,13))

L1= [13.5,2,2,2];   % little_chain
L2= [14,2,2,2];     % index_chain
L3= [14.5,2,2,2];   % medium_chain
L4= [13.5,2,2,2];   % ring_chain
L5= [10,2,2,2];     % thumb_chain

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p15=[0 0 0]';
p0=rotx(t15_0(2))*roty(t15_0(1))*rotz(t15_0(3))*[0 L1(1) 0]'+p15;
p1=rotx(t0_1(2))*roty(t0_1(1))*rotz(t0_1(3))*[0 L1(2) 0]'+p0;
p2=rotx(t0_1(2)+t1_2(2))*roty(t0_1(1)+t1_2(1))*rotz(t0_1(3)+t1_2(3))*[0 L1(3) 0]'+p1;
p2_end=rotx(t0_1(2)+t1_2(2)+t2_end(2))*roty(t0_1(1)+t1_2(1)+t2_end(1))*rotz(t0_1(3)+t1_2(3)+t2_end(3))*[0 L1(4) 0]'+p2;


p3=rotx(t15_3(2))*roty(t15_3(1))*rotz(t15_3(3))*[0 L2(1) 0]'+p15;
p4=rotx(t3_4(2))*roty(t3_4(1))*rotz(t3_4(3))*[0 L2(2) 0]'+p3;
p5=rotx(t3_4(2)+t4_5(2))*roty(t3_4(1)+t4_5(1))*rotz(t3_4(3)+t4_5(3))*[0 L2(3) 0]'+p4;
p5_end=rotx(t3_4(2)+t4_5(2)+t5_end(2))*roty(t3_4(1)+t4_5(1)+t5_end(1))*rotz(t3_4(3)+t4_5(3)+t5_end(3))*[0 L2(4) 0]'+p5;


p6=rotx(t15_6(2))*roty(t15_6(1))*rotz(t15_6(3))*[0 L3(1) 0]'+p15;
p7=rotx(t6_7(2))*roty(t6_7(1))*rotz(t6_7(3))*[0 L3(2) 0]'+p6;
p8=rotx(t6_7(2)+t7_8(2))*roty(t6_7(1)+t7_8(1))*rotz(t6_7(3)+t7_8(3))*[0 L3(3) 0]'+p7;
p8_end=rotx(t6_7(2)+t7_8(2)+t8_end(2))*roty(t6_7(1)+t7_8(1)+t8_end(1))*rotz(t6_7(3)+t7_8(3)+t8_end(3))*[0 L3(4) 0]'+p8;
 
p9=rotx(t15_9(2))*roty(t15_9(1))*rotz(t15_9(3))*[0 L4(1) 0]'+p15;
p10=rotx(t9_10(2))*roty(t9_10(1))*rotz(t9_10(3))*[0 L4(2)  0]'+p9;
p11=rotx(t9_10(2)+t10_11(2))*roty(t9_10(1)+t10_11(1))*rotz(t9_10(3)+t10_11(3))*[0 L4(3) 0]'+p10;
p11_end=rotx(t9_10(2)+t10_11(2)+t11_end(2))*roty(t9_10(1)+t10_11(1)+t11_end(1))*rotz(t9_10(3)+t10_11(3)+t11_end(3))*[0 L4(4) 0]'+p11;

% 
% 
p12=rotx(t15_12(2))*roty(t15_12(1))*rotz(t15_12(3))*[0 L5(1) 0]'+p15;
p13=rotx(t12_13(1))*roty(t12_13(3))*rotz(t12_13(2))*[0 L5(2) 0]'+p12;
p14=rotx(t12_13(1)+t13_14(1))*roty(t12_13(3)+t13_14(3))*rotz(t12_13(2)+t13_14(2))*[0 L5(3) 0]'+p13;
p14_end=rotx(t12_13(1)+t13_14(1)+t14_end(1))*roty(t12_13(3)+t13_14(3)+t14_end(3))*rotz(t12_13(2)+t13_14(2)+t14_end(2))*[0 L5(4) 0]'+p14;



line([p0(1) p15(1)],[p0(2) p15(2)],[p0(3) p15(3)],'Color','Black','LineWidth',2);
line([p1(1) p0(1)],[p1(2) p0(2)],[p1(3) p0(3)],'Color','Blue','LineWidth',2);
line([p2(1) p1(1)],[p2(2) p1(2)],[p2(3) p1(3)],'Color','cyan','LineWidth',2);
line([p2_end(1) p2(1)],[p2_end(2) p2(2)],[p2_end(3) p2(3)],'Color','Green','LineWidth',2);

line([p3(1) p15(1)],[p3(2) p15(2)],[p3(3) p15(3)],'Color','Black','LineWidth',2);
line([p4(1) p3(1)],[p4(2) p3(2)],[p4(3) p3(3)],'Color','Blue','LineWidth',2);
line([p5(1) p4(1)],[p5(2) p4(2)],[p5(3) p4(3)],'Color','cyan','LineWidth',2);
line([p5_end(1) p5(1)],[p5_end(2) p5(2)],[p5_end(3) p5(3)],'Color','Green','LineWidth',2);

line([p6(1) p15(1)],[p6(2) p15(2)],[p6(3) p15(3)],'Color','Black','LineWidth',2);
line([p7(1) p6(1)],[p7(2) p6(2)],[p7(3) p6(3)],'Color','Blue','LineWidth',2);
line([p8(1) p7(1)],[p8(2) p7(2)],[p8(3) p7(3)],'Color','cyan','LineWidth',2);
line([p8_end(1) p8(1)],[p8_end(2) p8(2)],[p8_end(3) p8(3)],'Color','Green','LineWidth',2);

line([p9(1) p15(1)],[p9(2) p15(2)],[p9(3) p15(3)],'Color','Black','LineWidth',2);
line([p10(1) p9(1)],[p10(2) p9(2)],[p10(3) p9(3)],'Color','Blue','LineWidth',2);
line([p11(1) p10(1)],[p11(2) p10(2)],[p11(3) p10(3)],'Color','cyan','LineWidth',2);
line([p11_end(1) p11(1)],[p11_end(2) p11(2)],[p11_end(3) p11(3)],'Color','Green','LineWidth',2);

% 
% line([p12(1) p15(1)],[p12(2) p15(2)],[p12(3) p15(3)],'Color','Black','LineWidth',2);
% line([p13(1) p12(1)],[p13(2) p12(2)],[p13(3) p12(3)],'Color','Blue','LineWidth',2);
% line([p14(1) p13(1)],[p14(2) p13(2)],[p14(3) p13(3)],'Color','cyan','LineWidth',2);
% line([p14_end(1) p14(1)],[p14_end(2) p14(2)],[p14_end(3) p14(3)],'Color','Green','LineWidth',2);

end