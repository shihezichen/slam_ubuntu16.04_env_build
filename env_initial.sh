#!/bin/sh

# description: build the slam development environment .
#     include the dependency libraries, Eigen3, Sophus, Pangolin, Ceres, G2O, 
#     PCL and  opencv3.2.1 and opencv 3.4.1

# Author: shihezichen@live.cn


# the install log file
log_file=~/Downloads/install.log
log_file_bak=${log_file}.bak

# func: show message at screen 
# para: message to show
msg(){ 
    echo $@
}

# func: show message at screen and logfile
# para: message to show
msg_all(){
    echo $@ | tee -a $log_file
}

# func: execute the cmd without any cmd show at screen, and store the process to log file record
# para: the cmd 
exec_cmd_quiet() {
     $@ >> $log_file
	 if [ $? -ne 0 ]; then
	     msg_all " "
	     msg_all "ERROR!  exit with code 1"
		 exit 1
	 fi
}

# func:  execute the cmd with cmd show at screen, and store the process to log file record
# para: the cmd 
exec_cmd_log() {
     msg_all "$@"
	 exec_cmd_quiet $@
}

# func:  execute the cmd and show proecess at screen and store them to log file record
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

# func: install depend lib with apt-get 
# para: the libs' name
install_lib() {
   msg_all " "
   msg_all "install $@"
   exec_cmd_quiet "sudo apt-get install -y $@"
   if [ $? -eq 0 ]; then
	msg_all "done."
   fi
}

# func: download file to local directory '~/Downloads'
# para1: the local file name, e.g. Sophus-master.zip
# para2: the remote url of file,e.g.  https://codeload.github.com/strasdat/Sophus/zip/master 
wget_file() {
    option='--no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16 -nv -c -O '
    if [ ! -f "$1" ]; then 
		msg_all "$1 download ... "
		exec_cmd_quiet wget $option ~/Downloads/$1  $2
	fi
}


# func: show title of source code before compile and install
# para: the title
show_app_titile() {
	msg_all " "
	msg_all " "
	msg_all "$@"
}

# func:  install lib with source code
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

# func:  install opencv 3.2.0
install_opencv3_2_0() {
	cd ~/Downloads

	# opencv 
	opencv_local_file="opencv-3.2.0.zip"
	opencv_url="https://github.com/opencv/opencv/archive/3.2.0.zip"
	wget_file ${opencv_local_file}  ${opencv_url}
	if [ ! -d ~/Downloads/$opencv_local_file ]; then
		exec_cmd_log "unzip -o $opencv_local_file"	
	fi
	
	# opencv_contrib
	contrib_local_file="opencv_contrib-3.2.0.zip"
	contrib_url="https://github.com/opencv/opencv_contrib/archive/3.2.0.zip"
	if [ ! -d ~/Downloads/${contrib_local_file} ]; then
		wget_file ${contrib_local_file}  ${contrib_url}
		exec_cmd_log "unzip -o ${contrib_local_file}"	
	fi

	# ippicv
    opencv_ippicv_path="~/Downloads/opencv-3.2.0/3rdparty/ippicv/downloads/linux-808b791a6eac9ed78d32a7666804320e"
	mkdir -p ${opencv_ippicv_path}
	ippicv_local_file="${opencv_ippicv_path}/ippicv_linux_20151201.tgz"
	ippicv_url="https://raw.githubusercontent.com/Itseez/opencv_3rdparty/81a676001ca8075ada498583e4166079e5744668/ippicv/ippicv_linux_20151201.tgz"
	if [ ! -f ${ippicv_local_file} ]; then
		option='--no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16 -nv -c -O '
		msg_all "ippicv_linux_20151201.tgz download ... "
		wget $option ${ippicv_local_file}  ${ippicv_url} 
	fi
	
	msg_all "opencv3.2.1 compile and install ..."
	mkdir -p ~/Downloads/opencv-3.2.0/build && cd ~/Downloads/opencv-3.2.0/build
    cmd="cmake  -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local \
		-D INSTALL_PYTHON_EXAMPLES=ON  -D INSTALL_C_EXAMPLES=ON \
		-D WITH_TBB=ON  -D WITH_V4L=ON -D WITH_QT=ON  -D WITH_GTK=ON  -D WITH_OPENGL=ON \
		-D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF \
		-D WITH_IPP=ON -D WITH_FFMPEG=ON -D FORCE_VTK=ON \
		-D BUILD_DOCS=OFF -DPYTHON_EXECUTABLE=$(which python) \
		-D OPENCV_EXTRA_MODULES_PATH=~/Downloads/opencv_contrib-3.2.0/modules .. "
	exec_cmd_log $cmd
	exec_cmd_all "make -j$(nproc)" 
	exec_cmd_log "sudo make install"
}

install_opencv3_4_1() {
	cd ~/Downloads

	# opencv
	opencv_local_file="opencv-3.4.1.zip"
	opencv_url="https://codeload.github.com/opencv/opencv/zip/3.4.1"
	wget_file ${opencv_local_file}  ${opencv_url}
	if [ ! -f ~/Downloads/$opencv_local_file ]; then
		exec_cmd_log "unzip -o $opencv_local_file"	
	fi

	# opencv_contrib
	contrib_local_file="opencv_contrib-3.4.0.zip"
	contrib_url="https://github.com/opencv/opencv_contrib/archive/3.4.0.zip"
	wget_file ${contrib_local_file}  ${contrib_url}
	if [ ! -d ~/Downloads/${contrib_local_file} ]; then
		exec_cmd_log "unzip -o ${contrib_local_file}"	
	fi

	# opencv3.4 .cache directory ( include ippicv and others )
	opencv_cache_file="opencv3.4.cache.zip"
	msg_all "cp ~/Downloads/${opencv_cache_file}  ~/Downloads/opencv-3.4.1"
	cp ~/Downloads/${opencv_cache_file}  ~/Downloads/opencv-3.4.1
	cd ~/Downloads/opencv-3.4.1/
    exec_cmd_log "unzip -o ${opencv_cache_file}"	
	cd ~/Downloads

	# ippicv
#	mkdir -p ~/Downloads/opencv-3.4.1/.cache/ippicv/
#	ippicv_local_file="~/Downloads/opencv-3.4.1/.cache/ippicv/4e0352ce96473837b1d671ce87f17359-ippicv_2017u3_lnx_intel64_general_20170822.tgz"
#	ippicv_url="https://github.com/opencv/opencv_3rdparty/blob/ippicv/master_20170822/ippicv/ippicv_2017u3_lnx_intel64_general_20170822.tgz"
#	if [ ! -f ${ippicv_local_file} ]; then
#		option='--no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16 -nv -c -O '
#		msg_all "ippicv_2017u3_lnx_intel64_general_20170822.tgz download ... "
#		cd ~/Downloads/opencv-3.4.1/.cache/ippicv/
#		wget ${option}  ${ippicv_local_file}  ${ippicv_url} 
#		cd ~/Downloads
#	fi

	msg_all "opencv3.2.1 compile and install ..."	
	mkdir -p ~/Downloads/opencv-3.4.1/build && cd ~/Downloads/opencv-3.4.1/build 
    cmd="cmake  -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local \
			-D INSTALL_PYTHON_EXAMPLES=ON  -D INSTALL_C_EXAMPLES=ON \
			-D WITH_TBB=ON  -D WITH_V4L=ON -D WITH_QT=ON  -D WITH_GTK=ON  -D WITH_OPENGL=ON \
			-D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF \
			-D WITH_IPP=ON -D WITH_FFMPEG=ON   \
			-D BUILD_DOCS=OFF -DPYTHON_EXECUTABLE=$(which python) \
			-D OPENCV_EXTRA_MODULES_PATH=~/Downloads/opencv_contrib-3.4.0/modules .. "
	exec_cmd_log $cmd
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

    msg_all ""
	msg_all "------------------ Start installation ------------------"
	msg_all "All information will be stored at $log_file."
	msg_all ""

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

    msg_all  " copy the eigen3 to /usr/local/include to avoid opencv3 compile issue "
    exec_cmd_all "sudo cp -r /usr/include/eigen3/unsupported  /usr/local/include/"

	show_app_titile "------------------ Sophus ------------------"
	install_src  Sophus-master.zip https://codeload.github.com/strasdat/Sophus/zip/master   Sophus-master

	show_app_titile "------------------ Pangolin ------------------"
	install_src   Pangolin-master.zip https://codeload.github.com/zzx2GH/Pangolin/zip/master   Pangolin-master

	show_app_titile "------------------ Ceres ------------------"
	install_src   ceres-solver-master.zip https://codeload.github.com/ceres-solver/ceres-solver/zip/master   ceres-solver-master

	show_app_titile "------------------ G2O ------------------"
	install_src   g2o-master.zip https://codeload.github.com/RainerKuemmerle/g2o/zip/master   g2o-master

	show_app_titile "------------------ PCL ------------------"
	install_src   pcl-master.zip https://codeload.github.com/PointCloudLibrary/pcl/zip/master    pcl-master

	show_app_titile "------------------ Opencv 3.2.0 + contrib 3.2.0 + ippicv 20151201 ------------------"
	install_opencv3_2_0

	show_app_titile "------------------ Opencv 3.4.1 + contrib 3.4.0 + ippicv 20170822 ------------------"
	install_opencv3_4_1

}

#
# ----- main process ---------
#
main
