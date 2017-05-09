function evaluationMin = GaCalib_direct(drivingBehaviorParams)
drivingBehaviorParams
    global TRAVELTIME
    global DELAY
    global QUEUEMAX
    global QUEUEMEAN
    global CAPACITY    
    global TARGET
    global tag
    global indectorweighte

	evaluation = ParamCalib_direct(drivingBehaviorParams);%ParamCalib子函数    
    evaluationMin = zeros(5,1)-1;%初始值为-1，-1表示该指标并未考虑
    if TRAVELTIME
	T_travel_error = abs(evaluation(1)-TARGET(1));%TARGET(1)
    T_travel_error
    evaluationMin(1) = mean(T_travel_error);%与260s尽可能接近
    end
    if DELAY
    DELAY_error = abs(evaluation(2)-TARGET(2));
     evaluationMin(2) = mean(DELAY_error);
    DELAY_error    
    end
    if QUEUEMAX
    QUEUEMAX_error = abs(evaluation(3)-TARGET(3));
    evaluationMin(3) = mean(QUEUEMAX_error);
    QUEUEMAX_error   
    end
    if  QUEUEMEAN
    QUEUEMEAN_error = abs(evaluation(4)-TARGET(4));
    evaluationMin(4) = mean(QUEUEMEAN_error);
    QUEUEMEAN_error       
    end
    if  CAPACITY
    CAPACITY_error = abs(evaluation(5)-TARGET(5));
    evaluationMin(5) = mean(CAPACITY_error);
    CAPACITY_error       
    end    
    evaluationMin = evaluationMin(evaluationMin(:,1)~=-1,1);  
  if tag
  evaluationMin = sum(evaluationMin.*indectorweighte)/sum(indectorweighte);
  end
  

	
    
