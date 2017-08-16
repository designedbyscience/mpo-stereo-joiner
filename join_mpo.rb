require 'rmagick'
require 'FileUtils'

exif1 = "exiftool -all= --exif:all -o %d%f_right.jpg -ext mpo ."
exif2 = "exiftool -mpimage2 -b -w %d%f_left.jpg -if '$mpimage2:mpimagetype==0x020002' -ext mpo ."
exif3 = "exiftool -mpimage3 -b -w %d%f_left.jpg -if '$mpimage3:mpimagetype==0x020002' -ext mpo ."

%x[#{exif1}]
%x[#{exif2}]
%x[#{exif3}]

Dir["*_left.jpg"].each do |image|
   
    puts image
    right_image =  image.match(/(.*)_left.jpg/)[1] + "_right.jpg"
    puts right_image
    
    joined_image = Magick::ImageList.new(image, right_image).append(false)
    joined_image.write("jpeg:" + image.match(/(.*)_left.jpg/)[1] + "_joined.jpg")
   
    FileUtils.rm(image)
    FileUtils.rm(right_image)
end