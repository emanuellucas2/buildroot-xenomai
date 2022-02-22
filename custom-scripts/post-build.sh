#!/bin/bash
tar -xvf $BASE_DIR/../custom-scripts/packages/xenomai-3.1.tar.bz2 -C $BASE_DIR/build
pushd $BASE_DIR/build/xenomai-3.1
scripts/bootstrap
export CFLAGS="-march=armv7-a -mfloat-abi=hard -mfpu=neon -ffast-math"
export LDFLAGS="-march=armv7-a -mfloat-abi=hard -mfpu=neon -ffast-math"
export DESTDIR=$BASE_DIR/target
mkdir -p build
pushd build
../configure --enable-smp --host=arm-linux-gnueabihf --with-core=cobalt
make && make install
popd
popd

make -C $BASE_DIR/../custom-scripts/latency_app
cp $BASE_DIR/../custom-scripts/latency_app/latency $BASE_DIR/target/usr/xenomai/bin