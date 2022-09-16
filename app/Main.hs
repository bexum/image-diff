module Main (main) where

import Html ( docHtml )
import Style ( docStyle )
import qualified Data.Text.Lazy.IO as T

main :: IO ()
main = do
  T.putStrLn docHtml
