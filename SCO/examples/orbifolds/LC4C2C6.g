# Line with C2-iso, C4 to the left, C6 to the right

M := [ [1,2], [2,3] ];
C2 := Group( [[-1,0],[0,-1]] );
C4 := Group( [[0,1],[-1,0]] );
C6 := Group( [[1,-1],[1,0]] );
iso := rec( 1 := C4, 2 := C2, 3 := C6 );
mu := [];
dim := 5;

#----------------------------------------------->>>>  Z^(1 x 1)
#----------------------------------------------->>>>  0
#----------------------------------------------->>>>  Z/< 12 >
#----------------------------------------------->>>>  0
#----------------------------------------------->>>>  Z/< 12 >
#----------------------------------------------->>>>  0
