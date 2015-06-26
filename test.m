for i=1:1000
    miss_asim(i)=sum(conflict_out(i,17:199))';
end
input_asim=conflict_out_original';
[input_asim,inputs_asim]=mapminmax(input_asim);
[output_asim,outputs]=mapminmax(miss_asim);
an_asim=sim(net,input_asim);
% an_asim1=sim(net1,input_asim);
an_asim=mapminmax('reverse',an_asim,outputs_asim);
k=0;
for i=1:1000
   if miss_asim(i)~=0    
       k=k+1; 
       error_asim(k) = abs((an_asim(i)-miss_asim(i)))/abs((miss_asim(i)));
   end
end
sumerror_asim = sum(error_asim);
avgerror_asim=sumerror_asim/k;
plot(an_asim,'r');
hold on;
plot(miss_asim,'b');
hold off;