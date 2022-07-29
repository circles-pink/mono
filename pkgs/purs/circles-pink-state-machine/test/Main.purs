module Test.CirclesPinkStateMachine.Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import PursDeps.Tests as PursDeps.Tests
import Test.Data.BigInt as Test.Data.BigInt
import Test.Spec.Discovery (discover)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)
import Test.Unit.Main (runTest)
import Test.Wallet.PrivateKey as Test.Wallet.PrivateKey

foreign import globalRequires :: {}

mainTestUnit :: Effect Unit
mainTestUnit =
  runTest do
    Test.Wallet.PrivateKey.tests
    Test.Data.BigInt.tests
    PursDeps.Tests.tests

mainTestSpec :: Effect Unit
mainTestSpec = launchAff_ do
  specs <- discover """.*"""
  runSpec [consoleReporter] specs

main :: Effect Unit
main = do
  mainTestSpec
  mainTestUnit

