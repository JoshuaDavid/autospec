module RecursiveDoSpec where

import RecursiveDo 
import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)
import System.IO
import System.Directory (removeFile)

nothing :: IO ()
nothing = return ()

toss :: a -> IO ()
toss x = return ()

logToFileHandle handle string =
    hPutStrLn handle (string ++ " ")

assertEmpty    msg x    = it (msg ++ " is empty" )    (x `shouldBe` "")
assertNotEmpty msg x    = it (msg ++ " is not empty") (x `shouldSatisfy` (/= ""))
assertEqual    msg x y  = it (msg)                    (x `shouldBe` y)
assertNotEqual msg x y  = it (msg)                    (x `shouldSatisfy` (/= y))

main :: IO ()
main = do
    tmp1 <- newTmp
    tmp2 <- newTmp
    tmp3 <- newTmp
    tmp4 <- newTmp
    recursiveDo "./src" (appendFile tmp2) toss
    recursiveDo "./src" (appendFile tmp3) toss
    recursiveDo "./src" toss (appendFile tmp4)
    -- I should really be using bracket here.
    content1 <- readFile tmp1
    content2 <- readFile tmp2
    content3 <- readFile tmp3
    content4 <- readFile tmp4
    removeFile tmp1
    removeFile tmp2
    removeFile tmp3
    removeFile tmp4
    let spec1 = assertEmpty "a new temporary file" content1
    let spec2 = assertNotEmpty "a list of all files in src/" content2
    let spec3 = assertEqual "a second list of all files in src/ is the same as the first" content2 content3
    let spec4 = assertNotEqual "a list of all dirs in src/ differs from the list of files" content2 content4
    hspec (spec1 >> spec2 >> spec3 >> spec4)
    return ()

newTmp :: IO FilePath
newTmp = do
    (path, handle) <- openTempFile "." "tstfile.txt"
    hClose handle
    return path

spec :: Spec
spec = it "A test runs" (shouldBe True True)
