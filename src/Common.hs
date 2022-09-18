{-# LANGUAGE OverloadedStrings #-}

module Common
  (
    opencvStatusElement
  , imageElement1
  , imageFileElement1
  , imageElement2
  , imageFileElement2
  , imageCanvasElement
  ) where

import Data.Text.Lazy ( Text )

opencvStatusElement :: Text
opencvStatusElement = "opencv-status"

imageElement1 :: Text
imageElement1 = "image1"

imageFileElement1 :: Text
imageFileElement1 = "image-input-1"

imageElement2 :: Text
imageElement2 = "image2"

imageFileElement2 :: Text
imageFileElement2 = "image-input-2"

imageCanvasElement :: Text
imageCanvasElement = "image-canvas"
