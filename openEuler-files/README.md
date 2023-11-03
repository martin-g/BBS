`kunpeng2` is a VM with openEuler 22.03 SP1 ARM64. It is used as builder node for Bioconductor project to test packages' builds and checks on Linux ARM64

## Update Bioconductor version

### R language installation

Even minor versions of Bioconductor like 3.16 and 3.18 use a stable version of R language, like 4.1 and 4.3.
Odd minor versions of Bioconductor like 3.17 and 3.19 use a devel version of R language, like 4.2 and 4.4.

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

### Update Bioconductor configs

Copy https://github.com/Bioconductor/BBS/tree/devel/3.19/bioc/kunpeng2 to the new `3.xy` folder, e.g. `https://github.com/Bioconductor/BBS/tree/devel/3.20/bioc/kunpeng2` 
and adapt the contents of `config.sh`. The entries which need update are:

1) export BBS_WORK_TOPDIR="/home/biocbuild/bbs-3.19-bioc"         # update 3.19 to the actual version
2) export BBS_R_HOME="/home/biocbuild/R/R-4.4-devel-2023.11.02"   # update the path to the latest R installation
3) export BBS_CENTRAL_ROOT_URL="http://155.52.207.165"            # ask the Bioc core team for the IP address to use

### Update Rsync/HTTPD configs

`kunpeng2` provides two ways to download the build reports:

1) Rsync 

`/etc/rsyncd.conf` contains a `bioc` module:

```
[bioc]
path = /home/biocbuild/bbs-3.19-bioc/products-out/
comment = Bioconductor report output
read only = yes
alist = yes

```

2) HTTPD

`/etc/httpd/conf/httpd.conf` contains this virtual host:

```

<VirtualHost *:80>
        ServerName ...
        DocumentRoot /home/biocbuild/bbs-3.19-bioc
        #CustomLog /tmp/httpd-access.log combined
        #ErrorLog /tmp/httpd-error.log
    <Directory /home/biocbuild/bbs-3.19-bioc/products-out>
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

Make sure to replace `3.19` in the configs with the respective actual version of Bioconductor!

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
00 19 * * 0-5 /bin/bash --login -c 'cd /home/biocbuild/BBS/3.19/bioc/`hostname` && ./run.sh >>/home/biocbuild/bbs-3.19-bioc/log/`hostname`-`date +\%Y\%m\%d`-run.log 2>&1'

# update to latest `devel`
00 14 * * 0-5 /bin/bash --login -c 'cd /home/biocbuild/BBS/ && git stash && git pull --rebase && git stash pop >>/home/biocbuild/bbs-3.19-bioc/log/`hostname`-`date +\%Y\%m\%d`-git.log 2>&1'
```

When updating Bioconductor version change occurrences of `3.19` to the actual Bioc version!