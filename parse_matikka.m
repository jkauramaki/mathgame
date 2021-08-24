function parse_matikka(input_filename)
% Parse and check equations for Puusepp et al. (2021) https://doi.org/10.3389/fpsyg.2021.635972
% math task
% 
% 2021-08-24 simple wrapper to function
% 2019-08-21 initial version by jaakko.kauramaki@helsinki.fi


if nargin<1
  input_filename=['scen' filesep 'matikka-helpot.txt'];
end
fid = fopen(input_filename);
C = textscan(fid, '%s');
fclose(fid);
all_ok=true;

for i=1:numel(C{1})
    line=C{1}{i};
    if contains(line,'+')
        oper='+';
    elseif contains(line,'-')
        oper='-';
    elseif contains(line,':')
        oper=':';
    elseif contains(line,'*')
        oper='*';
    else
        oper='?';
    end
    
    oper_pos=strfind(line,oper);
    equal_pos=strfind(line,'=');
    num1=line(1:oper_pos-1);
    num2=line(oper_pos+1:equal_pos-1);
    res=line(equal_pos+1:end);
    
    if strfind(line,'o')>0 % check whether this is a parsing line
        priming_eq_correct=true;
    elseif strfind(line,'v')>0
        priming_eq_correct=false;
    else
        % parse line
        switch oper
            case '+'
                if str2double(num1)+str2double(num2)==str2double(res)
                    eq_correct=true;
                else
                    eq_correct=false;
                end
            case '-'
                if str2double(num1)-str2double(num2)==str2double(res)
                    eq_correct=true;
                else
                    eq_correct=false;
                end
            case ':'
                if str2double(num1)/str2double(num2)==str2double(res)
                    eq_correct=true;
                else
                    eq_correct=false;
                end
            case '*'
                if str2double(num1)*str2double(num2)==str2double(res)
                    eq_correct=true;
                else
                    eq_correct=false;
                end
            otherwise 
                disp(['error in operator, eq. "' line '"']);
        end
        
        
        if eq_correct==priming_eq_correct
            %disp(['eq. "' line '" ok']);
        else
            all_ok=false;
            disp(['*** eq. "' line '" NOT OK, priming eq "' last_line '"']);
        end
        
        % check how many identical numbers compared to last line
        num_eq=0;
        if str2double(last_num1)==str2double(num1), num_eq=num_eq+1; end
        if str2double(last_num2)==str2double(num2), num_eq=num_eq+1; end
        if str2double(last_res)==str2double(res), num_eq=num_eq+1; end
        if num_eq<2
            disp(['*** eq. "' line '" NOT OK, too dissimilar to "' last_line '"']);
            all_ok=false;
        end

    end
    
    % store previously parsed line + operators
    last_line=line;
    last_num1=num1;
    last_num2=num2;
    last_res=res;
    %last_oper=oper; % not actually used in this version..
end

if all_ok
    disp(['all equations (N=' num2str(numel(C{1})) ') seem ok']);
else
    disp('some issues with equations');
end