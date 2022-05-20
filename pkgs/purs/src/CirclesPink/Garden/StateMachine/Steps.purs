module CirclesPink.Garden.StateMachine.Steps
  ( askEmail
  , askUsername
  , infoGeneral
  , infoSecurity
  , magicWords
  , submit
  ) where

import Prelude

import CirclesPink.Garden.Env (testEnv, testEnv')
import CirclesPink.Garden.StateMachine.Action (CirclesAction)
import CirclesPink.Garden.StateMachine.Action as A
import CirclesPink.Garden.StateMachine.Control (circlesControl)
import CirclesPink.Garden.StateMachine.State (CirclesState)
import CirclesPink.Garden.StateMachine.State as S
import Control.Monad.State (StateT, execStateT)
import Data.Identity (Identity)
import Data.Newtype (unwrap)
import Stadium.Control (toStateT)

act :: CirclesAction -> StateT CirclesState Identity Unit
act = toStateT $ circlesControl testEnv'

execFrom :: CirclesState -> StateT CirclesState Identity Unit -> CirclesState
execFrom st m = unwrap $ execStateT m st

--------------------------------------------------------------------------------
-- Steps
--------------------------------------------------------------------------------
infoGeneral :: CirclesState
infoGeneral = S.init

askUsername :: CirclesState
askUsername =
  execFrom infoGeneral do
    act $ A._infoGeneral $ A._next unit
    act $ A._askUsername $ A._setUsername "fooo"

askEmail :: CirclesState
askEmail =
  execFrom askUsername do
    act $ A._askUsername $ A._next unit
    act $ A._askEmail $ A._setEmail "helloworld@helloworld.com"
    act $ A._askEmail $ A._setTerms unit
    act $ A._askEmail $ A._setPrivacy unit

infoSecurity :: CirclesState
infoSecurity =
  execFrom askEmail do
    act $ A._askEmail $ A._next unit

magicWords :: CirclesState
magicWords =
  execFrom infoSecurity do
    act $ A._infoSecurity $ A._next unit

submit :: CirclesState
submit =
  execFrom magicWords do
    act $ A._magicWords $ A._next unit
