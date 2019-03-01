% Validator for Stage Custom Frames Quadrant
function bool = checkCFrame(time, title, file)
    if ~isnan(time) && ischar(title) && exist(file, 'file') == 2
        bool = 1;
    else
        bool = 0;
    end
end