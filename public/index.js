

function onOpenCVReady() {
  document.getElementById('opencv-status').innerHTML = 'OpenCV.js is ready.'
}


const image_input_1 = document.getElementById('image-input-1')
const image1 = document.getElementById('image1')
image_input_1.onchange = function(e) {
  image1.src = URL.createObjectURL(e.target.files[0])
}


const image_input_2 = document.getElementById('image-input-2')
const image2 = document.getElementById('image2')
image_input_2.onchange = function(e) {
  image2.src = URL.createObjectURL(e.target.files[0])
}


function imageDiff() {
  let mat1 = cv.imread(image1)
  let mat2 = cv.imread(image2)
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
  cv.imshow('image-canvas', mat_result2) 
  mat1.delete()  
  mat2.delete() 
  mat1_gray.delete()  
  mat2_gray.delete()
  mat_result.delete()
  mat2_list.delete()
  mat_result2.delete()
}