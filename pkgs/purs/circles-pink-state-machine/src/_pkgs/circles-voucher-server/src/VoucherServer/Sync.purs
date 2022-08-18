module VoucherServer.Sync where

import Prelude

import Control.Monad.Error.Class (catchError, liftMaybe, throwError)
import Control.Monad.Reader (ask)
import Data.Array as A
import Data.BN (BN)
import Data.DateTime.Instant (Instant, unInstant)
import Data.Maybe (Maybe)
import Data.Newtype (un, unwrap)
import Payload.ResponseTypes (Response(..))
import VoucherServer.MonadApp (class MonadApp, AppEnv(..), AppError(..))
import VoucherServer.MonadApp.Class (CirclesCoreEnv(..), GraphNodeEnv(..))
import VoucherServer.Spec.Types (EurCent(..), Freckles(..), VoucherAmount(..), VoucherEncrypted, VoucherOffer(..), VoucherProvider(..), VoucherProviderId(..))
import VoucherServer.Specs.Xbge (Address)
import VoucherServer.Types (Transfer(..), TransferMeta(..))

threshold :: Threshold EurCent
threshold = Threshold { above: EurCent 5, below: EurCent 5 }

finalizeTx :: forall m. MonadApp m => Transfer -> m VoucherEncrypted
finalizeTx (Transfer { from, amount, id }) = do
  AppEnv
    { graphNode: GraphNodeEnv { getTransferMeta }
    , circlesCore: CirclesCoreEnv { getPaymentNote }
    , xbgeClient: { getVoucherProviders, finalizeVoucherPurchase }
    } <- ask

  TransferMeta { time, transactionHash } <- getTransferMeta id
  providers <- getVoucherProviders {}
    <#> getResponseData

  let eur = frecklesToEurCent time amount

  providerId <- getPaymentNote transactionHash <#> VoucherProviderId

  voucherAmount <-
    ( getVoucherAmount providers providerId eur
        # liftMaybe ErrUnknown
    )
      `catchError` \_debug -> do
        redeemAmount from eur
        throwError ErrUnknown

  finalizeVoucherPurchase
    { body:
        { safeAddress: from
        , providerId
        , amount: voucherAmount
        , transactionId: id
        }
    }
    <#> getResponseData

redeemAmount :: forall m. MonadApp m => Address -> EurCent -> m Unit
redeemAmount _ _ =
  -- log "In the future we'll pay back the amount..."
  pure unit

getVoucherAmount :: Array VoucherProvider -> VoucherProviderId -> EurCent -> Maybe VoucherAmount
getVoucherAmount providers providerId payedAmount = do
  (VoucherProvider provider) <- A.find (\(VoucherProvider p) -> p.id == providerId) providers
  (VoucherOffer { amount }) <- A.find (\(VoucherOffer { amount: (VoucherAmount amount) }) -> almostEquals threshold payedAmount amount) provider.availableOffers
  pure amount

almostEquals :: Threshold EurCent -> EurCent -> EurCent -> Boolean
almostEquals
  (Threshold { above: (EurCent above), below: (EurCent below) })
  (EurCent amount)
  (EurCent price) =
  let
    isInLowerRange = amount >= (price * 100 - below)
    isInUpperRange = amount <= (price * 100 + above)
  in
    isInLowerRange && isInUpperRange

newtype Threshold a = Threshold { above :: a, below :: a }

frecklesToEurCent :: Instant -> Freckles -> EurCent
frecklesToEurCent timestamp (Freckles freckles) =
  let
    ms = unInstant timestamp
  in
    frecklesToEuroCentImpl (unwrap ms) freckles # EurCent

foreign import frecklesToEuroCentImpl :: Number -> BN -> Int

getResponseData :: forall r a. Response { data :: a | r } -> a
getResponseData = un Response >>> _.body >>> _.data