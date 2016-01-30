{-# LANGUAGE UndecidableInstances #-}

module Control.Monad.Poly (module Control.Monad.Poly, module X) where

import Prelude
import Control.Applicative.Poly
import Control.Applicative.Poly as X (PolyBind, MonoBind)

-- === Types ===

class                                               PolyApplicative m n  => PolyMonad m n where (>>>=) :: m a -> (a -> n b) -> PolyBind m n b
instance {-# OVERLAPPABLE #-} (Monad m, MonoBind m, PolyApplicative m m) => PolyMonad m m where (>>>=) = (>>=)


-- === Utils ===

polyBind :: PolyMonad m n => m a -> (a -> n b) -> PolyBind m n b
polyBind = (>>>=)

polyJoin :: PolyMonad m n => m (n a) -> PolyBind m n a
polyJoin = (>>>= id)

