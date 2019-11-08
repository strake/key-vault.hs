module Data.Vault (Vault, adjustA, empty, alterF) where

import Control.Monad.Trans.Key
import Data.Map (Map)
import qualified Data.Map.Class as Map
import GHC.Exts (Any)
import Numeric.Natural
import Unsafe.Coerce

newtype Vault s a = Vault { unVault :: Map Natural Any }

adjustA :: Applicative p => (a k -> p (a k)) -> Key s k -> Vault s a -> p (Vault s a)
adjustA f k = fmap Vault . Map.adjustA (unsafeCoerce f) (unsafeCoerce k) . unVault

empty :: Vault s a
empty = Vault Map.empty

alterF :: (Functor f) => (Maybe (a k) -> f (Maybe (a k))) -> Key s k -> Vault s a -> f (Vault s a)
alterF f k = fmap Vault . Map.alterF (unsafeCoerce f) (unsafeCoerce k) . unVault
