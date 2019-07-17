#!/bin/bash
echo "[info] OpenCV installation by learnOpenCV.com - addapted"

cvVersion="master"
echo "[info] OpenCV Version to install: ${cvVersion}"

# Clean build directories
rm -rf opencv/build
rm -rf opencv_contrib/build
	
echo "[info] Creating directory for installation..."
mkdir installation
mkdir installation/OpenCV-"$cvVersion"

echo "[info] Saving current working directory.."
cwd=$(pwd)

echo "[info] Updating packages..."
sudo apt updage -y; sudo apt upgrade -y;

sudo apt -y remove x264 libx264-dev
 
echo "[info] Install dependencies..."
sudo apt -y install build-essential checkinstall cmake pkg-config yasm
sudo apt -y install git gfortran
sudo apt -y install libjpeg8-dev libpng-dev
 
sudo apt -y install software-properties-common
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt -y update
 
sudo apt -y install libjasper1
sudo apt -y install libtiff-dev
 
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt -y install libxine2-dev libv4l-dev

cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h

cd "$cwd"
 
sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
sudo apt -y install libatlas-base-dev
sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
sudo apt -y install libvorbis-dev libxvidcore-dev
sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt -y install libavresample-dev
sudo apt -y install x264 v4l-utils

echo "[info] Downloading opencv..."
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout $cvVersion
cd ..
 
echo "[info] Downloading opencv_contrib..."
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout $cvVersion
cd ..

echo "[info] Compiling and installing OpenCV with contrib modules"
cd opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-"$cvVersion" \
            -D INSTALL_C_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON ..

make -j4
make install