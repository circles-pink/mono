module VoucherServer.MonadApp.Class where

import VoucherServer.Prelude

import CirclesCore as CC
import CirclesPink.Data.Address (Address)
import Payload.Server.Response as Res
import VoucherServer.EnvVars (AppEnvVars)

--------------------------------------------------------------------------------
-- Class
--------------------------------------------------------------------------------

class
  ( MonadThrow AppError m
  , MonadAsk (AppEnv m) m
  ) <=
  MonadApp m

--------------------------------------------------------------------------------
-- Error
--------------------------------------------------------------------------------

data AppError
  = ErrCirclesCore CCErrAll
  | ErrUnknown
  | ErrBasicAuth

derive instance genericVSE :: Generic AppError _
derive instance eqVSE :: Eq AppError
instance showVSE :: Show AppError where
  show = genericShow

-- Due to a compiler bug (unknown module: Partially applied type synonyms)
-- we have to redefine this type inside the current module
type CCErrAll = Variant
  ( CC.ErrParseAddress
      + CC.ErrNative
      + CC.ErrService
      + CC.ErrInvalidUrl
      + CC.ErrApi
      + ()
  )

errorToFailure :: AppError -> Failure
errorToFailure = case _ of
  ErrCirclesCore _ -> Error $ Res.internalError $ StringBody "Internal server error"
  ErrUnknown -> Error $ Res.internalError $ StringBody "Internal server error"
  ErrBasicAuth -> Error $ Res.internalError $ StringBody "Authorization failed"

errorToLog :: AppError -> String
errorToLog = case _ of
  ErrCirclesCore _ -> "Circles Core Error"
  ErrUnknown -> "Unknown error"
  ErrBasicAuth -> "Basic Authentication failed"

--------------------------------------------------------------------------------
-- Env
--------------------------------------------------------------------------------

newtype AppEnv m = AppEnv (AppEnv' m)

type AppEnv' m =
  { getTrusts :: Address -> m (Set Address)
  , envVars :: AppEnvVars
  }

modifyAppEnv :: forall m. (AppEnv' m -> AppEnv' m) -> AppEnv m -> AppEnv m
modifyAppEnv f (AppEnv r) = AppEnv $ f r