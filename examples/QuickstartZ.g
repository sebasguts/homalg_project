##  <#GAPDoc Label="QuickstartZ">
##  <Section Label="QuickstartZ">
##  <Heading>Localization of &ZZ;</Heading>
##    We localize at the maximal ideal in Z generated by 2 and construct this short exact sequence:
##  <P/><Alt Not="Text,HTML"><Math>0 \longrightarrow M\_=&ZZ;/2^2&ZZ; \stackrel{\alpha_1}{\longrightarrow} M=&ZZ;/2^5&ZZ; \stackrel{\alpha_2}{\longrightarrow} \_M=&ZZ;/2^3&ZZ; \longrightarrow 0</Math></Alt><Alt Only="Text,HTML"><M>0 -> M_=&ZZ;/2^2&ZZ; --alpha_1--> M=&ZZ;/2^5&ZZ; --alpha_2--> \_M=&ZZ;/2^3&ZZ; -> 0</M></Alt>
##  <P/>We want to lead your attention to the commands <K>LocalizeAt</K> and <K>HomalgLocalMatrix</K>. The first one creates a localized ring from a global one and generators of a maximal ideal and the second one creates a local matrix from a global matrix. The other commands used here are well known from &homalg;.
##  <Example>
##    <![CDATA[
##  gap> LoadPackage( "LocalizeRingForHomalg" );;
##  gap> ZZ := HomalgRingOfIntegers(  );;
##  gap> R := LocalizeAt( ZZ , [ 2 ] );
##  <A homalg local ring>
##  gap> M := LeftPresentation( HomalgLocalMatrix( HomalgMatrix( [ 2^5 ], ZZ ) , R ) );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> _M := LeftPresentation( HomalgLocalMatrix( HomalgMatrix( [ 2^3 ], ZZ ) , R ) );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> alpha2 := HomalgMap( HomalgLocalMatrix( HomalgMatrix( [ 1 ] , ZZ ) , R ) , M, _M );
##  <A "homomorphism" of left modules>
##  gap> M_ := Kernel( alpha2 );
##  <A cyclic left module presented by an unknown number of relations for a cyclic\
##   generator>
##  gap> alpha1 := KernelEmb( alpha2 );
##  <A monomorphism of left modules>
##  gap> Display( M_ );
##  Z_<2>/< -4/1 >
##  gap> Display( alpha1 );
##  [ [  24 ] ]
##  / 1
##  
##  the map is currently represented by the above 1 x 1 matrix
##  gap> ByASmallerPresentation( M_ );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> Display( M_ );
##  Z_<2>/< 4/1 >
##  
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>

LoadPackage( "LocalizeRingForHomalg" );;

ZZ := HomalgRingOfIntegers(  );;

R := LocalizeAt( ZZ , [ 2 ] );

M := LeftPresentation( HomalgLocalMatrix( HomalgMatrix( [ 2^5 ], ZZ ) , R ) );
_M := LeftPresentation( HomalgLocalMatrix( HomalgMatrix( [ 2^3 ], ZZ ) , R ) );

alpha2 := HomalgMap( HomalgLocalMatrix( HomalgMatrix( [ 1 ] , ZZ ) , R ) , M, _M );
M_ := Kernel( alpha2 );
alpha1 := KernelEmb( alpha2 );

Display( M_ );
Display( alpha1 );

ByASmallerPresentation( M_ );
Display( M_ );
