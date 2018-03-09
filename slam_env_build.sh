
# src_file=/etc/apt/sources.list
# echo backup the $src_file to ${src_file}.bak
# sudo cp ${src_file}  ${src_file}.bak
# sudo rm -f $src_file 
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted           >   ${src_file} 
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted   >>  ${src_file} 
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial universe                  >>  ${src_file} 
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe          >>  ${src_file} 
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse                >>  ${src_file} 
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse        >>  ${src_file} 
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse >>  ${src_file}   
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted  >>  ${src_file} 
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe         >>  ${src_file} 
# sudo echo deb http://mirrors.aliyun.com/ubuntu/ xenial-security multiverse       >>  ${src_file} 
# sudo echo deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted multiverse universe #Added by software-properties              >>  ${src_file} 
# sudo echo deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted multiverse universe #Added by software-properties      >>  ${src_file} 
# sudo echo deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse #Added by software-properties    >>  ${src_file} 
# sudo echo deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted multiverse universe #Added by software-propertie      >>  ${src_file}   
sudo apt update

# ftp_file=/etc/vsftpd.conf
# ftp_users_file=/etc/allowed_users
# echo backup the $ftp_file to ${ftp_file}.bak
# sudo cp ${ftp_file}  ${ftp_file}.bak
# sudo rm -f ${ftp_file}
# sudo echo #start config			> ${ftp_file} 
# sudo echo anonymous_enable=NO		>> ${ftp_file} 
# sudo echo anon_upload_enable		>> ${ftp_file} 
# sudo echo anon_mkdir_write_enable=yes	>> ${ftp_file} 
# sudo echo connect_from_port_20=YES	>> ${ftp_file} 
# sudo echo chroot_local_user=yes		>> ${ftp_file} 
# sudo echo dirmessage_enable=YES		>> ${ftp_file} 
# sudo echo echo userlist_deny=NO		>> ${ftp_file}		
# sudo echo listen=NO			>> ${ftp_file} 
# sudo echo listen_ipv6=YES		>> ${ftp_file} 
# sudo echo local_enble=yes		>> ${ftp_file}
# sudo echo local_enable=YES		>> ${ftp_file} 
# sudo echo rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem		>> ${ftp_file} 
# sudo echo rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key	>> ${ftp_file} 
# sudo echo seccomp_sandbox=NO				>> ${ftp_file} 
# sudo echo ssl_enable=NO					>> ${ftp_file} 
# sudo echo secure_chroot_dir=/var/run/vsftpd/empty	>> ${ftp_file} 
# sudo echo userlist_deny=NO				>> ${ftp_file} 
# sudo echo write_enable=YES				>> ${ftp_file} 
# sudo echo use_localtime=YES				>> ${ftp_file} 
# sudo echo userlist_enable=YES				>> ${ftp_file} 		
# sudo echo userlist_file=${ftp_users_file}		>> ${ftp_file} 
# sudo echo utf8_filesystem=YES				>> ${ftp_file} 	
# sudo echo pam_service_name=vsftpd			>> ${ftp_file} 
# sudo echo xferlog_enable=YES				>> ${ftp_file} 
# sudo systemctl restart vsftpd
# sudo service vsftpd restart
# 
# sudo cat /dev/null	>  $ftp_users_file	
# sudo echo hadoop	>>  $ftp_users_file	
# sudo echo root		>>  $ftp_users_file	

echo " "
echo " "
echo "------------------ apt install all libraries ------------------ "
sudo apt install -y  vim g++ unzip wget git git-core build-essential cmake 
sudo apt install -y  freeglut3 freeglut3-dbg freeglut3-dev gfortran graphviz 
sudo apt install -y  libatlas-base-dev libavcodec-dev libavformat-dev 
sudo apt install -y  libboost-dev libboost-filesystem-dev libboost-system1.58-dev libboost-thread-dev 
sudo apt install -y  libcholmod3.0.6 libcxsparse3.1.4 libeigen3-dev libflann-dev 
sudo apt install -y  libgflags-dev libglew-dev libgoogle-glog-dev libgtest-dev 
sudo apt install -y  libjasper-dev libjpeg8-dev libjpeg-dev liblapack-dev libopenexr-dev libpcap-dev 
sudo apt install -y  libphonon-dev libpng12-dev libqglviewer2 libqglviewer-dev libqhull-dev 
sudo apt install -y  libqt4-dev libsuitesparseconfig4.4.6 libsuitesparse-dev libswscale-dev 
sudo apt install -y  libtbb-dev libtiff5-dev libudev-dev libusb-1.0-0-dev libusb-dev 
sudo apt install -y  libv4l-dev libvtk5-dev libvtk5-qt4-dev libvtk-java libx264-dev 
sudo apt install -y  pkg-config python2.7-dev python3.5-dev python-vtk qt4-qmake qt-sdk tcl-vtk 
sudo apt install -y  libxi-dev libxmu-dev libxvidcore-dev mono-complete mpi-default-dev 
sudo apt install -y  openjdk-8-jdk openmpi-bin openmpi-common 
# sudo apt install -y  adwaita-icon-theme adwaita-icon-theme-full 
sudo apt install -y  phonon-backend-gstreamer phonon-backend-vlc 

echo " "
echo " "
echo "------------------ Sophus ------------------ "
mkdir -p  ~/Downloads && cd ~/Downloads
if [ ! -f Sophus-master.zip  ]; then
    echo "Sophus: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O Sophus-master.zip https://codeload.github.com/strasdat/Sophus/zip/master 
    unzip Sophus-master.zip 
fi
echo "Sophus: compile & install..." 
mkdir -p ~/Downloads/Sophus-master/build && cd ~/Downloads/Sophus-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
make -j"$(nproc)" 
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install 

echo " "
echo " "
echo "------------------ Pangolin ------------------ "
cd ~/Downloads
if [ ! -f Pangolin-master.zip  ]; then
    echo "Pangolin: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O Pangolin-master.zip https://codeload.github.com/zzx2GH/Pangolin/zip/master 
    unzip Pangolin-master.zip 
fi
echo "Pangolin: compile & install..." 
mkdir -p ~/Downloads/Pangolin-master/build && cd ~/Downloads/Pangolin-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
make -j"$(nproc)" 
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install 

echo " "
echo " "
echo "------------------ Ceres ------------------ "
cd ~/Downloads
if [ ! -f ceres-solver-master.zip  ]; then
    echo "Ceres: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O ceres-solver-master.zip https://codeload.github.com/ceres-solver/ceres-solver/zip/master 
    unzip ceres-solver-master.zip 
fi
echo "Ceres: compile & install..." 
mkdir -p ~/Downloads/ceres-solver-master/build && cd ~/Downloads/ceres-solver-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
make -j"$(nproc)" 
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install 

echo " "
echo " "
echo "------------------ G2O ------------------ "
cd ~/Downloads
if [ ! -f g2o-master.zip  ]; then 
    echo "G2O: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O g2o-master.zip https://codeload.github.com/RainerKuemmerle/g2o/zip/master 
    unzip g2o-master.zip 
fi
echo "G2O: compile & install..." 
mkdir -p ~/Downloads/g2o-master/build && cd ~/Downloads/g2o-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
make -j"$(nproc)" 
if [ $? -ne 0 ]; then
    exit 1
fi
sudo make install 

echo " "
echo " "
echo "------------------ PCL ------------------ "
cd ~/Downloads
if [ ! -f pcl-master.zip  ]; then 
    echo "PCL: download..." 
    wget --no-check-certificate --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" -nv -c -O pcl-master.zip https://codeload.github.com/PointCloudLibrary/pcl/zip/mast 
    unzip pcl-master.zip 
fi
echo "PCL: compile & install..." 
mkdir -p ~/Downloads/pcl-master/build && cd ~/Downloads/pcl-master/build 
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCS=NO .. 
if [ $? -ne 0 ]; then
    exit 1
fi
make -j"$(nproc)" 
sudo make install 

