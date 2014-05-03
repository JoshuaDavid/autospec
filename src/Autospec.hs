module Autospec where

import System.Environment
import System.Directory
import System.IO
import System.Time (ClockTime)

-- If autospec is already running, kill all older processes

syncDirStructure :: FilePath -> FilePath -> IO ()
syncDirStructure srcdir testdir = do
    


