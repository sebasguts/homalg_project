#############################################################################
##
##                                                     ToolsForHomalg package
##
##  Copyright 2017, Sebastian Gutsche, University of Siegen
##
##
#############################################################################

InstallGlobalFunction( EnableDeprecationWarning,
  function( )
    SetInfoLevel( DeprecatedSynonymInfoClass, 1 );
end );

InstallGlobalFunction( DisableDeprecationWarning,
  function( )
    SetInfoLevel( DeprecatedSynonymInfoClass, 0 );
end );

InstallGlobalFunction( DeclareDeprecatedSynonym,
  function( name, value )
    BindGlobal( name,
      function( arg... )
        local return_val;
        Info( DeprecatedSynonymInfoClass, 1, Concatenation( "Warning: ", name, " is deprecated, use ", NameFunction( value ), " instead." ) );
        MakeReadWriteGlobal( name );
        UnbindGlobal( name );
        BindGlobal( name, value );
        return_val := CallFuncListWrap( value, arg );
        if Length( return_val ) > 0 then
            return return_val[ 1 ];
        else
            return;
        fi;
    end );
end );
