#!/bin/dash

# description: build the slam development environment .
#     include the dependency libraries, Eigen3, Sophus, Pangolin, Ceres, G2O, 
#     PCL and  opencv3.2.1 and opencv 3.4.1

# Author: shihezichen@live.cn


# cd current shell file directory
cur_path=$(cd `dirname $0`;pwd)
cd $cur_pwd

# include the common fucntions library file
.  ${cur_path}/common_funcs.inc

# func:  install all depend libraries
install_depend_libs() {
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
}


# main process
main() {
    # all package will download to ~/Downloads 
    mkdir -p  ~/Downloads && cd ~/Downloads

    # create new log file and back old log file
    mv ~/Downloads/install.log  ~/Downloads/install.log.bak  2>/dev/null
    touch ~/Downloads/install.log

    msg_all " "
    msg_all "-----------------------------------------------------------------------"
    msg_all "The program will install most depend libraries of SLAM"
    msg_all "e.g. Eigen, Sophus, Ceres, Pangoin,Ceres, G2O, PCL, OpenCV "
    msg_all "It will take several hours to finish all of them. Good Luck!"
    msg_all ". "
    msg_all "This installation starts at : $(date) "
    msg_all "All install information will be recorded in $log_file.  "
    msg_all "-----------------------------------------------------------------------"

    # apt update
    msg_all  " "
    msg_all "Maybe you need input the root password for sudo execution.  "
    exec_cmd_all "sudo apt-get update"


    msg_all  " "
    msg_all  "------------------ apt install all depend libraries ------------------"
    install_depend_libs

    msg_all  " copy the eigen3 to /usr/local/include to avoid opencv3 compile issue "
    exec_cmd_all "sudo cp -r /usr/include/eigen3/unsupported  /usr/local/include/"

    show_app_titile "------------------ Sophus ------------------"
    install_src  Sophus-master.zip https://codeload.github.com/strasdat/Sophus/zip/master   Sophus-master

    show_app_titile "------------------ Pangolin ------------------"
    install_src   Pangolin-master.zip https://codeload.github.com/zzx2GH/Pangolin/zip/master   Pangolin-master

    show_app_titile "------------------ Ceres ------------------"
    install_src   ceres-solver-master.zip https://codeload.github.com/ceres-solver/ceres-solver/zip/master  ceres-solver-master

    show_app_titile "------------------ G2O ------------------"
    install_src   g2o-master.zip https://codeload.github.com/RainerKuemmerle/g2o/zip/master   g2o-master

    show_app_titile "------------------ PCL ------------------"
    install_src   pcl-master.zip https://codeload.github.com/PointCloudLibrary/pcl/zip/master    pcl-master

    show_app_titile "------------------ Opencv 3.2.0 + contrib 3.2.0 + ippicv 20151201 ------------------"
    install_opencv3_2_0

    #show_app_titile "------------------ Opencv 3.4.1 + contrib 3.4.0 + ippicv 20170822 ------------------"
    #install_opencv3_4_1

}

#
# ----- main process ---------
#
main $@

