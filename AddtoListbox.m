function h = AddtoListbox(h, newitem)
% ADDITEMTOLISTBOX - add a new items to the listbox
% H = ADDITEMTOLISTBOX(H, STRING)
% H listbox handle
% STRING a new item to display
    set(h,'Enable','on');
    oldstring = get(h, 'string');
    if isempty(oldstring) || strcmp(oldstring{1},{'Empty'})
        newstring = {newitem};
    elseif ~iscell(oldstring)
        newstring = {oldstring newitem};
    else
        newstring = {oldstring{:} newitem};
    end
    set(h, 'string', newstring);