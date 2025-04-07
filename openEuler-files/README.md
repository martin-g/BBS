Please also see https://github.com/bio-arm/dockerfiles

`kunpeng2` is a VM with openEuler 24.03 SP1 ARM64. It is used as builder node for Bioconductor project to test packages' builds and checks on Linux ARM64

## Update Bioconductor version

### R language installation

Even minor versions of Bioconductor like 3.16 and 3.18 use a stable version of R language, like 4.1 and 4.3.
Odd minor versions of Bioconductor like 3.17 and 3.21 use a devel version of R language, like 4.2 and 4.4.

For stable versions of R go to https://cran.r-project.org/src/base/R-4/ and download the latest version.
For devel versions go to https://stat.ethz.ch/R/daily/ and download the newest one.

Follow the steps below to install it:
```bash
mkdir ${HOME}/R && cd ${HOME}/R
export R_VERSION=4.3.2
wget https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz
# or
# export R_VERSION=devel
# wget https://stat.ethz.ch/R/daily/R-${R_VERSION}.tar.gz
tar zxvf R-${R_VERSION}.tar.gz
cd R-${R_VERSION}
./configure --enable-memory-profiling --enable-R-shlib --with-blas --with-lapack  --with-tcl-config=/usr/lib64/tclConfig.sh --with-tk-config=/usr/lib64/tkConfig.sh
make -j
mkdir site-library
cd etc/
${HOME}/BBS/utils/R-fix-flags.sh

```

#### After compilation

Follow the steps at:

* https://github.com/bioconductor/BBS/blob/devel/Doc/Prepare-Ubuntu-22.04-HOWTO.md#after-compilation
* https://github.com/bioconductor/BBS/blob/devel/Doc/Prepare-Ubuntu-22.04-HOWTO.md#basic-testing
* https://github.com/bioconductor/BBS/blob/devel/Doc/Prepare-Ubuntu-22.04-HOWTO.md#install-biocmanager--bioccheck
* https://github.com/bioconductor/BBS/blob/devel/Doc/Prepare-Ubuntu-22.04-HOWTO.md#optional-more-testing
* https://github.com/bioconductor/BBS/blob/devel/Doc/Prepare-Ubuntu-22.04-HOWTO.md#optional-flush-the-data-caches

### Update Bioconductor configs

Copy https://github.com/Bioconductor/BBS/tree/devel/3.21/bioc/kunpeng2 to the new `3.xy` folder, e.g. `https://github.com/Bioconductor/BBS/tree/devel/3.20/bioc/kunpeng2` 
and adapt the contents of `config.sh`. The entries which need update are:

1) export BBS_WORK_TOPDIR="/home/biocbuild/bbs-3.21-bioc"         # update 3.21 to the actual version
2) export BBS_R_HOME="/home/biocbuild/R/R-4.4-devel-2023.11.02"   # update the path to the latest R installation
3) export BBS_CENTRAL_ROOT_URL="http://155.52.207.165"            # ask the Bioc core team for the IP address to use

### Update Rsync/HTTPD configs

`kunpeng2` provides two ways to download the build reports:

1) Rsync 

`/etc/rsyncd.conf` contains a `bioc` module:

```
[bioc]
path = /home/biocbuild/bbs-3.21-bioc/products-out/
comment = Bioconductor report output
read only = yes
alist = yes

```

2) HTTPD

`/etc/httpd/conf/httpd.conf` contains this virtual host:

```

<VirtualHost *:80>
        ServerName ...
        DocumentRoot /home/biocbuild/bbs-3.21-bioc
        #CustomLog /tmp/httpd-access.log combined
        #ErrorLog /tmp/httpd-error.log
    <Directory /home/biocbuild/bbs-3.21-bioc/products-out>
            Options +Indexes +FollowSymLinks
            AllowOverride None
            Require all granted
    </Directory>


    Alias /BBS /home/biocbuild/public_html/BBS
    <Location "/BBS/">
        Options +Indexes +FollowSymLinks
        AllowOverride None
        Require all granted
    </Location>
</VirtualHost>
```

Make sure to replace `3.21` in the configs with the respective actual version of Bioconductor!

### Update crontab

`biocbuild` OS user has these two entries:

```
crontab -l
SHELL=/bin/bash

# By default, PATH is set to /usr/bin:/bin only. We need /usr/local/bin
# for things that we install locally (e.g. new versions of pandoc).
# It must be placed **before** /usr/bin.
PATH=/home/biocbuild/bin:/usr/local/bin:/usr/bin:/bin

# BIOC 3.18 SOFTWARE BUILDS at 15h EST (19h GMT)
# -------------------------

# run:
00 19 * * 0-5 /bin/bash --login -c 'cd /home/biocbuild/BBS/3.21/bioc/`hostname` && ./run.sh >>/home/biocbuild/bbs-3.21-bioc/log/`hostname`-`date +\%Y\%m\%d`-run.log 2>&1'

# update to latest `devel`
00 14 * * 0-5 /bin/bash --login -c 'cd /home/biocbuild/BBS/ && git stash && git pull --rebase && git stash pop >>/home/biocbuild/bbs-3.21-bioc/log/`hostname`-`date +\%Y\%m\%d`-git.log 2>&1'
```

When updating Bioconductor version change occurrences of `3.21` to the actual Bioc version!

### Install Dotnet 

Go to https://dotnet.microsoft.com/en-us/download/dotnet/9.0 and install the arm64 build

### Install Xvfb

/etc/systemd/system/Xvfb.service
```
[Unit]
Description=X Virtual Frame Buffer Service
After=network.target

[Service]
ExecStart=/usr/bin/Xvfb :99 -screen 0 1024x768x24
Environment="DISPLAY=:99"

[Install]
WantedBy=multi-user.target
```

```
dnf install xorg-x11-server-Xvfb
systemctl enable Xvfb.service
systemctl start Xvfb.service
```

### Update the global env vars

```
vim /etc/profile.d/bioconductor.sh
```

```
# From https://github.com/Bioconductor/BBS/blob/af1f643c3ed4ab6fb5f7d450b801f43812a35b88/Doc/Prepare-Ubuntu-22.04-HOWTO.md#set-reticulate_python-in-etcprofile
#export RETICULATE_PYTHON="/usr/bin/python3"

export BIOC="/home/biocbuild/bioconductor"
export LIBSBML_CFLAGS=$(pkg-config --cflags $BIOC/libsbml-from-git/lib/pkgconfig/libsbml.pc)
export LIBSBML_LIBS=$(pkg-config --libs $BIOC/libsbml-from-git/lib/pkgconfig/libsbml.pc)
export UDUNITS2_INCLUDE="$BIOC/libudunits-2/include"
export UDUNITS2_LIBS="$BIOC/libudunits-2/lib"
export OPEN_BABEL_HOME="$BIOC/openbabel-3.1.1"
export OPEN_BABEL_INCDIR=$OPEN_BABEL_HOME/include/openbabel3
export OPEN_BABEL_LIBDIR=$OPEN_BABEL_HOME/lib
export OPEN_BABEL_DATADIR=$OPEN_BABEL_HOME/share/openbabel/3.1.0
export OPENBABEL_CFLAGS="-I$OPEN_BABEL_INCDIR -L$OPEN_BABEL_LIBDIR"
export BABEL_LIBDIR="/usr/lib64/openbabel3/"
export LIBICONV_HOME="$BIOC/libiconv-1.17"
export LD_LIBRARY_PATH=/opt/ohpc/pub/compiler/gcc/14.2.0/lib64:$BIOC/icu-75.1-hf9b3779_0/lib:$BIOC/proj-6.2.1-h465d533_0/lib:$BIOC/lerc-3.0-h22f4aa5_0/lib:$BIOC/kealib-1.5.0-h1b42569_1/lib:$BIOC/tiledb-2.3.3-h3849020_3/lib:$BIOC/libkml-1.3.0-hadc4260_7/lib:$BIOC/hdf4-4.2.13-h96bad59_4/lib:$BIOC/jpeg-9e-h998d150_3/lib:/usr/local/lib64:$UDUNITS2_LIBS:$BIOC/libsbml-from-git/lib:$OPEN_BABEL_HOME/lib:$LIBICONV_HOME/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$BIOC/gdal/.pixi/envs/default/lib"
export PATH=$PATH:/usr/lib64/openmpi/bin:$BIOC/libudunits-2/bin:/home/biocbuild/.dotnet:$OPEN_BABEL_HOME/bin
export LC_TIME="en_GB"
export TMPDIR="/home/biocbuild/tmp"
export PATH="/usr/local/ensembl-vep:$PATH"
export ISR_login=bioc@immunespace.org
export ISR_pwd=1notCRAN
export GENEPREDTOGTF_BINARY="/home/biocbuild/bin/genePredToGtf"

export PATH=$PATH:/opt/meme/bin
export PATH=$PATH:/home/biocbuild/dotnet
export PATH=$PATH:/opt/meme/libexec/meme-5.5.5
export PATH="$PATH:$BIOC/gdal/.pixi/envs/default/bin"
export MEME_BIN=/opt/meme/bin
export CPATH="$CPATH:$BIOC/gdal/.pixi/envs/default/include"
export PROJ_LIB="$BIOC/gdal/.pixi/envs/default/share/proj"
export DISPLAY=:99
```
