module Main (main) where

import Html ( docHtml )
import Style ( docStyle )
import Action ( docAction )
import qualified Data.Text.Lazy.IO as T
import Network.Wai.Handler.Warp ( run )
import Network.Wai.Application.Static ( staticApp
                                      , defaultWebAppSettings )

main :: IO ()
main = do
  T.writeFile htmlFile docHtml
  T.writeFile cssFile docStyle
  T.writeFile jsFile docAction
  let app = staticApp . defaultWebAppSettings $ serverRoot
  putStrLn "Server succeed! Please infer http://localhost:8080/index.html"
  run 8080 app

serverRoot :: String
serverRoot = "./public"

htmlFile :: String
htmlFile = "./public/index.html"

cssFile :: String
cssFile = "./public/index.css"

jsFile :: String
jsFile = "./public/index.js"

