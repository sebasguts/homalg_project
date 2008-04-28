#############################################################################
##
##  GAPHomalgDefault.gi       RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the external rings provided by the GAP package homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForGAPDefault,
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   homalgSendBlocking( [ N, " := BasisOfRowModule( ", M, " )" ], "need_command" );
                   
                   return N;
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, U )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   homalgSendBlocking( [ N, " := BasisOfRowsCoeff(", M, U, ")" ], "need_command" );
                   
                   return N;
                   
                 end,
                 
               DecideZeroRows :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := DecideZeroRows(", A, B, ")" ], "need_command" );
                   
                   return N;
                   
                 end,
                 
               DecideZeroRowsEffectively :=
                 function( A, B, U )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := DecideZeroRowsEffectively(", A, B, ")" ], "need_command" );
                   
                   return N;
                   
                 end,
                 
               SyzygiesGeneratorsOfRows :=
                 function( arg )
                   local M, R, N, M2;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), R );
                   
                   if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
                       
                       M2 := arg[2];
                       
                       homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfRows(", M, M2, ")" ], "need_command" );
                       
                   else
                       
                       homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfRows( ", M, " )" ], "need_command" );
                       
                   fi;
                   
                   return N;
                   
                 end,
                 
               BasisOfColumnModule :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ N, " := BasisOfColumnModule( ", M, " )" ], "need_command" );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, U )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ N, " := BasisOfColumnsCoeff(", M, U, ")" ], "need_command" );
                   
                   return N;
                   
                 end,
                 
               DecideZeroRows :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := DecideZeroRows(", A, B, ")" ], "need_command" );
                   
                   return N;
                   
                 end,
                 
               DecideZeroRowsEffectively :=
                 function( A, B, U )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := DecideZeroRowsEffectively(", A, B, ")" ], "need_command" );
                   
                   return N;
                   
                 end,
                 
               SyzygiesGeneratorsOfColumns :=
                 function( arg )
                   local M, R, N, M2;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", R );
                   
                   if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
                       
                       M2 := arg[2];
                       
                       homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfColumns(", M, M2, ")" ], "need_command" );
                       
                   else
                       
                       homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfColumns( ", M, " )" ], "need_command" );
                       
                   fi;
                   
                   return N;
                   
                 end,
                 
        )
 );
