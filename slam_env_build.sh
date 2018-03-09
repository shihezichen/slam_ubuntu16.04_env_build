

sudo apt update


sudo apt install -y \
	vim g++ unzip wget git git-core build-essential cmake \
	freeglut3 freeglut3-dbg freeglut3-dev gfortran graphviz \
	libatlas-base-dev libavcodec-dev libavformat-dev \
	libboost-dev libboost-filesystem-dev libboost-system1.58-dev libboost-thread-dev \
	libcholmod3.0.6 libcxsparse3.1.4 libeigen3-dev libflann-dev \
	libgflags-dev libglew-dev libgoogle-glog-dev libgtest-dev \
	libjasper-dev libjpeg8-dev libjpeg-dev liblapack-dev libopenexr-dev libpcap-dev \
	libphonon-dev libpng12-dev libqglviewer2 libqglviewer-dev libqhull-dev \
	libqt4-dev libsuitesparseconfig4.4.6 libsuitesparse-dev libswscale-dev \
	libtbb-dev libtiff5-dev libudev-dev libusb-1.0-0-dev libusb-dev \
	libv4l-dev libvtk5-dev libvtk5-qt4-dev libvtk-java libx264-dev \
	pkg-config python2.7-dev python3.5-dev python-vtk qt4-qmake qt-sdk tcl-vtk \
	libxi-dev libxmu-dev libxvidcore-dev mono-complete mpi-default-dev \
	openjdk-8-jdk openmpi-bin openmpi-common \
	adwaita-icon-theme adwaita-icon-theme-full \
	phonon-backend-gstreamer phonon-backend-vlc 


mkdir -p  ~/Downloads && cd ~/Downloads
if [ ! -f Sophus-master.zip  ]; then
    echo "Sophus: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O Sophus-master.zip https://codeload.github.com/strasdat/Sophus/zip/master 
    unzip Sophus-master.zip 
fi
echo "Sophus: compile & install..." 
mkdir -p ~/Downloads/Sophus-master/build && cd ~/Downloads/Sophus-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
make -j"$(nproc)" && make install 

cd ~/Downloads
if [ ! -f Pangolin-master.zip  ]; then
    echo "Pangolin: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O Pangolin-master.zip https://codeload.github.com/zzx2GH/Pangolin/zip/master 
    unzip Pangolin-master.zip 
fi
echo "Pangolin: compile & install..." 
mkdir -p ~/Downloads/Pangolin-master/build && cd ~/Downloads/Pangolin-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
make -j"$(nproc)" && make install 

cd ~/Downloads
if [ ! -f ceres-solver-master.zip  ]; then
    echo "Ceres: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O ceres-solver-master.zip https://codeload.github.com/ceres-solver/ceres-solver/zip/master 
    unzip ceres-solver-master.zip 
fi
echo "Ceres: compile & install..." 
mkdir -p ~/Downloads/ceres-solver-master/build && cd ~/Downloads/ceres-solver-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
make -j"$(nproc)" && make install 

cd ~/Downloads
if [ ! -f g2o-master.zip  ]; then 
    echo "G2O: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O g2o-master.zip https://codeload.github.com/RainerKuemmerle/g2o/zip/master 
    unzip g2o-master.zip 
fi
echo "G2O: compile & install..." 
mkdir -p ~/Downloads/g2o-master/build && cd ~/Downloads/g2o-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
make -j"$(nproc)" && make install 

cd ~/Downloads
if [ ! -f pcl-master.zip  ]; then 
    echo "PCL: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O pcl-master.zip https://codeload.github.com/PointCloudLibrary/pcl/zip/mast 
    unzip pcl-master.zip 
fi
echo "PCL: compile & install..." 
mkdir -p /Downloads/pcl-master/build && cd ~/Downloads/pcl-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
make -j"$(nproc)" && make install 

