function evaluation = ParamCalib_direct(drivingBehaviorParams)
evaluation = zeros(5,1);
global Vissim
    global wdb 
    global zhongqun
    global lk
    global dcm    
    global isConnector
    global TRAVELTIME
    global DELAY
    global QUEUEMAX 
    global QUEUEMEAN
    global CAPACITY
    global capacityreal    
    global traveltimereal
    global delayreal
    global maxQreal 
    global MEANQreal        
    global paracalibtag 
    global parametersname
    global db_def_index
 	fprintf(['GA...生成新的一个种群（一代一共20个个体） ',num2str(zhongqun),'\n\n']);
    zhongqun = zhongqun+1;
    %% ================= 1.SET PARAMS ================= 
      if  (paracalibtag(1)~=0&paracalibtag(3)~=0)
    a = drivingBehaviorParams ;%attributes renew
 sprintf('=================vissim parameters %3.0f =================\nW74ax=%2.2f, W74bxAdd=%2.2f,W74bxMult = %2.2f, LookBackDistMax =%2.2f, CC5=%2.2f\n minD=%2.2f, safe=%2.2f, maxCD = %2.2f, maxSD =%2.2f, lcDist = %2.2f\n\nSimulating...\n',...
       a(1),a(2),a(3),a(4),a(5),a(6),a(7),a(8),a(9));
wdb.set('AttValue','W74ax',a(1)); 
    wdb.set('AttValue','W74bxAdd',a(2));
    wdb.set('AttValue','W74bxMult',a(3)); 
    wdb.set('AttValue','LookBackDistMax',a(4)); 
    wdb.set('AttValue','AccDecelTrail',a(5)); % minD
    wdb.set('AttValue','SafDistFactLnChg',a(6)); % safe
    wdb.set('AttValue','CoopDecel',a(7)); % maxCD
    wdb.set('AttValue','CoopLnChgSpeedDiff',a(8)); % maxSD
    for iLk = isConnector
        lk{iLk}.set('AttValue','LnChgDist',a(9));
    end
      end
           if  paracalibtag(1)~=0&paracalibtag(3)==0
    a = drivingBehaviorParams ;%attributes renew
 sprintf('=================vissim parameters %3.0f =================\nW74ax=%2.2f, W74bxAdd=%2.2f,W74bxMult = %2.2f, LookBackDistMax =%2.2f\n\nSimulating...\n',...
       a(1),a(2),a(3),a(4));
wdb.set('AttValue','W74ax',a(1)); 
    wdb.set('AttValue','W74bxAdd',a(2));
    wdb.set('AttValue','W74bxMult',a(3)); 
    wdb.set('AttValue','LookBackDistMax',a(4)); 
           end
      if  paracalibtag(2)~=0&paracalibtag(3)~=0
    a = drivingBehaviorParams ;%attributes renew
 sprintf('=================vissim parameters %3.0f =================\nCC0=%2.2f, CC1=%2.2f, CC2 = %2.2f, CC4 =%2.2f, CC5=%2.2f\nminD=%2.2f, safe=%2.2f, maxCD = %2.2f, maxSD =%2.2f, lcDist = %2.2f\n\nSimulating...\n',...
       a(1),a(2),a(3),-a(4),a(4),a(5),a(6),a(7),a(8),a(9));
wdb.set('AttValue','W99cc0',a(1)); % cc0
    wdb.set('AttValue','W99cc1Distr',a(2)); % cc1
    wdb.set('AttValue','W99cc2',a(3)); % cc2
    wdb.set('AttValue','W99cc4',-a(4)); % cc4
    wdb.set('AttValue','W99cc5',a(4)); % cc5
    wdb.set('AttValue','AccDecelTrail',a(5)); % minD
    wdb.set('AttValue','SafDistFactLnChg',a(6)); % safe
    wdb.set('AttValue','CoopDecel',a(7)); % maxCD
    wdb.set('AttValue','CoopLnChgSpeedDiff',a(8)); % maxSD
    for iLk = isConnector
        lk{iLk}.set('AttValue','LnChgDist',a(9));
    end
      end
      if  paracalibtag(2)~=0&paracalibtag(3)==0%wiedeman99
    a = drivingBehaviorParams ;%attributes renew
 sprintf('=================vissim parameters %3.0f =================\nCC0=%2.2f, CC1=%2.2f, CC2 = %2.2f, CC4 =%2.2f, CC5=%2.2f\n\nSimulating...\n',...
       a(1),a(2),a(3),-a(4),a(4));
wdb.set('AttValue','W99cc0',a(1)); % cc0
    wdb.set('AttValue','W99cc1Distr',a(2)); % cc1
    wdb.set('AttValue','W99cc2',a(3)); % cc2
    wdb.set('AttValue','W99cc4',-a(4)); % cc4
    wdb.set('AttValue','W99cc5',a(4)); % cc5
      end           

%% ================= 2.SIMULATIONS  =================     
% End_of_simulation= 1200;%3600
% set(Vissim.Simulation, 'AttValue', 'SimPeriod', End_of_simulation);
    Vissim.Simulation.RunContinuous;
    %% ================= 3.RESULTS ================= 
% travel time
if TRAVELTIME==1
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
disp(['Average T_travel of all simulations and time intervals \n #',num2str(Veh_TT_measurement_number),':',32,num2str(TT(Veh_TT_measurement_number))]) % char(32) is whitespace
end
 T_travel=TT';
    evaluation1 = sum(T_travel.*traveltimereal(:,3))/sum(traveltimereal(:,3));
    sprintf('T_travel=%2.2f\n\n',T_travel);  
else 
  evaluation1 =  0.0;  
end
 
% Delay
if DELAY==1
Veh_Delay = Vissim.Net.DelayMeasurements.GetAll;
delay_number = size(Veh_Delay,1);
for  Veh_Delay_number=1:delay_number
Veh_Delay_measurement = Vissim.net.DelayMeasurements.ItemByKey(Veh_Delay_number);
Delay(Veh_Delay_number) = get(Veh_Delay_measurement, 'AttValue', 'VehDelay(Avg,Avg,All)');
 disp(['Average Delay of all simulations and time intervals \n #',num2str(Veh_Delay_number),':',32,num2str(Delay(Veh_Delay_number))]) % char(32) is whitespace
end
Delay = Delay';
    evaluation2 = sum(Delay.*delayreal(:,3))/sum(delayreal(:,3));
        sprintf('Average delay \n=%2.2f\n\n',Delay);
else
   evaluation2 =  0.0; 
end

 % Queue length
if QUEUEMAX==1
QC = Vissim.net.QueueCounters.GetAll;
m=1;
for QC_number = 1:size(QC,1)
maxQ(m) = get(Vissim.Net.QueueCounters.ItemByKey(QC_number),'AttValue', 'QLenMax(Avg, Avg)');
 disp(['Average maximum Queue length of all simulations and time intervals of Queue Counter\n #',num2str(QC_number),':',32,num2str(maxQ(m))]) % char(32) is whitespace
m=m+1;
end
maxQ= maxQ';
    evaluation3 = sum(maxQ.*maxQreal(:,3))/sum(maxQreal(:,3));
 sprintf('Average maximum Queue =%2.2f\n\n',evaluation3);
else
evaluation3 =  0.0;    
end
if QUEUEMEAN==1
QC = Vissim.net.QueueCounters.GetAll;
m=1;
for QC_number = 1:size(QC,1)
MEANQ(m) = get(Vissim.Net.QueueCounters.ItemByKey(QC_number),'AttValue', 'QLen(Max, Avg)');
disp(['Average MEAN Queue length of all simulations and time intervals of Queue Counter #',num2str(QC_number),':',32,num2str(MEANQ(m))]) % char(32) is whitespace
m=m+1;
end
MEANQ = MEANQ';
   evaluation4 = sum(MEANQ.*MEANQreal(:,3))/sum(MEANQreal(:,3));
 sprintf('Average average Queue =%2.2f\n\n',evaluation4);
else
evaluation4 =  0.0;    
end

%  traffic capacity
if CAPACITY==1
dcm = Vissim.net.DataCollectionMeasurements.GetAll;%所有datacollection属性
dcm_number = size(dcm,1);
for  dcm_measurement_number=1:dcm_number
No_Veh(dcm_measurement_number) = get(dcm{dcm_measurement_number}, 'AttValue', 'Vehs        (Avg,1,All)'); % number of vehicles
disp(['traffic flows of all simulations and time intervals \n #',num2str(dcm_measurement_number),':',32,num2str(No_Veh(dcm_measurement_number))]) % char(32) is whitespace
end
 trafficflow=No_Veh';
    evaluation5 = sum(double(trafficflow).*capacityreal(:,3))/sum(capacityreal(:,3));%%%%转换一下数据格式
    sprintf('trafficflow=%2.2f\n\n',trafficflow);  
else 
  evaluation5 =  0.0;  
end
 
    fprintf('\n========================================\n\n')
   evaluation = [evaluation1;evaluation2;evaluation3;evaluation4;evaluation5]
    
    
    
    