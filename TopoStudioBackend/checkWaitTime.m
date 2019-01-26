% Validation for Wait Time input
function bool = checkWaitTime(time)

    if ~isnan(time) && isa(time, 'double')
        bool = 1;
    else
        bool = 0;
    end

end