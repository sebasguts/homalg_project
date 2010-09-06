#############################################################################
##
##  LIHOM.gi                    LIHOM subpackage             Mohamed Barakat
##
##         LIHOM = Logical Implications for homalg module HOMomorphisms
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIHOM subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIHOM,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties := LIMOR.intrinsic_properties,
            intrinsic_attributes := LIMOR.intrinsic_attributes,
            )
        );

Append( LIHOM.intrinsic_properties,
        [ 
          ] );

Append( LIHOM.intrinsic_attributes,
        [ 
          ] );

##
InstallValue( LogicalImplicationsForHomalgMaps,
        [ 
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgSelfMaps,
        [ 
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgMaps, IsHomalgMap );

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgSelfMaps, IsHomalgSelfMap );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsMapOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    
    if HasIsZero( MatrixOfMap( phi ) ) and IsZero( MatrixOfMap( phi ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsMapOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    local index_pair, matrix;
    
    index_pair := PairOfPositionsOfTheDefaultPresentations( phi );
    
    if IsBound( phi!.reduced_matrices.( String( index_pair ) ) ) then
        
        matrix := phi!.reduced_matrices.( String( index_pair ) );
        
        if HasIsZero( matrix ) then
            return IsZero( matrix );
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "LIHOM: for homalg module homomorphisms",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsZero( MatrixOfMap( DecideZero( phi ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "LIHOM: for homalg module homomorphisms",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfRelations( Source( phi ) ) * MatrixOfMap( phi );
    
    return IsZero( DecideZero( mat, Range( phi ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "LIHOM: for homalg module homomorphisms",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfMap( phi ) * MatrixOfRelations( Source( phi ) );
    
    return IsZero( DecideZero( mat, Range( phi ) ) );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( ImageSubobject,
        "LIHOM: submodule constructor",
        [ IsHomalgMap ],
        
  function( phi )
    local T, R, ideal, N;
    
    T := Range( phi );
    
    R := HomalgRing( T );
    
    ideal := IsBound( T!.distinguished ) and T!.distinguished = true and
             IsBound( T!.not_twisted ) and T!.not_twisted = true;
    
    N := rec(
             ring := R,
             map_having_subobject_as_its_image := phi
             );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgLeftFinitelyGeneratedSubmodule,
                ConstructedAsAnIdeal, ideal,
                LeftActingDomain, R );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgRightFinitelyGeneratedSubmodule,
                ConstructedAsAnIdeal, ideal,
                RightActingDomain, R );
    fi;
    
    ## immediate methods will check if they can set
    ## SetIsTorsionFree( N, true ); and SetIsTorsion( N, true );
    ## by checking if the corresponding property for T is true
    
    return N;
    
end );

##
InstallMethod( KernelSubobject,
        "LIHOM: for homalg module homomorphisms",
        [ IsHomalgMap ],
        
  function( psi )
    local S, ker, T;
    
    S := Source( psi );
    
    if HasIsMonomorphism( psi ) and IsMonomorphism( psi ) then
        ker := ZeroSubobject( S );
    else
        ker := Subobject( ReducedSyzygiesGenerators( psi ), S );
    fi;
    
    T := Range( psi );
    
    if HasRankOfObject( S ) and HasRankOfObject( T ) then
        if RankOfObject( T ) = 0 then
            SetRankOfObject( ker, RankOfObject( S ) );
        fi;
    fi;
    
    if HasRankOfObject( ker ) and
       RankOfObject( ker ) = NrGenerators( ker ) then
        SetIsFree( ker, true );
    fi;
    
    return ker;
    
end );

