% Validator for Stage Individual Frames Quadrant
function bool = checkIFrame(time, title)
    if ~isnan(time) && ~mod(time,2) && ischar(title)
        bool = 1; 
    else
        bool = 0;
    end
end
