{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

module Control.Monad.Shuffle (
      Shuffle(..)
    , shuffleJoin
    , ($>>=)
    , deepBind
    ) where

import Control.Applicative.Poly (PolyBind)
import Control.Monad      (join)
import Control.Monad.Poly
import Prelude

class Shuffle m1 m2 where
    shuffle :: m1 (m2 a) -> m2 (m1 a)

shuffleJoin :: (Shuffle n1 m2, PolyMonad m1 m2, PolyMonad n1 n2, Functor m1, Functor mout, mout ~ PolyBind m1 m2, nout ~ PolyBind n1 n2)
            => m1 (n1 (m2 (n2 a))) -> mout (nout a)
shuffleJoin = fmap polyJoin . polyJoin . fmap shuffle

infixl  1 $>>=

($>>=) :: (Monad m, Monad t, Shuffle m t) => m a -> (a -> t (m b)) -> t (m b)
a $>>= b = return a `deepBind` b

deepBind :: (Monad m, Monad t, Shuffle m t) => t (m a) -> (a -> t (m b)) -> t (m b)
deepBind tma f = tma >>= mf
    where mf ma = fmap join . shuffle $ do
              a <- ma
              return $ f a

instance (Monad m, Functor m) => Shuffle (Either e) m where
    shuffle = \case
        Left  e -> return $ Left e
        Right a -> fmap Right a
