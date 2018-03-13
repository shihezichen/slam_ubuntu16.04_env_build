#!/bin/sh

# description: reset the environment: delete all downloads packages.
# it is often used when previous installation is interrupted abnormally.

# Author: shihezichen@live.cn

# para1: app name for show
# para2: zip file name
# para3: directory name
clean_pkg() {
	if [ $# -ne 3 ]; then
	    echo "ERROR: parameter's number wrong."
		return 1
	fi 
	echo "delete $1 zip file and directory ..."
	zip=~/Downloads/$2
	dir=~/Downloads/$3
	if [ -f $zip ]; then
		echo -- rm -f $zip
		rm -f $zip
	fi
	if [ -d $dir ]; then
		echo -- rm -rf ~/Downloads/$3
		rm -rf ~/Downloads/$3
	fi
	echo "done."
	echo ""
}

echo ""
echo "WARNING: This program will delete all download packages and unzipped directories at ~/Downloads."
echo "BUT it doesn't remove the packages which have been installed into OS."
echo ""
echo -n "Do you want to continue(y|N) ?: "
read  answer
if [ "-$answer" != "-y"  ]; then
	echo "Canceled."
    exit 0;
fi

clean_pkg  Sophus  Sophus-master.zip  Sophus-master

clean_pkg  Pangolin  Pangolin-master.zip  Pangolin-master

clean_pkg  Ceres  ceres-solver-master.zip  ceres-solver-master

clean_pkg  G2O  g2o-master.zip   g2o-master 

clean_pkg  PCL  pcl-master.zip   pcl-master 

clean_pkg  OpenCV3.2.0  opencv-3.2.0.zip  opencv-3.2.0
clean_pkg  Opencv_contrib-3.2.0  opencv_contrib-3.2.0.zip  opencv_contrib-3.2.0
clean_pkg  ippicv    ippicv_linux_20151201.tgz    ippicv_linux_20151201

clean_pkg   OpenCV3.4.1   opencv-3.4.1.zip   opencv-3.4.1 
clean_pkg   Opencv_contrib-3.4.0  opencv_contrib-3.4.0.zip   opencv_contrib-3.4.0
clean_pkg  ippicv    ippicv_2017u3_lnx_intel64_general_20170822.tgz  ippicv_2017u3_lnx_intel64_general_20170822

echo "The result of ~/Downloads:"
ls -al ~/Downloads



