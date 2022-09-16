{-# LANGUAGE OverloadedStrings #-}

module Html
  (
    docHtml
  ) where

import Prelude hiding ( div
                      , head
                      , id )
import Text.Blaze.Html5
import Text.Blaze.Html5.Attributes hiding ( title
                                          , label )
import Text.Blaze.Html.Renderer.Text
import Data.Text.Lazy ( Text )

docHtml :: Text
docHtml = renderHtml $ do
  docType
  html $ do
    head $ do
      meta ! charset "UTF-8"
      meta ! name "description"
           ! content "OpenCV.js diff image"
      meta ! name "keywords"
           ! content "murakami, Murakami Kennzo, OpenCV.js, diff image, compare image"
      meta ! name "author"
           ! content "murakami"
      title $ "Diff image by using OpenCV.js"
      link ! rel "stylesheet"
           ! href "./index.css"
    body $ do
      websiteHeader
      websiteOpenCVStatus
      websiteMain

websiteHeader :: Html
websiteHeader = h2 "Diff image by using OpenCV.js"

websiteOpenCVStatus :: Html
websiteOpenCVStatus = p "OpenCV.js is loading..."

websiteMain :: Html
websiteMain = div $ (p "Please upload two images for diff.") >> websiteDiffImage >> websiteDiffButton >> websiteDiffResult

websiteDiffImage :: Html
websiteDiffImage = div ! class_ "diff-image-view"
                       $ websiteImage >> websiteImage

websiteImage :: Html
websiteImage = div $ do
                     label $ "image 1" >> input ! type_ "file" ! name "image file" ! accept "image/*" 
                     div ! class_ "diff-image-item" $ div ! class_ "diff-image-item-real" $ img ! class_ "diff-image" ! alt "No Image"

websiteDiffButton :: Html
websiteDiffButton = div $ button "diff image"

websiteDiffResult :: Html
websiteDiffResult = div $ do
                          p "Here is the diff result image." 
                          canvas ! class_ "diff-canvas" ! width "0" ! height "0" $ mempty
