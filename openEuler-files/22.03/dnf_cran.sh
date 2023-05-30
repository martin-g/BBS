# APT packages needed for CRAN packages

# cmake                   # for nloptr
# libglu1-mesa-dev        # for rgl
# librsvg2-dev            # for rsvg
# libgmp-dev              # for gmp
# libssl-dev              # for openssl, mongolite
# libsasl2-dev            # for mongolite
# libxml2-dev             # for XML
# libcurl4-openssl-dev    # for RCurl, curl
# mpi-default-dev         # for Rmpi
# libudunits2-dev         # for units
# libv8-dev               # for V8
# libmpfr-dev             # for Rmpfr
# libfftw3-dev            # for fftw, fftwtools
# libmysqlclient-dev      # for RMySQL
# libpq-dev               # for RPostgreSQL, RPostgres
# libmagick++-dev         # for magick
# libgeos-dev             # for rgeos
# libproj-dev             # for proj4
# libgdal-dev             # for sf
# libpoppler-cpp-dev      # for pdftools
# libgit2-dev             # for gert
# jags                    # for rjags
# libprotobuf-dev         # for protolite
# protobuf-compiler       # for protolite
# libglpk-dev             # for glpkAPI and to compile igraph with GLPK support
# libhiredis-dev          # for redux
# libarchive-dev          # for archive, a dependency of AlpsNMR


dnf install -y cmake mesa-libGLU-devel librsvg2-devel gmp-devel openssl-devel libxml2-devel v8-devel mpfr-devel fftw-devel libpq-devel ImageMagick-devel geos-devel proj-devel proj-nad sqlite-devel libgit2-devel protobuf-devel protobuf-compiler glpk-devel hiredis-devel libarchive-devel poppler-cpp-devel ImageMagick-c++-devel mysql-devel texlive-pdfcrop openmpi-devel texlive-titling texlive-framed texlive-nowidow texlive-parnotes texlive-preprint texlive-marginfix texlive-xstring texlive-comment texlive-multirow texlive-a4wide texlive-threeparttable texlive-epstopdf texinfo-tex texlive-wrapfig texlive-isorot texlive-textpos texlive-sectsty texlive-subfigure texlive-esint texlive-vmargin texlive-picinpar
