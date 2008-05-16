#############################################################################
##
##  HomalgComplex.gi           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg complexes.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the category IsHomalgComplex:
DeclareRepresentation( "IsComplexOfFinitelyPresentedModulesRep",
        IsHomalgComplex,
        [  ] );

DeclareRepresentation( "IsCocomplexOfFinitelyPresentedModulesRep",
        IsHomalgComplex,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgComplexes",
        NewFamily( "TheFamilyOfHomalgComplexes" ) );

# four new types:
BindGlobal( "TheTypeHomalgComplexOfLeftModules",
        NewType( TheFamilyOfHomalgComplexes,
                IsComplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfLeftModules ) );

BindGlobal( "TheTypeHomalgComplexOfRightModules",
        NewType( TheFamilyOfHomalgComplexes,
                IsComplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfRightModules ) );

BindGlobal( "TheTypeHomalgCocomplexOfLeftModules",
        NewType( TheFamilyOfHomalgComplexes,
                IsCocomplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfLeftModules ) );

BindGlobal( "TheTypeHomalgCocomplexOfRightModules",
        NewType( TheFamilyOfHomalgComplexes,
                IsCocomplexOfFinitelyPresentedModulesRep and IsHomalgComplexOfRightModules ) );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, l;
    
    indices := C!.indices;
    
    l := Length( indices );
    
    if l = 1 then
        return IsZero( C!.( indices[1] ) );
    elif IsComplexOfFinitelyPresentedModulesRep( C ) then
        return ForAll( indices{[2..l]}, i -> IsZero( TargetOfMorphism( C!.(i) ) ) ) and IsZero( SourceOfMorphism( C!.( indices[l] ) ) );
    else
        return ForAll( indices{[1..l-1]}, i -> IsZero( SourceOfMorphism( C!.(i) ) ) ) and IsZero( TargetOfMorphism( C!.( indices[l - 1] ) ) );
    fi;
    
end );

##
InstallMethod( IsGradedObject,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, l;
    
    indices := C!.indices;
    
    l := Length( indices );
    
    if l = 1 then
        return true;
    elif IsComplexOfFinitelyPresentedModulesRep( C ) then
        return ForAll( indices{[2..l]}, i -> IsZero( C!.(i) ) );
    else
        return ForAll( indices{[1..l-1]}, i -> IsZero( C!.(i) ) );
    fi;
    
end );

##
InstallMethod( IsSequence,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, l;
    
    indices := C!.indices;
    
    l := Length( indices );
    
    if l = 1 then
        return true;
    elif IsComplexOfFinitelyPresentedModulesRep( C ) then
        return ForAll( indices{[2..l]}, i -> IsMorphism( C!.(i) ) );
    else
        return ForAll( indices{[1..l-1]}, i -> IsMorphism( C!.(i) ) );
    fi;
    
end );

##
InstallMethod( IsComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, l;
    
    if not IsSequence( C ) then
        return false;
    fi;
    
    indices := C!.indices;
    
    l := Length( indices );
    
    if l <= 2 then
        return true;
    elif IsComplexOfFinitelyPresentedModulesRep( C ) then
        if IsHomalgComplexOfLeftModules( C ) then
            return ForAll( indices{[2..l-1]}, i -> IsZero( C!.((i + 1)) * C!.(i) ) );
        else
            return ForAll( indices{[2..l-1]}, i -> IsZero( C!.(i) * C!.((i + 1)) ) );
        fi;
    else
        if IsHomalgComplexOfLeftModules( C ) then
            return ForAll( indices{[1..l-2]}, i -> IsZero( C!.(i) * C!.((i + 1)) ) );
        else
            return ForAll( indices{[1..l-2]}, i -> IsZero( C!.((i + 1)) * C!.(i) ) );
        fi;
    fi;
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return HomalgRing( C!.( C!.indices[1] ) );
    
end );

##
InstallMethod( SupportOfComplex,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    local indices, l, supp;
    
    indices := C!.indices;
    
    l := Length( indices );
    
    if l = 1 then
        return Filtered( indices, i -> not IsZero( C!.(i) ) );
    elif IsComplexOfFinitelyPresentedModulesRep( C ) then
        supp := Filtered( indices{[2..l]}, i -> not IsZero( TargetOfMorphism( C!.(i) ) ) ) - 1;
        if not IsZero( SourceOfMorphism( C!.( indices[l] ) ) ) then
            Add( supp, indices[l] );
        fi;
    else
        supp := Filtered( indices{[1..l-1]}, i -> not IsZero( SourceOfMorphism( C!.(i) ) ) );
        if IsZero( TargetOfMorphism( C!.( indices[l - 1] ) ) ) then
            Add( supp, indices[l] );
        fi;
    fi;
    
    return supp;
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep, IsHomalgMorphism ],
        
  function( C, phi )
    local indices, l;
    
    indices := C!.indices;
    
    l := Length( indices );
    
    if l = 1 then
        
        if not IsIdenticalObj( C!.( indices[1] ), TargetOfMorphism( phi ) ) then
            Error( "the unique module in the complex and the target of the new morphism are not identical\n" );
        fi;
        
        Unbind( C!.( indices[1] ) );
        
        Add( indices, indices[1] + 1 );
        
        C!.( indices[1] + 1 ) := phi;
        
    else
        
        l := indices[l];
        
        if not IsIdenticalObj( SourceOfMorphism( C!.(l) ), TargetOfMorphism( phi ) ) then
            Error( "the source of the ", l, ". morphism in the complex (i.e. the highest one) and the target of the new morphism are not identically the same module\n" );
        fi;
        
        Add( indices, l + 1 );
        
        C!.((l + 1)) := phi;
        
    fi;
    
    homalgResetFiltersOfComplex( C );
    
    return C;
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep, IsHomalgMorphism ],
        
  function( C, phi )
    local indices, l;
    
    indices := C!.indices;
    
    l := Length( indices );
    
    if l = 1 then
        
        if not IsIdenticalObj( C!.( indices[1] ), SourceOfMorphism( phi ) ) then
            Error( "the unique module in the complex and the source of the new morphism are not identical\n" );
        fi;
        
        Add( indices, indices[1] + 1 );
        
        C!.( indices[1] ) := phi;
        
    else
        
        l := indices[l - 1];
        
        if not IsIdenticalObj( TargetOfMorphism( C!.(l) ), SourceOfMorphism( phi ) ) then
            Error( "the target of the ", l, ". morphism in the complex (i.e. the highest one) and the source of the new morphism are not identically the same module\n" );
        fi;
        
        Add( indices, l + 2 );
        
        C!.((l + 1)) := phi;
        
    fi;
    
    homalgResetFiltersOfComplex( C );
    
    return C;
    
end );

####################################
#
# global functions:
#
####################################

InstallGlobalFunction( homalgResetFiltersOfComplex,
  function( C )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfComplexes ) then
        HOMALG.PropertiesOfComplexes :=
          [ IsSequence, IsComplex, IsGradedObject, IsExactSequence, IsShortExactSequence ];
    fi;
    
    for property in HOMALG.PropertiesOfComplexes do
        ResetFilterObj( C, property );
    od;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgComplex,
  function( arg )
    local nargs, C, complex, indices, left, type;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    C := rec( );
    
    if IsStringRep( arg[nargs] ) and ( arg[nargs] = "co" or arg[nargs] = "cocomplex" ) then
        complex := false;
    else
        complex := true;
    fi;
    
    if nargs > 1 and ( IsInt( arg[2] )
               or ( IsList( arg[2] ) and Length( arg[2] ) > 0 and ForAll( arg[2], IsInt ) ) ) then
        indices := [ arg[2] ];
    else
        indices := [ 0 ];
    fi;
    
    if IsHomalgModule( arg[1] ) then
        C.indices := indices;
        if IsLeftModule( arg[1] ) then
            left := true;
        else
            left := false;
        fi;
    elif IsHomalgMorphism( arg[1] ) then
        if complex then
            C.indices := [ indices[1] - 1, indices[1] ];
        else
            C.indices := [ indices[1], indices[1] + 1 ];
        fi;
        if IsHomalgMorphismOfLeftModules( arg[1] ) then
            left := true;
        else
            left := false;
        fi;
    else
        Error( "the first argument must be either a module or morphism\n" );
    fi;
    
    C.( String( indices[1] ) ) := arg[1];
    
    if complex then
        if left then
            type := TheTypeHomalgComplexOfLeftModules;
        else
            type := TheTypeHomalgComplexOfRightModules;
        fi;
    else
        if left then
            type := TheTypeHomalgCocomplexOfLeftModules;
        else
            type := TheTypeHomalgCocomplexOfRightModules;
        fi;
    fi;
    
    ## Objectify
    Objectify( type, C );
    
    return C;
    
end );

InstallGlobalFunction( HomalgCocomplex,
  function( arg )
    
    return CallFuncList( HomalgComplex, Concatenation( arg, [ "cocomplex" ] ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( o )
    local first_attribute;
    
    first_attribute := false;
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg (co)complex
        Print( " non-zero" );
        first_attribute := true;
    fi;
    
    if HasIsShortExactSequence( o ) and IsShortExactSequence( o ) then
        Print( " short exact sequence of" );
    elif HasIsExactSequence( o ) and IsExactSequence( o ) then
        if first_attribute then
            Print( " exact sequence of" );
        else
            Print( "n exact sequence of" );
        fi;
    elif HasIsComplex( o ) then
        if IsComplex( o ) then
            if IsComplexOfFinitelyPresentedModulesRep( o ) then
                Print( " complex of" );
            else
                Print( " cocomplex of" );
            fi;
        else
            if IsComplexOfFinitelyPresentedModulesRep( o ) then
                Print( " non-complex of" );
            else
                Print( " non-cocomplex of" );
            fi;
        fi;
    elif HasIsSequence( o ) then
        if IsSequence( o ) then
            if IsComplexOfFinitelyPresentedModulesRep( o ) then
                Print( " sequence of" );
            else
                Print( " co-sequence of" );
            fi;
        else
            if IsComplexOfFinitelyPresentedModulesRep( o ) then
                Print( " sequence of non-well-definded maps between" );
            else
                Print( " co-sequence of non-well-definded maps between" );
            fi;
        fi;
    else
        if IsComplexOfFinitelyPresentedModulesRep( o ) then
            Print( " \"complex\" of" );
        else
            Print( " \"cocomplex\" of" );
        fi;
    fi;
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep and IsGradedObject ],
        
  function( o )
    
    Print( "<A graded (homological) object of" );
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( " right" );
    else
        Print( " left" );
    fi;
    
    Print( " modules>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep and IsGradedObject ],
        
  function( o )
    
    Print( "<A graded (cohomological) object of" );
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( " right" );
    else
        Print( " left" );
    fi;
    
    Print( " modules>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep and IsZero ],
        
  function( o )
    
    Print( "<A zero" );
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( " right" );
    else
        Print( " left" );
    fi;
    
    Print( " complex>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep and IsZero ],
        
  function( o )
    
    Print( "<A zero" );
    
    if IsHomalgComplexOfLeftModules( o ) then
        Print( " right" );
    else
        Print( " left" );
    fi;
    
    Print( " cocomplex>" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep ],
        
  function( o )
    
    Print( "not implemented yet <--", "\n" );
    
end );

##
InstallMethod( Display,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep ],
        
  function( o )
    
    Print( "not implemented yet -->", "\n" );
    
end );

