module RecursiveDo (recursiveDo) where

import System.Directory
import System.FilePath

nothing :: IO ()
nothing = return ()

recursiveDo :: FilePath -> (FilePath -> IO ()) -> (FilePath -> IO ()) -> IO ()
recursiveDo path fileaction diraction = do
    isdir  <- doesDirectoryExist path
    isfile <- doesFileExist      path
    if isfile then do
        fileaction path
    else if isdir  then do
        diraction path
        contents <- getDirectoryContents path
        let filteredContents = filter (`notElem` [".", ".."]) contents
        let fullPaths = map (path </>) filteredContents
        mapM (\path -> recursiveDo path fileaction diraction) fullPaths
        return ()
    else do nothing

main :: IO ()
main = do
    recursiveDo "." putStrLn putStrLn
    return ()
