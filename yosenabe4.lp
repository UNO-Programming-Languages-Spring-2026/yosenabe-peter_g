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

% achieved: paths do not collide
% it turns out that the range operator can only increase, we need to flip the range incase its an empty set because of that
path(X,Y,PX,Y) :- target(X,Y,XX,Y), PX = X..XX.  % occupy all cells in the path from X to XX
path(X,Y,PX,Y) :- target(X,Y,XX,Y), PX = XX..X.
path(X,Y,X,PY) :- target(X,Y,X,YY), PY = Y..YY.  % occupy all cells in the path from Y to YY
path(X,Y,X,PY) :- target(X,Y,X,YY), PY = YY..Y.  % occupy all cells in the path from Y to YY

:- path(X1,Y1,PX,PY), path(X2,Y2,PX,PY), (X1,Y1) != (X2,Y2). % disallow collisions in paths


#show target/4.