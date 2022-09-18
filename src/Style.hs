{-# LANGUAGE OverloadedStrings #-}

module Style 
  (
    docStyle
  ) where 

import Clay
import Data.Text.Lazy ( Text )
  
docStyle :: Text
docStyle = render $ do
  rootStyle
  headerStyle
  openCVStatusStyle
  mainStyle

rootStyle :: Css
rootStyle = mempty

headerStyle :: Css
headerStyle = mempty

openCVStatusStyle :: Css
openCVStatusStyle = mempty

mainStyle :: Css
mainStyle = diffImageStyle <> diffButtonStyle <> diffResultStyle

diffImageStyle :: Css
diffImageStyle = do
  ".diff-image-view" ? do
    display grid
    gridTemplateColumns $ replicate 2 (fr 1)
    gridGap (px 16)
    imageStyle

imageStyle :: Css
imageStyle = do
  ".diff-image-item" ? do
    position relative
    paddingTop (pct 75)
    ".diff-image-item-real" ? do
      position absolute
      top nil
      right nil
      bottom nil
      left nil
      display flex
      justifyContent center
      alignItems center
      ".diff-image" ? do
        display block
        maxWidth (pct 100)
        maxHeight (pct 100)


diffButtonStyle :: Css
diffButtonStyle = mempty

diffResultStyle :: Css
diffResultStyle = do
  ".diff-canvas" ? do
    important $ maxWidth (pct 100)
    important $ height auto

