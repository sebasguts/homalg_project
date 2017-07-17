#############################################################################
##
##                                                     ToolsForHomalg package
##
##  Copyright 2017, Sebastian Gutsche, University of Siegen
##
##
#############################################################################

DeclareInfoClass( "DeprecatedSynonymInfoClass" );

SetInfoLevel( DeprecatedSynonymInfoClass, 1 );

#! @Arguments name,value
#! @Description
#!  Sets <A>name</A> as a synonym for <A>value</A>. When <A>name</A>
#!  is called the first time a warning that <A>name</A> is deprecated is displayed.
DeclareGlobalFunction( "DeclareDeprecatedSynonym" );

#! @Arguments
#! @Description
#!  Disables deprecation warnings.
DeclareGlobalFunction( "DisableDeprecationWarning" );

#! @Arguments
#! @Description
#!  Enables deprecation warnings.
DeclareGlobalFunction( "EnableDeprecationWarning" );
