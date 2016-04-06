function h = RemovefromListbox(h, index)
% ADDITEMTOLISTBOX - add a new items to the listbox
% H = ADDITEMTOLISTBOX(H, STRING)
% H listbox handle
% STRING a new item to display
    oldstring = get(h, 'string');
    oldstring(index) = [];
    if ~isempty(oldstring)
       set(h,'value',index-1);
       set(h,'string', oldstring);
    else
       set(h,'string',{'Empty'},'Enable','off') 
    end