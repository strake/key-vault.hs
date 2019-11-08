module Data.Vault.Identity where

import Control.Monad.Trans.Key (Key)
import Data.Coerce (coerce)
import Data.Functor.Identity (Identity (..))

import qualified Data.Vault as V

type Vault s = V.Vault s Identity

adjustA :: Applicative p => (a -> p a) -> Key s a -> Vault s -> p (Vault s)
adjustA f = V.adjustA (fmap coerce . f . coerce)

alterF :: (Functor f) => (Maybe a -> f (Maybe a)) -> Key s a -> Vault s -> f (Vault s)
alterF f = V.alterF (fmap coerce . f . coerce)
