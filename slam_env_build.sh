mv ~/Downloads/install.log  ~/Downloads/install.log.bak
touch ~/Downloads/install.log

echo "apt update ..."
sudo apt update  >>  ~/Downloads/install.log

echo " "
echo " "
echo "------------------ apt install all libraries ------------------ "
echo " "
echo "install: vim g++ unzip wget git git-core build-essential cmake "  | tee -a ~/Downloads/install.log
sudo apt-get install -y  vim g++ unzip wget git git-core build-essential cmake  doxygen >>~/Downloads/install.log

echo "install: freeglut3 freeglut3-dbg freeglut3-dev gfortran graphviz libgtk2.0-dev " | tee -a ~/Downloads/install.log
sudo apt-get install -y  freeglut3 freeglut3-dbg freeglut3-dev gfortran graphviz libgtk2.0-dev  

echo "install: libatlas-base-dev libavcodec-dev libavformat-dev libeigen3-dev"  | tee -a ~/Downloads/install.log
sudo apt-get install -y  libatlas-base-dev libavcodec-dev libavformat-dev libeigen3-dev  >>~/Downloads/install.log

echo "install: libboost-dev libboost-filesystem-dev libboost-system1.58-dev libboost-thread-dev"  | tee -a ~/Downloads/install.log
sudo apt-get install -y  libboost-dev libboost-filesystem-dev libboost-system1.58-dev libboost-thread-dev  >>~/Downloads/install.log

echo "install: libcholmod3.0.6 libcxsparse3.1.4 libeigen3-dev libflann-dev  libflann1.8" | tee -a ~/Downloads/install.log
sudo apt-get install -y  libcholmod3.0.6 libcxsparse3.1.4 libeigen3-dev libflann-dev  libflann1.8  >>~/Downloads/install.log

echo "install: libgflags-dev libglew-dev libgoogle-glog-dev libgtest-dev libboost-all-dev libqhull*  "  | tee -a ~/Downloads/install.log
sudo apt-get install -y  libgflags-dev libglew-dev libgoogle-glog-dev libgtest-dev libboost-all-dev libqhull*  >>~/Downloads/install.log

echo "install: libjasper-dev libjpeg8-dev libjpeg-dev liblapack-dev libopenexr-dev libpcap-dev"  | tee -a ~/Downloads/install.log
sudo apt-get install -y  libjasper-dev libjpeg8-dev libpng-dev libtiff-dev  libjpeg-dev libdc1394-22-dev liblapack-dev libopenexr-dev libpcap-dev  >>~/Downloads/install.log

echo "install: libphonon-dev libpng12-dev libqglviewer2 libqglviewer-dev libqhull-dev "  | tee -a ~/Downloads/install.log
sudo apt-get install -y  libphonon-dev libpng12-dev libqglviewer2 libqglviewer-dev libqhull-dev  >>~/Downloads/install.log

echo "install: libqt4-dev libsuitesparseconfig4.4.6 libsuitesparse-dev libswscale-dev  "  | tee -a ~/Downloads/install.log
sudo apt-get install -y  libqt4-dev libsuitesparseconfig4.4.6 libsuitesparse-dev libswscale-dev liblapacke-dev   >>~/Downloads/install.log

echo "install: libtbb-dev libtiff5-dev libudev-dev libusb-1.0-0-dev libusb-dev "   | tee -a ~/Downloads/install.log
sudo apt-get install -y  libtbb-dev libtiff5-dev libudev-dev libusb-1.0-0-dev libusb-dev   >>~/Downloads/install.log

echo "install: libv4l-dev libvtk5-dev libvtk6-dev libvtk5-qt4-dev libvtk-java libx264-dev  libvtk5.10-qt4 libvtk5.10   "   | tee -a ~/Downloads/install.log
sudo apt-get install -y  libv4l-dev libvtk5-dev libvtk5-qt4-dev libvtk-java libx264-dev  libvtk5.10-qt4 libvtk5.10 qt5-default ccache >>~/Downloads/install.log


sudo apt-get install -y  pkg-config python2.7-dev python3.5-dev python3-dev python-numpy  python3-numpy python-vtk  libtbb2 libtbb-dev  qt4-qmake qt-sdk tcl-vtk pylint >>~/Downloads/install.log
sudo apt-get install -y  libxi-dev libxmu-dev libxvidcore-dev mono-complete mpi-default-dev >>~/Downloads/install.log
sudo apt-get install -y  openjdk-8-jdk openmpi-bin openmpi-common  openjdk-8-jre   >>~/Downloads/install.log
sudo apt-get install -y  libxml2-dev libxslt-dev libffi-dev libsdl1.2-dev libssl-dev   >>~/Downloads/install.log
# opencv --use lapack,  
sudo apt-get install -y   liblapacke-dev checkinstall libopenblas-dev  >>~/Downloads/install.log
sudo apt-get install -y  phonon-backend-gstreamer phonon-backend-vlc   >>~/Downloads/install.log
# sudo apt install -y  adwaita-icon-theme adwaita-icon-theme-full   >>~/Downloads/install.log


echo " "
echo "copy eigen3 to /usr/local/include to avoid the unsupport file not found problem..."
sudo cp -r /usr/include/eigen3/unsported  /usr/local/include/

echo " "
echo " "
echo "------------------ Sophus ------------------ "  | tee -a ~/Downloads/install.log
mkdir -p  ~/Downloads && cd ~/Downloads  
if [ ! -f Sophus-master.zip  ]; then
    echo "Sophus: download..."  | tee -a ~/Downloads/install.log
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O Sophus-master.zip https://codeload.github.com/strasdat/Sophus/zip/master  
fi
if [ ! -d ~/Downloads/Sophus-master ]; then
	unzip -o Sophus-master.zip  >> ~/Downloads/install.log  
fi
echo "Sophus: compile & install..."  | tee -a ~/Downloads/install.log
mkdir -p ~/Downloads/Sophus-master/build && cd ~/Downloads/Sophus-master/build   >>~/Downloads/install.log
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. >>~/Downloads/install.log
make -j"$(nproc)"   | tee -a ~/Downloads/install.log
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install  >>~/Downloads/install.log

echo " "
echo " "
echo "------------------ Pangolin ------------------ "    | tee -a ~/Downloads/install.log
cd ~/Downloads
if [ ! -f Pangolin-master.zip  ]; then
    echo "Pangolin: download..."  | tee -a ~/Downloads/install.log
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O Pangolin-master.zip https://codeload.github.com/zzx2GH/Pangolin/zip/master 
fi
if [ ! -d ~/Downloads/Pangolin-master ]; then
    unzip -o Pangolin-master.zip  >>~/Downloads/install.log
fi

echo "Pangolin: compile & install..."   | tee -a ~/Downloads/install.log
mkdir -p ~/Downloads/Pangolin-master/build && cd ~/Downloads/Pangolin-master/build  >>~/Downloads/install.log
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO ..   >>~/Downloads/install.log
make -j"$(nproc)"  | tee -a ~/Downloads/install.log
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install  >>~/Downloads/install.log

echo " "
echo " "  
echo "------------------ Ceres ------------------ "  | tee -a ~/Downloads/install.log
cd ~/Downloads
if [ ! -f ceres-solver-master.zip  ]; then
    echo "Ceres: download..."   | tee -a ~/Downloads/install.log
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O ceres-solver-master.zip https://codeload.github.com/ceres-solver/ceres-solver/zip/master 
fi
if [ ! -d ~/Downloads/ceres-solver-master ]; then
    unzip -o ceres-solver-master.zip    >>~/Downloads/install.log
fi

echo "Ceres: compile & install..."   | tee -a ~/Downloads/install.log
mkdir -p ~/Downloads/ceres-solver-master/build && cd ~/Downloads/ceres-solver-master/build  >>~/Downloads/install.log
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO ..   >>~/Downloads/install.log
make -j"$(nproc)" | tee -a ~/Downloads/install.log
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install >>~/Downloads/install.log

echo " "
echo " "
echo "------------------ G2O ------------------ "  | tee -a ~/Downloads/install.log
cd ~/Downloads
if [ ! -f g2o-master.zip  ]; then 
    echo "G2O: download..."   | tee -a ~/Downloads/install.log
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O g2o-master.zip https://codeload.github.com/RainerKuemmerle/g2o/zip/master 
fi
if [ ! -d ~/Downloads/g2o-master ]; then
    unzip -o g2o-master.zip   >>~/Downloads/install.log
fi

echo "G2O: compile & install..."   | tee -a ~/Downloads/install.log
mkdir -p ~/Downloads/g2o-master/build && cd ~/Downloads/g2o-master/build   >>~/Downloads/install.log
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO ..    >>~/Downloads/install.log
make -j"$(nproc)"  | tee -a ~/Downloads/install.log
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install   >>~/Downloads/install.log

echo " "
echo " "
echo "------------------ PCL ------------------ "   | tee -a ~/Downloads/install.log
cd ~/Downloads
if [ ! -f pcl-master.zip  ]; then 
    echo "PCL: download..."  | tee -a ~/Downloads/install.log
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O pcl-master.zip https://codeload.github.com/PointCloudLibrary/pcl/zip/master 
fi
if [ ! -d ~/Downloads/pcl-master ]; then
    unzip -o pcl-master.zip   >> ~/Downloads/install.log
fi

echo "PCL: compile & install..."   | tee -a ~/Downloads/install.log
mkdir -p ~/Downloads/pcl-master/build && cd ~/Downloads/pcl-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local .. 
make -j"$(nproc)"  | tee -a ~/Downloads/install.log
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install  >>~/Downloads/install.log


echo " "
echo " "
echo "------------------ opencv 3.2.1 ------------------ "  | tee -a ~/Downloads/install.log
cd ~/Downloads
if [ ! -f opencv-3.2.0.zip  ]; then   
    echo "opencv: download..."   | tee -a ~/Downloads/install.log
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O opencv-3.2.0.zip https://github.com/opencv/opencv/archive/3.2.0.zip
fi
if [ ! -d ~/Downloads/opencv-3 ]; then
    unzip -o opencv-3.2.0.zip    >>~/Downloads/install.log
fi


cd ~/Downloads
if [ ! -f opencv_contrib-3.2.0.zip  ]; then 
    echo "opencv-contrib: download..."  | tee -a ~/Downloads/install.log
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O opencv_contrib-3.2.0.zip  https://github.com/opencv/opencv_contrib/archive/3.2.0.zip
fi
if [ ! -d ~/Downloads/opencv_contrib-3.2.0 ]; then
    unzip -o opencv_contrib-3.2.0.zip  >>~/Downloads/install.log
fi


cd ~/Downloads
if [ ! -f ~/Downloads/opencv-3.2.0/3rdparty/ippicv/downloads/linux-808b791a6eac9ed78d32a7666804320e/ippicv_linux_20151201.tgz ]; then 
    echo "ippicv: download..."  | tee -a ~/Downloads/install.log
    mkdir -p ~/Downloads/opencv-3.2.0/3rdparty/ippicv/downloads/linux-808b791a6eac9ed78d32a7666804320e/
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O  ~/Downloads/opencv-3.2.0/3rdparty/ippicv/downloads/linux-808b791a6eac9ed78d32a7666804320e/ippicv_linux_20151201.tgz  https://raw.githubusercontent.com/Itseez/opencv_3rdparty/81a676001ca8075ada498583e4166079e5744668/ippicv/ippicv_linux_20151201.tgz
fi

echo "opencv: compile & install..."  | tee -a ~/Downloads/install.log
mkdir -p ~/Downloads/opencv-3.2.0/build && cd ~/Downloads/opencv-3.2.0/build 
cmake  -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local \
       -D INSTALL_PYTHON_EXAMPLES=ON  -D INSTALL_C_EXAMPLES=ON \
       -D WITH_TBB=ON  -D WITH_V4L=ON -D WITH_QT=ON  -D WITH_GTK=ON  -D WITH_OPENGL=ON \
       -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF \
       -D WITH_IPP=ON -D WITH_FFMPEG=ON -D FORCE_VTK=ON \
       -D BUILD_DOCS=OFF -DPYTHON_EXECUTABLE=$(which python) \
       -D OPENCV_EXTRA_MODULES_PATH=~/Downloads/opencv_contrib-3.2.0/modules ..   >>~/Downloads/install.log

make -j"$(nproc)"  | tee -a ~/Downloads/install.log
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install   >>~/Downloads/install.log



echo " "
echo " "
echo "------------------ opencv 3.4.1 ------------------ "  | tee -a ~/Downloads/install.log
cd ~/Downloads
if [ ! -f opencv-3.4.1.zip  ]; then   
    echo "opencv: download..."   | tee -a ~/Downloads/install.log
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O opencv-3.4.1.zip  https://codeload.github.com/opencv/opencv/zip/3.4.1
fi
if [ ! -d ~/Downloads/opencv-3.4.1 ]; then
    unzip -o opencv-3.4.1.zip   | tee -a ~/Downloads/install.log
fi

cd ~/Downloads
if [ ! -f opencv_contrib-3.4.0.zip  ]; then 
    echo "opencv-contrib: download..."  | tee -a ~/Downloads/install.log
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O opencv_contrib-3.4.0.zip  https://github.com/opencv/opencv_contrib/archive/3.4.0.zip
fi
if [ ! -d ~/Downloads/opencv_contrib-3.4.0 ]; then
    unzip -o opencv_contrib-3.4.0.zip   | tee -a ~/Downloads/install.log
fi

cp ~/Downloads/opencv3.4.cache.zip  ~/Downloads/opencv-3.4.1
cd ~/Downloads/opencv-3.4.1/
unzip -o opencv3.4.cache.zip    | tee -a ~/Downloads/install.log


cd ~/Downloads
if [ ! -f ~/Downloads/opencv-3.4.1/.cache/ippicv/4e0352ce96473837b1d671ce87f17359-ippicv_2017u3_lnx_intel64_general_20170822.tgz ]; then 
     echo "ippicv: download..."  | tee -a ~/Downloads/install.log
     mkdir -p ~/Downloads/opencv-3.4.1/.cache/ippicv/
     wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O ~/Downloads/opencv-3.4.1/.cache/ippicv/4e0352ce96473837b1d671ce87f17359-ippicv_2017u3_lnx_intel64_general_20170822.tgz  https://github.com/opencv/opencv_3rdparty/blob/ippicv/master_20170822/ippicv/ippicv_2017u3_lnx_intel64_general_20170822.tgz
fi

echo "opencv: compile & install..."  | tee -a ~/Downloads/install.log
mkdir -p ~/Downloads/opencv-3.4.1/build && cd ~/Downloads/opencv-3.4.1/build 
cmake  -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local \
       -D INSTALL_PYTHON_EXAMPLES=ON  -D INSTALL_C_EXAMPLES=ON \
       -D WITH_TBB=ON  -D WITH_V4L=ON -D WITH_QT=ON  -D WITH_GTK=ON  -D WITH_OPENGL=ON \
       -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF \
       -D WITH_IPP=ON -D WITH_FFMPEG=ON   \
       -D BUILD_DOCS=OFF -DPYTHON_EXECUTABLE=$(which python) \
       -D OPENCV_EXTRA_MODULES_PATH=~/Downloads/opencv_contrib-3.4.0/modules ..     | tee -a ~/Downloads/install.log

make -j"$(nproc)"  | tee -a ~/Downloads/install.log
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install   >>~/Downloads/install.log



#https://raw.githubusercontent.com/Itseez/opencv_3rdparty/81a676001ca8075ada498583e4166079e5744668/ippicv/ippicv_linux_20151201.tgz
#https://github.com/opencv/opencv_3rdparty/blob/ippicv/master_20151201/ippicv/ippicv_linux_20151201.tgz
#https://github.com/opencv/opencv_3rdparty/blob/ippicv/master_20170822/ippicv/ippicv_2017u3_lnx_intel64_general_20170822.tgz
# 将opencv的库加入到路径，从而让系统可以找到
# sudo gedit /etc/ld.so.conf.d/opencv.conf
# 末尾加入/usr/local/lib，保存退出
# sudo ldconfig #使配置生效
# sudo gedit /etc/bash.bashrc 
# 末尾加入
# PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
# export PKG_CONFIG_PATH
# 保存退出
# sudo source /etc/bash.bashrc  #使配置生效
# sudo updatedb #更新database
