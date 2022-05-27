module CirclesPink.Garden.StateMachine.Control.States.MagicWords where

import Prelude

import CirclesPink.Garden.StateMachine.Control.Common (ActionHandler')
import CirclesPink.Garden.StateMachine.Control.Env as Env
import CirclesPink.Garden.StateMachine.Direction as D
import CirclesPink.Garden.StateMachine.State as S
import Data.Maybe (Maybe(..))

magicWords
  :: forall m
   . Monad m
  => Env.Env m
  -> { prev :: ActionHandler' m Unit S.UserData ("infoSecurity" :: S.UserData)
     , newPrivKey :: ActionHandler' m Unit S.UserData ("magicWords" :: S.UserData)
     , next :: ActionHandler' m Unit S.UserData ("submit" :: S.UserData)
     }
magicWords env =
  { prev: \set _ _ -> set \st -> S._infoSecurity st { direction = D._backwards }
  , newPrivKey
  , next: \set _ _ -> set \st -> S._submit st { direction = D._forwards }
  }
  where
  newPrivKey set _ _ = do
    pk <- env.generatePrivateKey
    set \st -> S._magicWords st { privateKey = Just pk }