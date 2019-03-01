% Gets all available frame points based on your sample rate
% and number of frames. Assumes that we start at time point
% zero as column 1 of your data matrix.
function availablePoints = getAvailableTimePoints(srate, numframes)

    sampleLatency = (1000 / srate);
    totalTime = sampleLatency * numframes;
    adjustedTotalTime = totalTime - sampleLatency;
    availablePoints = 0:sampleLatency:adjustedTotalTime;

end