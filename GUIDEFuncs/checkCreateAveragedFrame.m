% Validation for Create Averaged Frame Quadrant
function bool = checkCreateAveragedFrame(data, chanlocs, timeStart, timeEnd, name)

    if exist(data, 'file') == 2 && ...
       exist(chanlocs, 'file') == 2 && ...
       ~isnan(timeStart) && ...
       ~isnan(timeEnd) && ...
       ~mod(timeStart, 2) && ...
       ~mod(timeEnd, 2) && ...
       ischar(name)
        
        bool = 1;
   
    else
        
        bool = 0;
        
    end
    
end