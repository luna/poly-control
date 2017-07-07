module Control.Applicative.Poly where

import Prelude
import Control.Applicative


-- == Types ===

type family PolyBind (m :: * -> *) (n :: * -> *) :: * -> *
type MonoBind m = (PolyBind m m ~ m)

class                                                        PolyApplicative m n where (<<*>>) :: m (a -> b) -> n a -> PolyBind m n b
instance {-# OVERLAPPABLE #-} (MonoBind m, Applicative m) => PolyApplicative m m where (<<*>>) = (<*>)


--(<<$>>) :: (Applicative m, PolyApplicative m n) => (a -> b) -> n a -> PolyBind m n b
--f <<$>> a = pure f <<*>> a