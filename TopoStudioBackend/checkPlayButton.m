function bool = checkPlayButton(movie)

    if exist(movie, 'file') == 2
        bool = 1;
    else
        bool = 0;
    end
    
end