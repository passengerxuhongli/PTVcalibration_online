function evaluation = ParamCalib_zixuan(drivingBehaviorParams)
evaluation = zeros(5,1);
global Vissim
    global wdb 
    global dcm     
    global zhongqun
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
    global parameterlist     
    global parameters  
    global parameters1    
    global edition_number
    global pathname
    global filename
    
    try
    parameters = importdata('parameters.mat')
    catch
    parameters1 = importdata('parameters1.mat')
    end
    
 	fprintf(['GA...生成新的一个种群（一代一共20个个体） ',num2str(zhongqun),'\n\n']);
    zhongqun = zhongqun+1;
    %% ================= 1.SET PARAMS ================= 
if edition_number==0 
    if  paracalibtag(1)~=0&paracalibtag(3)~=0
     a = drivingBehaviorParams ;%attributes renew
     num = length(parameterlist);
     for j = 1:num
         try
          wdb.set('AttValue',parameters{j,1},a(j));  
         catch
          wdb.set('AttValue',parameters1{j,1},a(j));
         end
    end
    end
    if  paracalibtag(1)~=0&paracalibtag(3)==0
     a = drivingBehaviorParams ;%attributes renew
     num = length(parameterlist);
     for j = 1:num
         try
          wdb.set('AttValue',parameters{j,1},a(j));  
         catch
          wdb.set('AttValue',parameters1{j,1},a(j));
         end
    end
    end
    if  paracalibtag(2)~=0&paracalibtag(3)~=0
     a = drivingBehaviorParams ;%attributes renew
     num = length(parameterlist);        
     for j = 1:num
         try
          wdb.set('AttValue',parameters{j,1},a(j));  
         catch
          wdb.set('AttValue',parameters1{j,1},a(j));
         end 
    end
    end      
    if  paracalibtag(2)~=0&paracalibtag(3)==0%wiedeman99
     a = drivingBehaviorParams ;%attributes renew
     num = length(parameterlist);
     for j = 1:num   
      try
      wdb.set('AttValue',parameters{j,1},a(j));  
     catch
      wdb.set('AttValue',parameters1{j,1},a(j));
     end  
    end
    end         
else
     if edition_number==540   
         
        if  paracalibtag(1)~=0
         a = drivingBehaviorParams ;%attributes renew
         num = length(parameterlist);
         for j = 1:num
              wdb.set('AttValue',parameters{j,1},a(j));  
         end
        end 
        if  paracalibtag(2)~=0
         a = drivingBehaviorParams ;%attributes renew
         num = length(parameterlist);        
         for j = 1:num
              wdb.set('AttValue',parameters{j,1},a(j));  
        end
        end                  
     end
end


%% ================= 2.SIMULATIONS  =================     
% End_of_simulation= 1200;%3600
% set(Vissim.Simulation, 'AttValue', 'SimPeriod', End_of_simulation);
Vissim.Simulation.RunSingleStep;
  
    %% ================= 3.RESULTS ================= 
if  edition_number==0     
Vissim.Simulation.RunContinuous;    
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
 
else
    if edition_number==540 
        
        period = Vissim.simulation.Period;
        t=0;
        simulation_step = Vissim.Simulation.Resolution;
        TT1 = [];
        Delay1 =[];
        maxQ1 = [];
        MEANQ1 = [];
        No_Veh1 = [];        
      while   t<period*simulation_step-300         
           Vissim.Simulation.RunSingleStep;
        % travel time
        if TRAVELTIME==1
        Veh_TT_attributes = Vissim.net.TravelTimes;%所有行程时间属性
        T_travel_number = Veh_TT_attributes.Count;
        for  Veh_TT_measurement_number=1:T_travel_number
        Veh_TT_measurement = Vissim.net.TravelTimes.GetTravelTimeByNumber(Veh_TT_measurement_number);
        TT(1,Veh_TT_measurement_number) = Veh_TT_measurement.GetResult(floor(t/simulation_step)+1, 'NVEHICLES', '', 0);
        disp(['Average T_travel of all simulations and time intervals \n #',num2str(Veh_TT_measurement_number),':',32,num2str(TT(1,Veh_TT_measurement_number))]) % char(32) is whitespace
        end
         TT1=[TT1;TT];
         TT1 = mean(TT1,1);
         T_travel= TT1';
            evaluation1 = sum(T_travel.*traveltimereal(:,3))/sum(traveltimereal(:,3));
            sprintf('T_travel=%2.2f\n\n',T_travel);  
        else 
          evaluation1 =  0.0;  
        end
        % Delay
        if DELAY==1
        Veh_Delay = Vissim.Net.Delays;
        delay_number = Veh_Delay.Count;
        for  Veh_Delay_number=1:delay_number
        Veh_Delay_measurement = Vissim.net.Delays.GetDelayByNumber(Veh_Delay_number);
        Delay(1,Veh_Delay_number) = Veh_Delay_measurement.GetResult(floor(t/simulation_step)+1, 'DELAY', '', 0);
        disp(['Average Delay of all simulations and time intervals \n #',num2str(Veh_Delay_number),':',32,num2str(Delay(1,Veh_Delay_number))]) % char(32) is whitespace
        end
        Delay1 = [Delay1;Delay];
        Delay1 = mean(Delay1,1);
        Delay2 = Delay1';
            evaluation2 = sum(Delay2.*delayreal(:,3))/sum(delayreal(:,3));
                sprintf('Average delay \n=%2.2f\n\n',Delay2);
        else
           evaluation2 =  0.0; 
        end
         % Queue length
        if QUEUEMAX==1
        QC = Vissim.net.QueueCounters;
        m=1;
        for QC_number = 1:QC.Count
        queuecounter = Vissim.net.QueueCounters.GetQueueCounterByNumber(QC_number);
        maxQ(1,m) = queuecounter.GetResult(floor(t/simulation_step)+1, 'MAX');
        disp(['Average maximum Queue length of all simulations and time intervals of Queue Counter\n #',num2str(QC_number),':',32,num2str(maxQ(1,m))]) % char(32) is whitespace
        m=m+1;
        end
        maxQ1 = [maxQ1;maxQ];
        maxQ1 = mean(maxQ1,1);
        maxQ2 = maxQ1';
         evaluation3 = sum(maxQ2.*maxQreal(:,3))/sum(maxQreal(:,3));
         sprintf('Average maximum Queue =%2.2f\n\n',maxQ2);
        else
        evaluation3 =  0.0;    
        end
        if QUEUEMEAN==1
        QC = Vissim.net.QueueCounters;
        m=1;
        for QC_number = 1:QC.Count
        queuecounter = Vissim.net.QueueCounters.GetQueueCounterByNumber(QC_number);
        MEANQ(1,m) = queuecounter.GetResult(floor(t/simulation_step)+1, 'MEAN');
        disp(['Average MEAN Queue length of all simulations and time intervals of Queue Counter #',num2str(QC_number),':',32,num2str(MEANQ(1,m))]) % char(32) is whitespace
        m=m+1;
        end
        MEANQ1 = [MEANQ1;MEANQ];
        MEANQ1 = mean(MEANQ1,1);
        MEANQ2 = MEANQ1';
           evaluation4 = sum(MEANQ2.*MEANQreal(:,3))/sum(MEANQreal(:,3));
         sprintf('Average average Queue =%2.2f\n\n',MEANQ2);
        else
        evaluation4 =  0.0;    
        end      
        %  traffic capacity
        if CAPACITY==1
        dcm = Vissim.net.DataCollections;%所有datacollection属性
        dcm_number = dcm.Count;
        for  dcm_measurement_number=1:dcm_number
        datacollection = Vissim.net.DataCollections.GetDataCollectionByNumber(dcm_measurement_number);   
        No_Veh(1,dcm_measurement_number) = datacollection.GetResult('NVEHICLES', 'SUM', 0); % number of vehicles
        disp(['traffic flows of all simulations and time intervals \n #',num2str(dcm_measurement_number),':',32,num2str(No_Veh(1,dcm_measurement_number))]) % char(32) is whitespace
        end
        No_Veh1 = [No_Veh1;No_Veh];
        No_Veh1 = mean(No_Veh1,1);
         trafficflow=No_Veh1';
         trafficflow = (period*simulation_step-300).*trafficflow./600   
            evaluation5 = sum(double(trafficflow).*capacityreal(:,3))/sum(capacityreal(:,3));%%%%转换一下数据格式
            sprintf('trafficflow=%2.2f\n\n',trafficflow);  
        else 
          evaluation5 =  0.0;  
        end    
          t = t+1;
      end
    path = [pathname  filename];
    Vissim = actxserver('VISSIM.Vissim.540'); % Start Vissim       
     Vissim.LoadNet(path); 
     path1 = [pathname 'vissim.ini'];
      Vissim.LoadLayout(path1);  


isConnector = []; link_attribute=[];
        lk = Vissim.net.Links;
        for iLk = 1:lk.count%判断该路段是否为连接器，若是则后续中可能会改变其“换道距离”这一参数
            link = lk.Item(iLk);
            if link.AttValue('CONNECTOR')
                link_attribute = [link_attribute, lk.GetLinkByNumber(link.AttValue('ID')).AttValue('BEHAVIORTYPE'),iLk];
            else
                isConnector = [isConnector,iLk];
            end
        end
            db = Vissim.net.DrivingBehaviorParSets;
        db_def_index = get(Vissim.Net.Links.GetLinkByNumber(1), 'AttValue', 'BEHAVIORTYPE');
        sprintf('db_def_index=%d\n',db_def_index)
        %db_def_index为1-6的数字，
        wdb = db.GetDrivingBehaviorParSetByNumber(db_def_index);%道路均有Wiedeman99/74,和换道参数。   

    end
    
end



    fprintf('\n========================================\n\n')
   evaluation = [evaluation1;evaluation2;evaluation3;evaluation4;evaluation5]
    
    
    