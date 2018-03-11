#!/bin/sh

log_file=~/Downloads/install.log
log_file_bak=${log_file}.bak

# show message at screen 
# para: message to show
msg(){ 
    echo $@
}

# show message at screen and logfile
# para: message to show
msg_all(){
    echo $@ | tee -a $log_file
}

# execute the cmd without any cmd show at screen, and store the process to log file record
# para: the cmd 
exec_cmd_quiet() {
     $@ >> $log_file
	 if [ $? -ne 0 ]; then
	     msg_all " "
	     msg_all "ERROR!  exit with code 1"
		 exit 1
	 fi
}

# execute the cmd with cmd show at screen, and store the process to log file record
# para: the cmd 
exec_cmd_log() {
     msg_all "$@"
	 exec_cmd_quiet $@
}

# execute the cmd and show proecess at screen and store them to log file record
# para: the cmd
exec_cmd_all() {
     msg_all "$@"
     $@ | tee -a  $log_file
	 if [ $? -ne 0 ]; then
	     msg_all " "
	     msg_all "ERROR!  exit with code 1"
		 exit 1
	 fi
}

# install depend lib with apt-get 
# para: the libs' name
install_lib() {
   msg_all " "
   msg_all "install $@"
   exec_cmd_quiet "sudo apt-get install -y $@"
}

# download file to local directory
# para1: the local file name, e.g. Sophus-master.zip
# para2: the remote url of file,e.g.  https://codeload.github.com/strasdat/Sophus/zip/master 
wget_file() {
    option='--no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16 -nv -c -O '
    if [ ! -f "$1" ]; then 
		msg_all "$1 download ... "
		exec_cmd_quiet wget $option ~/Downloads/$1  $2
	fi
}


# show title of source code before compile and install
install_src_title() {
	msg_all " "
	msg_all " "
	msg_all "$@"
}

# install lib with source code
# para1: the local file name
# para2: the remote url
# para3: dir name
install_src() {
	cd ~/Downloads
	wget_file $1 $2
	exec_cmd_log "unzip -o $1"
	msg_all "$1 compile and install ..."
	exec_cmd_log "mkdir -p ~/Downloads/$3/build"
	cd ~/Downloads/$3/build
    exec_cmd_log "cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local  .. "
	exec_cmd_all "make -j$(nproc)" 
	exec_cmd_log "sudo make install"

}

# main process
main() {
    # all package will download to ~/Downloads 
    mkdir -p  ~/Downloads && cd ~/Downloads

	# create new log file and back old log file
    mv ~/Downloads/install.log  ~/Downloads/install.log.bak
    touch ~/Downloads/install.log

	msg_all "start installation. all information will be stored at $log_file"

    # ToDo: replace the apt sources with domestic source 

    # apt update
    exec_cmd_log "sudo apt-get update"


    msg_all  " "
	msg_all  " "
	msg_all  "------------------ apt install all depend libraries ------------------"

	install_lib "vim g++ unzip wget git git-core build-essential cmake  doxygen"
	install_lib "freeglut3 freeglut3-dbg freeglut3-dev gfortran graphviz libgtk2.0-dev"
	install_lib "libatlas-base-dev libavcodec-dev libavformat-dev libeigen3-dev  "
	install_lib "libboost-dev libboost-filesystem-dev libboost-system1.58-dev libboost-thread-dev   "
	install_lib "libcholmod3.0.6 ccache libcxsparse3.1.4 libeigen3-dev libflann-dev  libflann1.8"
	install_lib "libgflags-dev libglew-dev libgoogle-glog-dev libgtest-dev libboost-all-dev libqhull*"
	install_lib "libjasper-dev libjpeg8-dev libpng-dev libtiff-dev  libjpeg-dev libdc1394-22-dev liblapack-dev "
	install_lib "libphonon-dev libpng12-dev libqglviewer2 libqglviewer-dev libqhull-dev libopenexr-dev libpcap-dev "
	install_lib "libqt4-dev libsuitesparseconfig4.4.6 libsuitesparse-dev libswscale-dev liblapacke-dev "
	install_lib "libtbb-dev libtiff5-dev libudev-dev libusb-1.0-0-dev libusb-dev "
	install_lib "libv4l-dev libvtk5-dev libvtk5-qt4-dev libvtk-java libx264-dev  libvtk5.10-qt4 libvtk5.10 qt5-default "
	install_lib "pkg-config python2.7-dev python3.5-dev python3-dev python-numpy  python3-numpy python-vtk  "
	install_lib "libtbb2 libtbb-dev  qt4-qmake qt-sdk tcl-vtk pylint libxi-dev libxmu-dev libxvidcore-dev "
	install_lib "openjdk-8-jdk openmpi-bin openmpi-common  openjdk-8-jre   "
	install_lib "libxml2-dev libxslt-dev libffi-dev libsdl1.2-dev libssl-dev mono-complete mpi-default-dev "
	# opencv --use lapack,
	install_lib "liblapacke-dev checkinstall libopenblas-dev phonon-backend-gstreamer phonon-backend-vlc"
	#install_lib "adwaita-icon-theme adwaita-icon-theme-ful"

    msg_all  " copy the eigen3 to /usr/local/include to avoid opencv3 compile problem "
    exec_cmd_all "sudo cp -r /usr/include/eigen3/unsupported  /usr/local/include/"

	install_src_title "------------------ Sophus ------------------"
	install_src  Sophus-master.zip https://codeload.github.com/strasdat/Sophus/zip/master   Sophus-master

	install_src_title "------------------ Pangolin ------------------"
	install_src   Pangolin-master.zip https://codeload.github.com/zzx2GH/Pangolin/zip/master   Pangolin-master

	install_src_title "------------------ Ceres ------------------"
	install_src   ceres-solver-master.zip https://codeload.github.com/ceres-solver/ceres-solver/zip/master   ceres-solver-master

	install_src_title "------------------ G2O ------------------"
	install_src   g2o-master.zip https://codeload.github.com/RainerKuemmerle/g2o/zip/master   g2o-master


	install_src_title "------------------ PCL ------------------"
	install_src   pcl-master.zip https://codeload.github.com/PointCloudLibrary/pcl/zip/master    pcl-master

	# todo: opencv 3.2.1
}

main



exit 0




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

