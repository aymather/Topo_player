% Validator function
function bool = checkIFrame(cTime, title)
    if ~isnan(cTime) && ~mod(cTime,2) && ischar(title)
        bool = 1; 
    else
        bool = 0;
        str = 'Invalid inputs!';
        str = [str newline 'Both a title and a capture time are required'];
        str = [str newline 'Capture Time must be an even number and not contain any special characters including spaces.'];
        warning(str);
    end
end
