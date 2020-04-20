@rem ===================
@rem Settings for tokay1
@rem ===================


set BBS_DEBUG=0

set BBS_NODE_HOSTNAME=tokay1
set BBS_USER=biocbuild
set BBS_RSAKEY=C:\Users\biocbuild\.BBS\id_rsa
set BBS_WORK_TOPDIR=C:\Users\biocbuild\bbs-3.12-bioc-longtests
set BBS_R_HOME=C:\Users\biocbuild\bbs-3.12-bioc\R
set BBS_NB_CPU=4

set BBS_STAGE4_MODE=multiarch



@rem Shared settings (by all Windows nodes)

set wd0=%cd%
cd ..
call config.bat
cd %wd0%
