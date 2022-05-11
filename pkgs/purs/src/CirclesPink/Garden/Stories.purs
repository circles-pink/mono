module CirclesPink.Garden.StateMachine.Stories
  ( ScriptT
  , SignUpUserOpts
  , finalizeAccount
  , runScripT
  , signUpUser
  ) where

import Prelude
import CirclesPink.Garden.StateMachine.Action (CirclesAction, _askEmail, _askUsername, _infoSecurity, _magicWords, _next, _setEmail, _setPrivacy, _setTerms, _setUsername, _submit)
import CirclesPink.Garden.StateMachine.Action as A
import CirclesPink.Garden.StateMachine.Control (circlesControl)
import CirclesPink.Garden.StateMachine.Control.Env (Env)
import CirclesPink.Garden.StateMachine.State (CirclesState, init)
import Control.Monad.Error.Class (throwError)
import Control.Monad.Except (ExceptT(..), runExceptT)
import Control.Monad.State (StateT, get, runStateT)
import Convertable (convert)
import Data.Either (Either)
import Data.Traversable (sequence_)
import Data.Tuple.Nested (type (/\))
import Data.Variant (default, onMatch)
import Data.Variant.Extra (getLabel)
import Debug (spy)
import Effect.Class (class MonadEffect)
import Effect.Class.Console (log)
import Stadium.Control (toStateT)
import Undefined (undefined)
import Wallet.PrivateKey (PrivateKey)
import Wallet.PrivateKey as CC

type ScriptT m a
  = ExceptT String (StateT CirclesState m) a

runScripT :: forall m a. ScriptT m a -> m (Either String a /\ CirclesState)
runScripT = flip runStateT init <<< runExceptT

--------------------------------------------------------------------------------
act :: forall m. MonadEffect m => Env m -> CirclesAction -> StateT CirclesState m Unit
act env =
  let
    ctl = toStateT (circlesControl env)
  in
    \ac -> do
      log ("ACTION: " <> show ac)
      ctl ac
      st <- get
      log ("STATE: " <> getLabel st)
      let
        x = spy "st" st
      log ""

act' :: forall m a. MonadEffect m => Env m -> (a -> CirclesAction) -> Array a -> StateT CirclesState m Unit
act' env f xs = xs <#> (\x -> act env $ f x) # sequence_

--------------------------------------------------------------------------------
type SignUpUserOpts
  = { username :: String
    , email :: String
    }

signUpUser ::
  forall m.
  MonadEffect m =>
  Env m ->
  SignUpUserOpts ->
  ExceptT String (StateT CirclesState m)
    { privateKey :: CC.PrivateKey
    , safeAddress :: CC.Address
    }
signUpUser env opts =
  ExceptT do
    act env $ A._infoGeneral $ A._next unit
    act env $ A._askUsername $ A._setUsername opts.username
    act env $ A._askUsername $ A._next unit
    act env $ A._askEmail $ A._setEmail opts.email
    act env $ A._askEmail $ A._setTerms unit
    act env $ A._askEmail $ A._setPrivacy unit
    act env $ A._askEmail $ A._next unit
    act env $ A._infoSecurity $ A._next unit
    act env $ A._magicWords $ A._next unit
    act env $ A._submit $ A._submit unit
    get
      <#> ( default (throwError "Cannot sign up user.")
            # onMatch
                { trusts:
                    \x ->
                      pure
                        { privateKey: x.privKey
                        , safeAddress: x.user.safeAddress
                        }
                }
        )

--------------------------------------------------------------------------------
finalizeAccount :: forall m. MonadEffect m => Env m -> ExceptT String (StateT CirclesState m) Unit
finalizeAccount env =
  ExceptT do
    act env $ A._trusts $ A._finalizeRegisterUser unit
    get
      <#> ( default (throwError "Cannot finalize register user.")
            # onMatch
                { dashboard:
                    \_ ->
                      pure unit
                }
        )
