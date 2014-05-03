module AutospecSpec where

import Autospec
import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    it "has spec" $ do
        False `shouldBe` True
