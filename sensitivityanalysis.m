function [selectiontag,ENDResult]= sensitivityanalysis()
global pathname
global filename
global parametersname 
global paraselectag
global parameters 
paraselectag = importdata('paraselectag.mat');
 parametersname = [{'Widemann74'},{'W74ax'},{'W74bxAdd'},{'W74bxMult'},{'LookBackDistMax'},{'LookAheadDistMax'},{'StandDist'},{'ObsrvdVehs'},{''},{''},{''},{''},{''},{''},{''};
    {'Widemann99'},{'W99cc0'},{'W99cc1Distr'},{'W99cc2'},{'W99cc3'},{'W99cc4'},{'W99cc5'},{'W99cc6'},{'W99cc7'},{'W99cc8'},{'W99cc9'},{'ObsrvdVehs'},{'LookBackDistMax'},{'LookAheadDistMax'},{'StandDist'};
    {'LANE CHANGE'},{'DecelRedDistOwn'},{'AccDecelOwn'},{'MinHdwy'},{'SafDistFactLnChg'},{'CoopDecel'},{'CoopLnChgSpeedDiff'},{''},{''},{''},{''},{''},{''},{''},{''}]';
    path = [pathname  filename];
    Vissim = actxserver('VISSIM.Vissim-64.900'); % Start Vissim
    Vissim.LoadNet(path);
    
if paraselectag(1)~=0&paraselectag(3)~=0
    TT_1=cell(13,1);   PValue=cell(13,1);
    ub = [2.5, 4.7, 8, 200,300,3, 5,   200, -0.5, 3.5, 0.6, -3, 20,300];
    lb = [0.5, 0.7, 1, 50, 100,0, 1,   100, -3,   0.5, 0.1, -6, 5,100];
    parametersvalue=zeros(13,6);
 parameters = [{'W74ax'},{'W74bxAdd'},{'W74bxMult'},{'LookBackDistMax'},{'LookAheadDistMax'},{'StandDist'},{'ObsrvdVehs'},...
     {'DecelRedDistOwn'},{'AccDecelOwn'},{'MinHdwy'},{'SafDistFactLnChg'},{'CoopDecel'},{'CoopLnChgSpeedDiff'}]'
 save('parameters.mat','parameters');
end
    if paraselectag(1)~=0&paraselectag(3)==0
    TT_1=cell(7,1);  PValue=cell(7,1);
    ub = [2.5, 4.7, 8, 200,300,3, 5];
    lb = [0.5, 0.7, 1, 50, 100,0, 1];
    parametersvalue=zeros(7,6);
 parameters = [{'W74ax'},{'W74bxAdd'},{'W74bxMult'},{'LookBackDistMax'},{'LookAheadDistMax'},{'StandDist'},{'ObsrvdVehs'}]'
    save('parameters.mat','parameters');
    end
    if paraselectag(2)~=0&paraselectag(3)~=0%wiedeman99&lane change
     TT_1=cell(20,1);  PValue=cell(20,1);
    ub = [3.5, 5,   8, -5, -0.15,   7, 15.4, 0.95,5, 2.5, 5,  200, 350,  5,  200, -0.5, 3.5, 0.6, -3, 20,300];
    lb = [0.5, 0.5, 1, -10, -0.7, 0.7, 8.44, 0.15,0, 0.5, 1,  100, 150,0.5,  100,   -3, 0.5, 0.1, -6,  5,100];
    parametersvalue=zeros(20,6);
    parameters = [{'W99cc0'},{'W99cc1Distr'},{'W99cc2'},{'W99cc3'},{'W99cc4'},{'W99cc5'},{'W99cc6'},{'W99cc7'},{'W99cc8'},{'W99cc9'},{'ObsrvdVehs'},{'LookBackDistMax'},{'LookAheadDistMax'},{'StandDist'},...
{'DecelRedDistOwn'},{'AccDecelOwn'},{'MinHdwy'},{'SafDistFactLnChg'},{'CoopDecel'},{'CoopLnChgSpeedDiff'}]'
 save('parameters.mat','parameters');

    end   
    if paraselectag(2)~=0&paraselectag(3)==0%wiedeman99
     TT_1=cell(14,1);  PValue=cell(14,1);
    ub = [3.5, 5,   8, -5, -0.15,   7, 15.4, 0.95,5, 2.5, 5,  200, 350,  5];
    lb = [0.5, 0.5, 1, -10, -0.7, 0.7, 8.44, 0.15,0, 0.5, 1,  100, 150,0.5];
    parametersvalue=zeros(14,6);
    parameters = [{'W99cc0'},{'W99cc1Distr'},{'W99cc2'},{'W99cc3'},{'W99cc4'},{'W99cc5'},{'W99cc6'},{'W99cc7'},{'W99cc8'},{'W99cc9'},{'ObsrvdVehs'},{'LookBackDistMax'},{'LookAheadDistMax'},{'StandDist'}]'
    save('parameters.mat','parameters');
    end
%% ========================================================================
% Simulation
End_of_simulation = 1200; 
set(Vissim.Simulation, 'AttValue', 'SimPeriod', End_of_simulation);
set(Vissim.Simulation, 'AttValue', 'UseMaxSimSpeed', true);
% DRIVING BEHAVIOR
db = Vissim.net.DrivingBehaviors.GetAll;
db_def_index = str2num(get(Vissim.Net.Links.ItemByKey(1), 'AttValue', 'LinkBehavType'));
sprintf('db_def_index=%d\n',db_def_index)
wdb = db{db_def_index};
%% =======GET TRAVEL TIME=========
Random_Seed = [15 50 75];

if paraselectag(1)~=0&paraselectag(3)~=0
for i=1:13
    parametersvalue(i,:)=lb(i):(ub(i)-lb(i))/5:ub(i);
    %重置参数为缺省值
    wdb.set('AttValue','W74ax',2);
    wdb.set('AttValue','W74bxAdd',2);
    wdb.set('AttValue','W74bxMult',3);
    wdb.set('AttValue','LookBackDistMax',150);
    wdb.set('AttValue','LookAheadDistMax',250);
    wdb.set('AttValue','StandDist',0.5);
    wdb.set('AttValue','ObsrvdVehs',2);
    wdb.set('AttValue','DecelRedDistOwn',200);
    wdb.set('AttValue','AccDecelOwn',-1);
    wdb.set('AttValue','MinHdwy',0.5);
    wdb.set('AttValue','SafDistFactLnChg',0.6);
    wdb.set('AttValue','CoopDecel',-3);
    wdb.set('AttValue','CoopLnChgSpeedDiff',10.8); 
    %1-13对应13个参数
    switch i
        case 1
            for j=1:6
                wdb.set('AttValue','W74ax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 2
            for j=1:6
                wdb.set('AttValue','W74bxAdd',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 3
            for j=1:6
                wdb.set('AttValue','W74bxMult',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 4
            for j=1:6
                wdb.set('AttValue','LookBackDistMax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
        case 5
            for j=1:6
                wdb.set('AttValue','LookAheadDistMax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 6
            for j=1:6
                wdb.set('AttValue','StandDist',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
        case 7
            for j=1:6
                wdb.set('AttValue','ObsrvdVehs',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 8
            for j=1:6
                wdb.set('AttValue','DecelRedDistOwn',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
         case 9
            for j=1:6
                wdb.set('AttValue','AccDecelOwn',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end           
        case 10
            for j=1:6
                wdb.set('AttValue','MinHdwy',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end            
         case 11
            for j=1:6
                wdb.set('AttValue','SafDistFactLnChg',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
         case 12
            for j=1:6
                wdb.set('AttValue','CoopDecel',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end           
        otherwise
            for j=1:6
                wdb.set('AttValue','CoopLnChgSpeedDiff',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end        
    end
    
    
    PValue{i,1}=anova1(TT_1{i,1},[],'off');
                        %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
    if i~=13
          results = sprintf('======== Parameters Sensitivity Analysis ========\nANOVA P-VALUE ( Travel Time ) \n W74AX=%2.2f, W74BXADD=%2.2f, W74BXMULT = %2.2f, LOOKBACKDISTMAX =%2.2f, LOOKAHEADDISTMAX=%2.2f STANDDIST=%2.2f, OBSRVDVEHS=%2.2f\n, DECELREDDISTOWN=%2.2f, ACCDECELOWN = %2.2f, MINHDWY =%2.2f, SAFDISTFACELNCH=%2.2f, COOPDECEL=%2.2f, COOPLNCHGSPEEDDIFF=%2.2f\n\nCalculating...\n'...
              ,PValue{1,1},PValue{2,1},PValue{3,1},PValue{4,1},PValue{5,1},PValue{6,1},PValue{7,1},PValue{8,1},PValue{9,1},PValue{10,1},PValue{11,1},PValue{12,1},PValue{13,1});
    else
          results = sprintf('======== Parameters Sensitivity Analysis ========\nANOVA P-VALUE ( Travel Time ) \n W74AX=%2.2f, W74BXADD=%2.2f, W74BXMULT = %2.2f, LOOKBACKDISTMAX =%2.2f, LOOKAHEADDISTMAX=%2.2f STANDDIST=%2.2f, OBSRVDVEHS=%2.2f\n, DECELREDDISTOWN=%2.2f, ACCDECELOWN = %2.2f, MINHDWY =%2.2f, SAFDISTFACELNCH=%2.2f COOPDECEL=%2.2f, COOPLNCHGSPEEDDIFF=%2.2f\n\nEND！！！\n'...
              ,PValue{1,1},PValue{2,1},PValue{3,1},PValue{4,1},PValue{5,1},PValue{6,1},PValue{7,1},PValue{8,1},PValue{9,1},PValue{10,1},PValue{11,1},PValue{12,1},PValue{13,1});
    end
end
end
 

if paraselectag(1)~=0&paraselectag(3)==0
for i=1:7
    parametersvalue(i,:)=lb(i):(ub(i)-lb(i))/5:ub(i);
    %重置参数为缺省值
    wdb.set('AttValue','W74ax',2);
    wdb.set('AttValue','W74bxAdd',2);
    wdb.set('AttValue','W74bxMult',3);
    wdb.set('AttValue','LookBackDistMax',150);
    wdb.set('AttValue','LookAheadDistMax',250);
    wdb.set('AttValue','StandDist',0.5);
    wdb.set('AttValue','ObsrvdVehs',2);
    %1-7对应7个参数
    switch i
        case 1
            for j=1:6
                wdb.set('AttValue','W74ax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 2
            for j=1:6
                wdb.set('AttValue','W74bxAdd',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 3
            for j=1:6
                wdb.set('AttValue','W74bxMult',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 4
            for j=1:6
                wdb.set('AttValue','LookBackDistMax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
        case 5
            for j=1:6
                wdb.set('AttValue','LookAheadDistMax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 6
            for j=1:6
                wdb.set('AttValue','StandDist',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end          
        otherwise
            for j=1:6
                wdb.set('AttValue','ObsrvdVehs',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end        
    end
    
    
    PValue{i,1}=anova1(TT_1{i,1},[],'off');
                        %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
    if i~=7
          results = sprintf('======== Parameters Sensitivity Analysis ========\nANOVA P-VALUE ( Travel Time ) \n W74AX=%2.2f, W74BXADD=%2.2f, W74BXMULT = %2.2f, LOOKBACKDISTMAX =%2.2f, LOOKAHEADDISTMAX=%2.2f, STANDDIST=%2.2f, OBSRVDVEHS=%2.2f\n\nCalculating...\n'...
              ,PValue{1,1},PValue{2,1},PValue{3,1},PValue{4,1},PValue{5,1},PValue{6,1},PValue{7,1});
    else
          results = sprintf('======== Parameters Sensitivity Analysis ========\nANOVA P-VALUE ( Travel Time ) \n W74AX=%2.2f, W74BXADD=%2.2f, W74BXMULT = %2.2f, LOOKBACKDISTMAX =%2.2f, LOOKAHEADDISTMAX=%2.2f, STANDDIST=%2.2f, OBSRVDVEHS=%2.2f\n\nEND！！！\n'...
              ,PValue{1,1},PValue{2,1},PValue{3,1},PValue{4,1},PValue{5,1},PValue{6,1},PValue{7,1});
    end
end
end

if paraselectag(2)~=0&paraselectag(3)~=0
for i=1:20
    parametersvalue(i,:)=lb(i):(ub(i)-lb(i))/5:ub(i);
    %重置参数为缺省值
    wdb.set('AttValue','W99cc0',1.5);
    wdb.set('AttValue','W99cc1Distr',0.9);
    wdb.set('AttValue','W99cc2',4);
    wdb.set('AttValue','W99cc3',-8);
    wdb.set('AttValue','W99cc4',-0.35);
    wdb.set('AttValue','W99cc5',0.35);
    wdb.set('AttValue','W99cc6',11.44);
    wdb.set('AttValue','W99cc7',0.25);
    wdb.set('AttValue','W99cc8',3.5);
    wdb.set('AttValue','W99cc9',1.5);  
    wdb.set('AttValue','ObsrvdVehs',2);
    wdb.set('AttValue','LookBackDistMax',150);
    wdb.set('AttValue','LookAheadDistMax',250);
    wdb.set('AttValue','StandDist',0.5);
    wdb.set('AttValue','DecelRedDistOwn',200);
    wdb.set('AttValue','AccDecelOwn',-1);
    wdb.set('AttValue','MinHdwy',0.5);
    wdb.set('AttValue','SafDistFactLnChg',0.6);
    wdb.set('AttValue','CoopDecel',-3);
    wdb.set('AttValue','CoopLnChgSpeedDiff',10.8);    
    %1-20对应20个参数
    switch i
        case 1
            for j=1:6
                wdb.set('AttValue','W99cc0',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 2
            for j=1:6
                wdb.set('AttValue','W99cc1Distr',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 3
            for j=1:6
                wdb.set('AttValue','W99cc2',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 4
            for j=1:6
                wdb.set('AttValue','W99cc3',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
        case 5
            for j=1:6
                wdb.set('AttValue','W99cc4',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 6
            for j=1:6
                wdb.set('AttValue','W99cc5',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
        case 7
            for j=1:6
                wdb.set('AttValue','W99cc6',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 8
            for j=1:6
                wdb.set('AttValue','W99cc7',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
         case 9
            for j=1:6
                wdb.set('AttValue','W99cc8',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end           
        case 10
            for j=1:6
                wdb.set('AttValue','W99cc9',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end            
         case 11
            for j=1:6
                wdb.set('AttValue','ObsrvdVehs',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
         case 12
            for j=1:6
                wdb.set('AttValue','LookBackDistMax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end     
        case 13
            for j=1:6
                wdb.set('AttValue','LookAheadDistMax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
        case 14
            for j=1:6
                wdb.set('AttValue','StandDist',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 15
            for j=1:6
                wdb.set('AttValue','DecelRedDistOwn',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
         case 16
            for j=1:6
                wdb.set('AttValue','AccDecelOwn',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end           
        case 17
            for j=1:6
                wdb.set('AttValue','MinHdwy',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end            
         case 18
            for j=1:6
                wdb.set('AttValue','SafDistFactLnChg',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
         case 19
            for j=1:6
                wdb.set('AttValue','CoopDecel',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end             
        otherwise
            for j=1:6
                wdb.set('AttValue','CoopLnChgSpeedDiff',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end        
    end  

    PValue{i,1}=anova1(TT_1{i,1},[],'off');
                        %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
    if i~=20
          results = sprintf('======== Parameters Sensitivity Analysis ========\nANOVA P-VALUE ( Travel Time ) \n W99cc0=%2.2f, W99cc1Distr=%2.2f, W99cc2 = %2.2f, W99cc3 =%2.2f, W99cc4=%2.2f,,W99cc5=%2.2f, W99cc6=%2.2f, W99cc7 = %2.2f, W99cc8 =%2.2f, W99cc9=%2.2f, ,OBSRVDVEHS=%2.2f ,LOOKBACKDISTMAX=%2.2f, LOOKAHEADDISTMAX=%2.2f,STANDDIST=%2.2f\n, DECELREDDISTOWN=%2.2f, ACCDECELOWN = %2.2f, MINHDWY =%2.2f, SAFDISTFACELNCH=%2.2f, COOPDECEL=%2.2f, COOPLNCHGSPEEDDIFF=%2.2f\n\nCalculating...\n'...
              ,PValue{1,1},PValue{2,1},PValue{3,1},PValue{4,1},PValue{5,1},PValue{6,1},PValue{7,1},PValue{8,1},PValue{9,1},PValue{10,1},PValue{11,1},PValue{12,1},PValue{13,1},PValue{14,1},PValue{15,1},PValue{16,1},PValue{17,1},PValue{18,1},PValue{19,1},PValue{20,1});
    else
          results = sprintf('======== Parameters Sensitivity Analysis ========\nANOVA P-VALUE ( Travel Time ) \nW99cc0=%2.2f, W99cc1Distr=%2.2f, W99cc2 = %2.2f, W99cc3 =%2.2f, W99cc4=%2.2f,,W99cc5=%2.2f, W99cc6=%2.2f, W99cc7 = %2.2f, W99cc8 =%2.2f, W99cc9=%2.2f, ,OBSRVDVEHS=%2.2f ,LOOKBACKDISTMAX=%2.2f, LOOKAHEADDISTMAX=%2.2f,STANDDIST=%2.2f\n, DECELREDDISTOWN=%2.2f, ACCDECELOWN = %2.2f, MINHDWY =%2.2f, SAFDISTFACELNCH=%2.2f, COOPDECEL=%2.2f, COOPLNCHGSPEEDDIFF=%2.2f\n\nEND！！！\n'...
              ,PValue{1,1},PValue{2,1},PValue{3,1},PValue{4,1},PValue{5,1},PValue{6,1},PValue{7,1},PValue{8,1},PValue{9,1},PValue{10,1},PValue{11,1},PValue{12,1},PValue{13,1},PValue{14,1},PValue{15,1},PValue{16,1},PValue{17,1},PValue{18,1},PValue{19,1},PValue{20,1});
    end
end
end
     
if paraselectag(2)~=0&paraselectag(3)==0
for i=1:14
    parametersvalue(i,:)=lb(i):(ub(i)-lb(i))/5:ub(i);
    %重置参数为缺省值
    wdb.set('AttValue','W99cc0',1.5);
    wdb.set('AttValue','W99cc1Distr',0.9);
    wdb.set('AttValue','W99cc2',4);
    wdb.set('AttValue','W99cc3',-8);
    wdb.set('AttValue','W99cc4',-0.35);
    wdb.set('AttValue','W99cc5',0.35);
    wdb.set('AttValue','W99cc6',11.44);
    wdb.set('AttValue','W99cc7',0.25);
    wdb.set('AttValue','W99cc8',3.5);
    wdb.set('AttValue','W99cc9',1.5);  
    wdb.set('AttValue','ObsrvdVehs',2);
    wdb.set('AttValue','LookBackDistMax',150);
    wdb.set('AttValue','LookAheadDistMax',250);
    wdb.set('AttValue','StandDist',0.5); 

    %1-14对应14个参数
    switch i
        case 1
            for j=1:6
                wdb.set('AttValue','W99cc0',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 2
            for j=1:6
                wdb.set('AttValue','W99cc1Distr',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 3
            for j=1:6
                wdb.set('AttValue','W99cc2',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 4
            for j=1:6
                wdb.set('AttValue','W99cc3',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
        case 5
            for j=1:6
                wdb.set('AttValue','W99cc4',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 6
            for j=1:6
                wdb.set('AttValue','W99cc5',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
        case 7
            for j=1:6
                wdb.set('AttValue','W99cc6',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end
        case 8
            for j=1:6
                wdb.set('AttValue','W99cc7',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
         case 9
            for j=1:6
                wdb.set('AttValue','W99cc8',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end           
        case 10
            for j=1:6
                wdb.set('AttValue','W99cc9',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end            
         case 11
            for j=1:6
                wdb.set('AttValue','ObsrvdVehs',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
         case 12
            for j=1:6
                wdb.set('AttValue','LookBackDistMax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end     
        case 13
            for j=1:6
                wdb.set('AttValue','LookAheadDistMax',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
                    Veh_TT_measurement = Vissim.Net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
                    TT= get(Veh_TT_measurement, 'AttValue', 'TravTm(Current,Total,All)');%当前仿真，total-全部时间长度，all-所有车型
                    TT_1{i,1}(k,j)=TT;
                end
            end
        otherwise
            for j=1:6
                wdb.set('AttValue','StandDist',parametersvalue(i,j));
                for k= 1 : 3
                    set(Vissim.Simulation, 'AttValue', 'RandSeed', Random_Seed(k));
                    Vissim.Simulation.RunContinuous;
Veh_TT_attributes = Vissim.net.VehicleTravelTimeMeasurement.GetAll;%所有行程时间属性
T_travel_number = size(Veh_TT_attributes,1);
for  Veh_TT_measurement_number=1:T_travel_number
Veh_TT_measurement = Vissim.net.VehicleTravelTimeMeasurements.ItemByKey(Veh_TT_measurement_number);
TT(Veh_TT_measurement_number) = get(Veh_TT_measurement, 'AttValue', 'TravTm(Avg,Avg,All)');
end
                                  %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
                    TT_1{i,1}(k,j)=mean(TT);
                end
            end        
    end   
    PValue{i,1}=anova1(TT_1{i,1},[],'off');
                        %程序扩展：可在这里得到延误，排队长度等所有指标，最后根据用户要求选择相应的指标进行敏感性分析
    if i~=14
          results = sprintf('======== Parameters Sensitivity Analysis ========\nANOVA P-VALUE ( Travel Time ) \n W99cc0=%2.2f, W99cc1Distr=%2.2f, W99cc2 = %2.2f, W99cc3 =%2.2f, W99cc4=%2.2f,,W99cc5=%2.2f, W99cc6=%2.2f, W99cc7 = %2.2f, W99cc8 =%2.2f, W99cc9=%2.2f, ,OBSRVDVEHS=%2.2f ,LOOKBACKDISTMAX=%2.2f, LOOKAHEADDISTMAX=%2.2f,STANDDIST=%2.2f\n\nCalculating...\n'...
              ,PValue{1,1},PValue{2,1},PValue{3,1},PValue{4,1},PValue{5,1},PValue{6,1},PValue{7,1},PValue{8,1},PValue{9,1},PValue{10,1},PValue{11,1},PValue{12,1},PValue{13,1},PValue{14,1});
    else
          results = sprintf('======== Parameters Sensitivity Analysis ========\nANOVA P-VALUE ( Travel Time ) \nW99cc0=%2.2f, W99cc1Distr=%2.2f, W99cc2 = %2.2f, W99cc3 =%2.2f, W99cc4=%2.2f,,W99cc5=%2.2f, W99cc6=%2.2f, W99cc7 = %2.2f, W99cc8 =%2.2f, W99cc9=%2.2f, ,OBSRVDVEHS=%2.2f ,LOOKBACKDISTMAX=%2.2f, LOOKAHEADDISTMAX=%2.2f,STANDDIST=%2.2f\n\nEND！！！\n'...
              ,PValue{1,1},PValue{2,1},PValue{3,1},PValue{4,1},PValue{5,1},PValue{6,1},PValue{7,1},PValue{8,1},PValue{9,1},PValue{10,1},PValue{11,1},PValue{12,1},PValue{13,1},PValue{14,1});
    end
end
end


ENDResult = cell(size(PValue,1),2);  parameterlist=zeros(size(PValue,1),1);
    for i=1:size(PValue,1)
        if PValue{i,1}<=0.05
       ENDResult{i,2}= parameters{i,1}; %关键参数的名称
       ENDResult{i,1}= i; %关键参数在整个参数列表中的编号，加上paraseletag信息可得到具体的参数信息
       parameterlist(i)=i
        else
           ENDResult{i,1}= [];  
           ENDResult{i,2}= [];  
        end
    end
   parameterlist = parameterlist(parameterlist(:)~=0,1);
    save('parameterlist.mat','parameterlist');%敏感参数的序号
    disp('筛选出的关键参数如下：');
    ENDResult{:,2}





