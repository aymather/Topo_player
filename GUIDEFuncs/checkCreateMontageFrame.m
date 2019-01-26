% Validation for Create Montage Frame Quadrant
function bool = checkCreateMontageFrame(file, timeStart, timeEnd, name)

    if exist(file, 'file') == 2 && ... 
       ~isnan(timeStart) && ...
       ~isnan(timeEnd) && ...
       ~mod(timeStart,2) && ... 
       ~mod(timeEnd,2) && ...
       ischar(name)
        
        bool = 1;
        
    else
        
        bool = 0;
        
    end

end