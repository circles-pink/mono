module CirclesPink.Data.TrustNode
  ( TrustNode(..)
  , getAddress
  , initTrustNode
  , userIdent
  ) where

import CirclesPink.Prelude

import CirclesPink.Data.Address (Address)
import CirclesPink.Data.User (User(..))
import CirclesPink.Data.UserIdent (UserIdent(..))
import Data.IxGraph (class Indexed)
import Data.IxGraph as IxGraph
import Data.Lens (Lens')
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Lens.Record (prop)
import PursTsGen.Lang.PureScript.Type as PS
import Type.Proxy (Proxy(..))

newtype TrustNode = TrustNode
  { userIdent :: UserIdent
  , isLoading :: Boolean
  }

moduleName :: String
moduleName = "CirclesPink.Data.TrustNode"

getAddress :: TrustNode -> Address
getAddress = IxGraph.getIndex

initTrustNode :: UserIdent -> TrustNode
initTrustNode userIdent' = TrustNode
  { userIdent: userIdent'
  , isLoading: false
  }

userIdent :: Lens' TrustNode UserIdent
userIdent = _Newtype <<< prop (Proxy :: _ "userIdent")

derive newtype instance Show TrustNode
derive newtype instance Eq TrustNode
derive newtype instance Ord TrustNode

derive instance Newtype TrustNode _

instance Indexed Address TrustNode where
  getIndex (TrustNode { userIdent: UserIdent (Left x) }) = x
  getIndex (TrustNode { userIdent: UserIdent (Right (User { safeAddress })) }) = safeAddress

instance ToPursNominal TrustNode where
  toPursNominal _ = PursNominal moduleName "TrustNode"

instance ToTsDef TrustNode where
  toTsDef = newtypeToTsDef []

instance ToTsType TrustNode where
  toTsType = typeRefToTsType' []

instance ToPursType TrustNode where
  toPursType _ = PS.var $ PS.Name "TODO"
