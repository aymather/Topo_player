% Validation for Create Montage Frame Quadrant
function bool = checkCreateMontageFrame(file, timeStart, timeEnd, name)

    if exist(file, 'file') == 2 && ... 
       ~isnan(timeStart) && ...
       ~isnan(timeEnd) && ...
       ischar(name)
        
        bool = 1;
        
    else
        
        bool = 0;
        
    end

end