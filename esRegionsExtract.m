function [RF] = esRegionsExtract(data)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

%constants definition
step=100;
framesize=200;
coefficient=1;
NL=5000;


%input the left and right boundaries of channels. For example, if 
%channel 1-306 is MEG and 307-327 is EEG, then chan_index=[1,306] if you
%want to analyse MEG and chan_index=[307,327] if you want to analyze EEG.
chan_index=[1,306]; 




fprintf('\n################  Initiate FD_Analysis module ################\n\n')
[regions] = FD_Analysis(framesize,step,chan_index,data,coefficient); %first run of FD_Analysis

fprintf('\n################  breaking bigger regions... ################\n\n') 
i=1; %FD will be recursively run multiple times until all bigger regions 
while i<=size(regions,1)
    tl=regions(i,1);
    tr=regions(i,2);
    if tr-tl>=NL       
        regions(i,:)=[];
        [rt] = FD_Analysis(framesize,step,chan_index,data(:,tl:tr),coefficient);
        regions=[regions;rt+tl];
        continue
    end
    i=i+1;
end

RF=[];
fprintf('\n################  FD analysis done! Initiate SCSA analysis ################\n\n')
Nregion=size(regions,1);

if regions(1,1)<=framesize*2
    regions(1,:)=[];   %eliminate corner case
end

for k=1:Nregion %start iterating regions
    sta=regions(k,1);
    sto=regions(k,2);
    le=sta;
    ri=sta+framesize;
    cot=0;
    while ri<sto||cot==0
    cot=cot+1;
    tempR=data(chan_index(1):chan_index(2),max(1,le-2*framesize):min(ri,size(data,2)));
    if(SCSASpikeDetect(tempR,framesize,sta,sto))
        if GTCompare(GT,[sta,sto])
            RF=[RF;[sta,sto]];
            break     
        end    
    end
    le=le+step;
    ri=ri+step;    
    end    
end


end

