module GunDB.Tests (spec) where

import Prelude
import Data.Argonaut (encodeJson)
import Data.Maybe (Maybe(..))
import Debug (spy)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import GunDB (get, offline, once, put)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (fail, shouldEqual)

spec :: Spec Unit
spec =
  describe "Gun" do
    describe "Put" do
      it "Puts data" do
        gundb <- liftEffect $ offline
        ctx <- liftEffect $ gundb # get "users" # put (encodeJson { name: "John", surnameee: "Doe" })
        result <- (gundb # get "users" # once)
        let
          r = spy "res" result
        pure unit

-- assertGunResult :: forall a b. Aff (Maybe { data :: { name :: String | a } | b }) -> String -> Aff Unit
-- assertGunResult aff name = aff >>= \res -> bound res name
--   where
--   bound :: forall c d. Maybe { data :: { name :: String | c } | d } -> String -> Aff Unit
--   bound (Just gunVal) expectedName = gunVal.data.name `shouldEqual` expectedName
--   bound Nothing _ = fail "No result"
