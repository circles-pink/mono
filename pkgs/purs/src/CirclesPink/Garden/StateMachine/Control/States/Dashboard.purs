module CirclesPink.Garden.StateMachine.Control.States.Dashboard where

import Prelude
import CirclesPink.Garden.StateMachine.Control.Common (ActionHandler, run, run')
import CirclesPink.Garden.StateMachine.Control.Env as Env
import CirclesPink.Garden.StateMachine.State as S
import Control.Monad.Except.Checked (ExceptV)
import Control.Monad.Trans.Class (class MonadTrans)
import Data.Either (Either(..))
import RemoteData (RemoteData, _failure, _loading, _success)
import Wallet.PrivateKey as P

dashboard ::
  forall t m.
  Monad m =>
  MonadTrans t =>
  Monad (t m) =>
  Env.Env m ->
  { logout :: ActionHandler t m Unit S.DashboardState ( "landing" :: S.LandingState )
  , getTrusts :: ActionHandler t m Unit S.DashboardState ( "dashboard" :: S.DashboardState )
  , addTrustConnection :: ActionHandler t m String S.DashboardState ( "dashboard" :: S.DashboardState )
  , getBalance :: ActionHandler t m Unit S.DashboardState ( "dashboard" :: S.DashboardState )
  , checkUBIPayout :: ActionHandler t m Unit S.DashboardState ( "dashboard" :: S.DashboardState )
  -- , getUsers ::
  --     ActionHandler t m
  --       { userNames :: Array String
  --       , addresses :: Array P.Address
  --       }
  --       S.DashboardState
  --       ( "dashboard" :: S.DashboardState )
  }
dashboard env =
  { logout: \_ _ _ -> pure unit
  , getTrusts
  , addTrustConnection
  , getBalance
  , checkUBIPayout
  -- , getUsers
  }
  where
  getTrusts set st _ = do
    result <-
      run $ env.trustGetNetwork st.privKey
    case result of
      Left e -> set \st' -> S._dashboard st' { error = pure e }
      Right t -> set \st' -> S._dashboard st' { trusts = t }

  addTrustConnection set st u = do
    set \st' -> S._dashboard st' { trustAddResult = _loading :: RemoteData _ _ }
    let
      task :: ExceptV S.ErrTrustAddConnection _ _
      task = env.addTrustConnection st.privKey (P.unsafeAddrFromString u) st.user.safeAddress
    result <- run' $ task
    case result of
      Left e -> set \st' -> S._dashboard st' { trustAddResult = _failure e }
      Right _ -> set \st' -> S._dashboard st' { trustAddResult = _success unit }

  getBalance set st _ = do
    set \st' -> S._dashboard st' { getBalanceResult = _loading :: RemoteData _ _ }
    let
      task :: ExceptV S.ErrTokenGetBalance _ _
      task = env.getBalance st.privKey st.user.safeAddress
    result <- run' $ task
    case result of
      Left e -> set \st' -> S._dashboard st' { getBalanceResult = _failure e }
      Right b -> set \st' -> S._dashboard st' { getBalanceResult = _success b }

  checkUBIPayout set st _ = do
    set \st' -> S._dashboard st' { checkUBIPayoutResult = _loading :: RemoteData _ _ }
    let
      task :: ExceptV S.ErrTokenGetBalance _ _
      task = env.checkUBIPayout st.privKey st.user.safeAddress
    result <- run' $ task
    case result of
      Left e -> set \st' -> S._dashboard st' { checkUBIPayoutResult = _failure e }
      Right b -> set \st' -> S._dashboard st' { checkUBIPayoutResult = _success b }

-- getUsers _ st { userNames, addresses } = run' $ env.getUsers st.privateKey userNames addresses
