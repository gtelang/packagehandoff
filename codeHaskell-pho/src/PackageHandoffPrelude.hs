
{- | Common Data-Structures and Functions. -}

{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}
{-# LANGUAGE GADTs                     #-}
module PackageHandoffPrelude where
import Diagrams.Prelude hiding (Color)
import Graphics.Gloss.Data.Color

type Packages a  = [Package a]

data Package a = Package { source :: Point V2 a,
                           target :: Point V2 a,
                           color  :: Color
                         } deriving (Show)

data Robot a = Robot { initPosition :: Point V2 a
                   } deriving (Show)

{- | World consists of only robots and packages. -}
data World a = World { robots   :: [Robot a],
                       packages :: [Package a]
                      } deriving (Show)

{- | Load carried across a link of the trajectory along with a description of
 the exchanges which take place at the link's head. -}
data Load a =  -- Single package load, possibly give to the Robot inside Maybe functor
             SPack (Package a, Maybe (Robot a))
             -- Multi-package load, possibly give each to the Robot inside Maybe functor
           | MPack [([Package a], Maybe (Robot a))]
             -- Zero Load, nothing to give to anybody!
           | Nil
             deriving (Show)

 {- | A single link of the trajectory -}
data Link a = Link { head :: Point V2 a,
                     load :: Load a,
                     waitTimeAtHead  :: Double
                    } deriving (Show)

{- | Schedule for a single robot.-}
data Trajectory a = Trajectory [ Link a ]
                    deriving (Show)

{- | Schedule for a collection of robots. In one-one
      correspondence with the robots list of the World -}
type Schedule a  = [ Trajectory a ]
