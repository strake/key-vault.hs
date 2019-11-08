module Data.Vault (Vault, alterF) where

import Control.Monad.Trans.Key
import Data.Map (Map)
import qualified Data.Map as Map
import GHC.Exts (Any)
import Numeric.Natural
import Unsafe.Coerce

newtype Vault s = Vault { unVault :: Map Natural Any }

alterF :: (Functor f) => (Maybe a -> f (Maybe a)) -> Key s a -> Vault s -> f (Vault s)
alterF f k = fmap Vault . Map.alterF f' (unsafeCoerce k) . unVault
  where f' = unsafeCoerce f :: Maybe Any -> f (Maybe Any)
