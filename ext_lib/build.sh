#!/usr/bin/env bash
cd /root/ext_lib/
echo -e "build cmake --------------"
tar -zxvf cmake-3.8.2.tar.gz
cd cmake-3.8.2
./configure && make install
cd ..
echo -e "building hiredis ----------"
tar -zxvf hiredis-0.14.1.tar.gz
cd hiredis-0.14.1
make clean&& make install
cd ..
echo -e "build uuid ---------------"
tar -zxvf libuuid-1.0.3.tar.gz
cd libuuid-1.0.3
./configure && make install
cd ..
echo -e "build log4cpp ------------"
tar -zxvf log4cpp-1.2-zhbr.tar.gz
cd log4cpp-1.2-zhbr
./configure && make install
cd ..
echo -e "build mysql ---------------"
tar -zxvf mysql-connector-c-6.1.11-src.tar.gz
cd mysql-connector-c-6.1.11-src
cmake . && make install
cd ..
echo -e "build static boost ------------"
tar -zxvf boost_1_73_0.tar.gz
cd boost_1_73_0
./bootstrap.sh
./b2 install --prefix=/usr/local cxxflags='-fPIC' cflags='-fPIC' toolset=gcc link=static runtime-link=shared threading=multi --with-filesystem --with-iostreams --with-regex --with-serialization --with-system --with-date_time --with-locale address-model=64
echo -e "build gtest lib"
cd ..
tar -zxvf googletest-release-1.10.0.tar.gz
cd googletest-release-1.10.0
cmake . &&make install
echo -e "build fininshed!!!!"

rm -rf /root/ext_lib/*

