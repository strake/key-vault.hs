module Data.Vault (Vault, alterF) where

import Control.Monad.Trans.Key
import Data.Map (Map)
import qualified Data.Map as Map
import GHC.Exts (Any)
import Numeric.Natural
import Unsafe.Coerce

newtype Vault s φ = Vault { unVault :: Map Natural Any }

alterF :: (Functor f) => (Maybe (φ a) -> f (Maybe (φ a))) -> Key s a -> Vault s φ -> f (Vault s φ)
alterF f k = fmap Vault . Map.alterF f' (unsafeCoerce k) . unVault
  where f' = unsafeCoerce f :: Maybe Any -> f (Maybe Any)
