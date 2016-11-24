module Control.Poly (
      PolyBind
    , MonoBind
    , PolyApplicative(..)
    , PolyMonad
    , polyBind
    , polyJoin
) where

import Control.Applicative.Poly (MonoBind, PolyBind, PolyApplicative(..))
import Control.Monad.Poly       (PolyMonad(..), polyBind, polyJoin)
