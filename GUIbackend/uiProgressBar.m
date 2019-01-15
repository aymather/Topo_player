function h = uiProgressBar(settings,varargin)

    if ishandle(varargin{1}) && size(varargin, 2) > 1
        ax = varargin{1};
        value = varargin{2};
        p = get(ax,'Child');
        x = get(p,'XData');
        x(3:4) = value;
        set(p,'XData',x)
        return
    end

    bg_color = 'white';
    fg_color = 'blue';
    outline_color = 'black';
    h = axes('Units','Normalized',...
        'Position',settings.positions.pbar,...
        'XLim',[0 1],'YLim',[0 1],...
        'XTick',[],'YTick',[],...
        'Box','on', ...
        'Color',bg_color,...
        'XColor',outline_color,'YColor',outline_color, ...
        'Parent', varargin{1});
    patch([0 0 0 0],[0 1 1 0],fg_color,...
        'Parent',h,...
        'EdgeColor','black');
    
end