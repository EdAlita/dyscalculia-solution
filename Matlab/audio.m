clc
clear all
close all
warning off
Fs=8000;%Sampling frequency in hertz
ch=2;%Number of channels--2 options--1 (mono) or 2 (stereo)
datatype='uint8';
nbits=16;%8,16,or 24
Nseconds=8;
for repetition=1:1:3
        pause('on');
        pause;
        % to record audio data from an input device ...
        ...such as a microphone for processing in MATLAB
        recorder=audiorecorder(Fs,nbits,ch);
        disp('Start speaking..')
        %Record audio to audiorecorder object,...
        ...hold control until recording completes
        recordblocking(recorder,Nseconds);
        disp('End of Recording.');
        %Store recorded audio signal in numeric array
        x=getaudiodata(recorder,datatype);
        %Write audio file
        audiowrite('operaciones.wav',x,Fs);
        [y,fs] = audioread('operaciones.wav');
        speechObject = speechClient('Google','languageCode','en-US')
        y1=y(:,1);
        tableOut = speech2text(speechObject,y1,Fs);
        t1=table2array(tableOut);
        lon=length(t1(:,1));
        str="";
        for a=1:1:lon
            res=t1(a,1)
            str=strcat(str,res);
        end
        if strfind(str,'recover')>=1
            ub=[20,-103]
            ub=sqrt((20^2)+(103^2))
            sto=readtable('database.csv')
            sto1=table2array(sto(:,1));
            sto2=table2array(sto(:,3));
            sto3=table2array(sto(:,4));
            retri=strings(3,1);
            d=1;
            for a=1:1:height(sto)
                ub2=(sto2(a,1)^2)+(sto3(a,1)^2)
                ub2=sqrt(ub2)
                if (ub2-ub)<=0.5856
                    retri(d,1)=char(sto1(a,1))
                    d=d+1;
                    NET.addAssembly('System.Speech');
                    obj = System.Speech.Synthesis.SpeechSynthesizer;
                    obj.Volume = 100;
                    Speak(obj, char(sto1(a,1)));
                end
            end
        end
        if strfind(str,'remember')>=1
            msj=split(str);
            str1='';
            for a=2:1:length(msj)-1
                res=msj(a,1);
                str1=strcat(str1,res," ");
            end
            str1
            tstamp=datetime('now')
            sto=readtable('database.csv')
            sto1=height(sto)+2
            strcat('A',num2str(sto1))
            str2=[str1,datestr(tstamp)]
            xlswrite('database.csv',str2,1,strcat('A',num2str(sto1)))
        end
        if strfind(str,'Remember')>=1
            msj=split(str);
            str1='';
            for a=2:1:length(msj)-1
                res=msj(a,1);
                str1=strcat(str1,res," ");
            end
            str1
            tstamp=datetime('now')
            sto=readtable('database.csv')
            sto1=height(sto)+2
            strcat('A',num2str(sto1))
            str2=[str1,datestr(tstamp)]
            xlswrite('database.csv',str2,1,strcat('A',num2str(sto1)))
        end
        if strfind(str,'operation')>=1
            num1=split(str);
            num1=num1(2,1);
            num1=str2num(num1);
            num2=split(str);
            num2=num2(4,1);
            num2=str2num(num2);
            if strfind(str,'/')>1
              mid=strfind(str,'/');
              interm=num1/num2
            end
            if strfind(str,'*')>1
              interm=num1*num2
            end
            if strfind(str,'x')>1
              interm=num1*num2
            end
            if strfind(str,'+')>1
              interm=num1+num2
            end
            if strfind(str,'-')>1
              interm=num1-num2
            end
        end
        if strfind(str,'Operation')>=1
            num1=split(str);
            num1=num1(2,1);
            num1=str2num(num1);
            num2=split(str);
            num2=num2(4,1);
            num2=str2num(num2);
            if strfind(str,'/')>1
              mid=strfind(str,'/');
              interm=num1/num2
            end
            if strfind(str,'*')>1
              interm=num1*num2
            end
            if strfind(str,'x')>1
              interm=num1*num2
            end
            if strfind(str,'+')>1
              interm=num1+num2
            end
            if strfind(str,'-')>1
              interm=num1-num2
            end
        end
        if strfind(str,'save')>=1
            msj=split(str);
            str1=strcat("The last result is: ",num2str(interm)," ");
            for a=2:1:length(msj)-1
                res=msj(a,1);
                str1=strcat(str1,res," ");
            end
            str1
            tstamp=datetime('now')
            sto=readtable('database.csv')
            sto1=height(sto)+2
            strcat('A',num2str(sto1))
            str2=[str1,datestr(tstamp)]
            xlswrite('database.csv',str2,1,strcat('A',num2str(sto1)))
        end
        if strfind(str,'Save')>=1
            msj=split(str);
            str1=strcat("The last result is: ",num2str(interm)," ");
            for a=2:1:length(msj)-1
                res=msj(a,1);
                str1=strcat(str1,res," ");
            end
            str1
            tstamp=datetime('now')
            sto=readtable('database.csv')
            sto1=height(sto)+2
            strcat('A',num2str(sto1))
            str2=[str1,datestr(tstamp)]
            xlswrite('database.csv',str2,1,strcat('A',num2str(sto1)))
        end
end