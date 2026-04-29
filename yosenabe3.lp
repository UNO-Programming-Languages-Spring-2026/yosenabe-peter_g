% Goal 1 -> move all given cell(x,y) to target(x,y,xx,y) or target(x,y,x,yy), s.t. it is within an area
% an area is marked with some number pair x,y, and its associated area number n -> area(x,y,n)
% some area n is a contiguous block allocation, and an area n can also have a goal number such that some cells
% number(x,y,v) sum up to the goal number.

% achieved: for some cell x,y we need to choose some area s.t. the cell moves only in one direction to that area.
{ target(X, Y, XX, Y) : area(XX, Y, _) % is the _ allowing for nonexistent areas?
; target(X, Y, X, YY) : area(X, YY, _) } = 1 :- number(X,Y,_). % for every cell, choose a target

% define occupied(X,Y,N) true if theere is some target that moves a number(X,Y,V) to area(X1,Y1,N) 
occupied(X1,Y1,N) :- target(X,Y,X1,Y1), area(X1,Y1,N).

% achieved: every area has at least one target st it is occupied by at least one number
:- area(_,_,N), not occupied(_,_,N). % skip if there is an area that is not occupied



#show target/4.