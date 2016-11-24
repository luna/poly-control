module Control.Applicative.Poly (
      PolyBind
    , MonoBind
    , PolyApplicative(..)
    ) where

import Prelude


-- == Types ===

type family PolyBind (m :: * -> *) (n :: * -> *) :: * -> *
type MonoBind m = (PolyBind m m ~ m)

class                                                        PolyApplicative m n where (<<*>>) :: m (a -> b) -> n a -> PolyBind m n b
instance {-# OVERLAPPABLE #-} (MonoBind m, Applicative m) => PolyApplicative m m where (<<*>>) = (<*>)
