{-# LANGUAGE OverloadedStrings, QuasiQuotes #-}

module Action
  (
    docAction
  ) where

import Prelude hiding ( map )
import Common
import Text.Heterocephalus ( compileText )
import Text.Blaze ( Markup )
import Text.Blaze.Renderer.Text ( renderMarkup )
import Data.Text.Lazy ( Text, map )

docAction :: Text
docAction = renderMarkup [compileText|
#{openCVReadyAction}
%{ forall (imageFileElement, imageElement1) <- [(imageFileElement1, imageElement1), (imageFileElement2, imageElement2)] }
#{imageAction imageFileElement imageElement1}
%{ endforall }
#{imageDiffAction}
|]

openCVReadyAction :: Markup
openCVReadyAction =  [compileText|
function onOpenCVReady() {
  document.getElementById('#{opencvStatusElement}').innerHTML = 'OpenCV.js is ready.'
}
|]

imageAction :: Text -> Text -> Markup
imageAction imageFileElement imageElement = [compileText|
const #{imageFileElementVariable} = document.getElementById('#{imageFileElement}')
const #{imageElement} = document.getElementById('#{imageElement}')
#{imageFileElementVariable}.onchange = function(e) {
  #{imageElement}.src = URL.createObjectURL(e.target.files[0])
}
|]
  where imageFileElementVariable = map (\c -> if c == '-' then '_' else c) imageFileElement

imageDiffAction :: Markup
imageDiffAction = [compileText|
function imageDiff() {
  let mat1 = cv.imread(#{imageElement1})
  let mat2 = cv.imread(#{imageElement2})
  mat1.convertTo(mat1, cv.CV_8UC1) 
  mat2.convertTo(mat2, cv.CV_8UC1)  
  let mat1_gray = new cv.Mat() 
  cv.cvtColor(mat1, mat1_gray, cv.COLOR_BGR2GRAY)
  let mat2_gray = new cv.Mat()
  cv.cvtColor(mat2, mat2_gray, cv.COLOR_BGR2GRAY)
  mat1_gray.convertTo(mat1_gray, cv.CV_32F)
  mat2_gray.convertTo(mat2_gray, cv.CV_32F)
  let mat_result = new cv.Mat()
  cv.absdiff(mat1_gray, mat2_gray, mat_result)  
  cv.threshold(mat_result, mat_result, 5, 255.0, cv.THRESH_BINARY)  
  mat_result.convertTo(mat_result, cv.CV_8UC1)  
  let mat2_list = new cv.MatVector()
  cv.findContours(mat_result, mat2_list, new cv.Mat(), cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)  
  let mat_result2 = mat2.clone()
  cv.drawContours(mat_result2, mat2_list, -1, new cv.Scalar(0, 0, 255, 255))
  cv.imshow('#{imageCanvasElement}', mat_result2) 
  mat1.delete()  
  mat2.delete() 
  mat1_gray.delete()  
  mat2_gray.delete()
  mat_result.delete()
  mat2_list.delete()
  mat_result2.delete()
}
|]
