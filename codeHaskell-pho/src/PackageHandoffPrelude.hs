
{- | Common Data-Structures and Functions. -}

{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}
{-# LANGUAGE GADTs                     #-}
module PackageHandoffPrelude where
import Diagrams.Prelude
import qualified Data.Map as Map

type Speed       = Double  -- | ∈ [0,1]
type Fuel        = Double  -- | ≥ 0
type Time        = Double  -- | ≥ 0
type PackageIdx  = Int     -- | ≥ 0 
type RobotIdx    = Int     -- | >= 0
type PackageList = [PackageIdx]

data Package = Package { source :: Point V2 Double,
                         target :: Point V2 Double 
                       } deriving (Show)

data Robot = Robot { initPosition :: Point V2 Double, 
                     speed        :: Speed          ,
                     fuel         :: Fuel           ,       
                     schedule     :: Trajectory  
                   } deriving (Show)

{- | World consists of only robots and packages. -}
data World = World { robots      :: [ Robot  ] ,    
                     packages    :: [ Package]
                   } deriving (Show) 
             
{- | Load carried across a link of the trajectory. -} 
data Load =  -- | Single package load, possibly give to RobotIdx inside Maybe functor  
             SinglePackage      (   Package     , Maybe RobotIdx )    
             -- | Multi-package load, possibly give each to RobotIdx inside Maybe functor 
           | MultiplePackage    [ ( PackageList   , Maybe RobotIdx ) ]  
             -- | Zero Load, nothing to give!
           | Nil                                                      
             deriving (Show)

 {- | A single link of the trajectory -}
data Link = Link { segment :: ()  , 
                   load    :: Load
                 } deriving (Show)

{- | Schedule for a single robot.-} 
data Trajectory  = Trajectory [ Link ]  
                    deriving (Show)

{- | Schedule for a collection of robots. In one-one 
      correspondence with the robots list of the World -}
type Schedule    = [ Trajectory ]
