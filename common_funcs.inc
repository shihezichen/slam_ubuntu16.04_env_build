#!/bin/dash

# description: common functions library.

# Author: shihezichen@live.cn

# global variables
# the install log file
log_file=~/Downloads/install.log
log_file_bak=${log_file}.bak

# func: show message at screen 
# para: message to show
msg(){ 
    echo $*
}

# func: show message at screen and logfile
# para: message to show
msg_all(){
    echo $@ | tee -a $log_file
}

# func: just store info to logfile
# para: message to store to logfile
msg_log() {
	echo $@ >> $log_file
}

# func: execute the cmd without any cmd show at screen, and store the process to log file record
# para: the cmd 
exec_cmd_quiet() {
     eval $* >> $log_file  2>&1
	 if [ $? -ne 0 ]; then
	     msg_all " "
	     msg_all "ERROR!  exit with code 1.  "
		 msg_all "please to see the $log_file to get the detailed information."
		 exit 1
	 fi
}

# func:  execute the cmd with cmd show at screen, and store the process to log file record
# para: the cmd 
exec_cmd_log() {
     msg_all "-- $@"
	 exec_cmd_quiet $@
}

# func:  execute the cmd and show proecess at screen and store them to log file record
# para: the cmd
exec_cmd_all() {
     msg_all "-- $*"
     eval $* | tee -a  $log_file 
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
   msg_all "check and install $*"
   exec_cmd_quiet "sudo apt-get install -y $*"
   if [ $? -eq 0 ]; then
	    msg_all "done."
   fi
}

# func: download file to local directory '~/Downloads' if it doesn't exist
# para1: the local file name, e.g. Sophus-master.zip
# para2: the remote url of file,e.g.  https://codeload.github.com/strasdat/Sophus/zip/master 
wget_file() {
    #option='--no-check-certificate -nv -c -O '
	option='--no-check-certificate -c -O '
	file=~/Downloads/$1
    if [ ! -f $file ]; then 
		msg_all "$1 download ... "
		exec_cmd_all "wget $option  $file   $2"
		if [ ! -f $file ]; then
			msg_all "ERROR: can't download file $file. "
			exit 1
		fi
	else
		msg_all "WARNING: FIND $1 FILE, REUSE IT. "
		msg_all "WARNING: Please remove the file $1 and try again if you want re-download it."		
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
	if [ ! -d ~/Downloads/$3 ]; then
		exec_cmd_log "unzip -o $1"
	else
		msg_all "WARNING: FIND $3 DIRECTORY, REUSE IT. "
		msg_all "WARNING: Please remove the directory $3  and try again if you want re-unzip $1 and overwrite ~/Downloads/$3 directory."
	fi
	msg_all "$3 compile and install ..."
	exec_cmd_log mkdir -p ~/Downloads/$3/build
	cd ~/Downloads/$3/build
    exec_cmd_log "cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local  .. "
	exec_cmd_all "make  -j$(nproc)" 
	exec_cmd_log "sudo make install"
	cd ~/Downloads

}

# func: install Eigen3 from sourc
install_eigen3_3_5() {
	cd ~/Downloads

	# eigen3
	eigen_local_file="eigen-3.3.5.zip"
	eigen_url="http://bitbucket.org/eigen/eigen/get/3.3.5.zip"
	wget_file ${eigen_local_file}  ${eigen_url}
	if [ ! -d ~/Downloads/eigen-3.3.5 ]; then
		exec_cmd_log "unzip -d ~/Downloads/eigen-3.3.5 -o ${eigen_local_file}"
	fi
	exec_cmd_log "sudo cp -pr eigen-3.3.5/eigen-eigen-b3f3d4950030  /usr/include/eigen3"
	exec_cmd_log "sudo cp -pr eigen-3.3.5/eigen-eigen-b3f3d4950030/Eigen /usr/include"
}

# func:  install opencv 3.2.0
install_opencv3_2_0() {
	cd ~/Downloads

	# opencv 
	opencv_local_file="opencv-3.2.0.zip"
	opencv_url="https://github.com/opencv/opencv/archive/3.2.0.zip"
	wget_file ${opencv_local_file}  ${opencv_url}
	if [ ! -d ~/Downloads/opencv-3.2.0 ]; then
		exec_cmd_log "unzip -o $opencv_local_file"	
	fi
	
	# opencv_contrib
	cd ~/Downloads
	contrib_local_file="opencv_contrib-3.2.0.zip"
	contrib_url="https://github.com/opencv/opencv_contrib/archive/3.2.0.zip"
	if [ ! -f ~/Downloads/${contrib_local_file} ]; then
		wget_file ${contrib_local_file}  ${contrib_url}
		exec_cmd_log "unzip -o ${contrib_local_file}"	
	fi

	# ippicv
	cd ~/Downloads
	ippicv_local_file="ippicv_linux_20151201.tgz"
    opencv_ippicv_path=~/Downloads/opencv-3.2.0/3rdparty/ippicv/downloads/linux-808b791a6eac9ed78d32a7666804320e
	mkdir -p ${opencv_ippicv_path}
	ippicv_url="https://raw.githubusercontent.com/Itseez/opencv_3rdparty/81a676001ca8075ada498583e4166079e5744668/ippicv/ippicv_linux_20151201.tgz"
	wget_file  $ippicv_local_file  $ippicv_url 
	exec_cmd_log "cp ${ippicv_local_file}  ${opencv_ippicv_path}"
	
	msg_all "opencv3.2.1 compile and install at ~/Downloads/opencv-3.2.0/build..."
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

# func:  install opencv 3.4.1
install_opencv3_4_1() {
	cd ~/Downloads

	# opencv
	opencv_local_file="opencv-3.4.1.zip"
	opencv_url="https://codeload.github.com/opencv/opencv/zip/3.4.1"
	if [ ! -f ~/Downloads/$opencv_local_file ]; then
		wget_file ${opencv_local_file}  ${opencv_url}
	fi
	if [ ! -d ~/Downloads/opencv-3.4.1 ]; then
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
	#
	# IMPORTANT: you should download opencv3.4.cache.zip manually and put it at ~/Downloads
	#
	opencv_cache_file="opencv3.4.cache.zip"
	if [ ! -f ~/Downloads/${opencv_cache_file} ]; then
	    echo ""
		echo "ERROR: Can't find the file ~/Downloads/${opencv_cache_file} . "
		echo "Please download the $opencv_cache_file and put it at ~/Downloads and run me again."
		exit 1
	fi
	msg_all "cp ~/Downloads/${opencv_cache_file}  ~/Downloads/opencv-3.4.1"
	cp ~/Downloads/${opencv_cache_file}  ~/Downloads/opencv-3.4.1
	cd ~/Downloads/opencv-3.4.1/
	exec_cmd_log "unzip -o ${opencv_cache_file}"	
	cd ~/Downloads

	# ippicv
	cd ~/Downloads
	mkdir -p ~/Downloads/opencv-3.4.1/.cache/ippicv/
	ippicv_local_file="ippicv_2017u3_lnx_intel64_general_20170822.tgz"
	ippicv_local_file_in_opencv="~/Downloads/opencv-3.4.1/.cache/ippicv/4e0352ce96473837b1d671ce87f17359-ippicv_2017u3_lnx_intel64_general_20170822.tgz"
	ippicv_url="https://github.com/opencv/opencv_3rdparty/blob/ippicv/master_20170822/ippicv/ippicv_2017u3_lnx_intel64_general_20170822.tgz"
	if [ ! -f ${ippicv_local_file} ]; then
		wget_file 	$ippicv_local_file  $ippicv_url
	fi
	exec_cmd_log cp  ${ippicv_local_file}  ${ippicv_local_file_in_opencv}
	cd ~/Downloads


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


