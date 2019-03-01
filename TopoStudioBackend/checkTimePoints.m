% Finds the nearest values to what the user asked for in ms.
% The user may ask for, say, a time window of 55 - 66 ms, but
% if there is no frame that captures at 55 ms, but there IS one
% at 56 ms, then it will adjust to 56 ms instead and display 
% to the user what it's using instead.
function correctedPoints = checkTimePoints(points, points2check)

    correctedPoints = [];
    for it = 1:length(points2check)
        
        [~, index] = min(abs(points - points2check(it)));
        correctedPoints = horzcat(correctedPoints, points(index));
        if points2check(it) ~= points(index)
            disp(['Time point ' num2str(points2check(it)) 'ms does not exist as a frame, using ' num2str(points(index)) 'ms instead.']);
        end
        
    end
    
end