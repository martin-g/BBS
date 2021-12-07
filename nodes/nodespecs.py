### allnodes['nebbiolo1'] is a dict with 5 keys: 'OS', 'Arch', 'Platform',
### 'pkgType', and 'encoding'. The value in each key-value pair must be
### a string.
### 'pkgType' is the native package type for the node (must be one of "source",
### "win.binary", "win64.binary", "mac.binary", "mac.binary.leopard",
### or "mac.binary.mavericks").
### 'encoding' must be an encoding accepted by Python function
### codecs.getdecoder() (test it from python with e.g.
### codecs.getdecoder('utf_8') or codecs.getdecoder('iso8859'))

# FIXME - parameterize this as much as possible
# OS version, etc.. can be obtained programmatically

allnodes = {
    'nebbiolo1':  {'OS'      : "Linux (Ubuntu 20.04.3 LTS)",
                   'Arch'    : "x86_64",
                   'Platform': "x86_64-linux-gnu",
                   'pkgType' : "source",
                   'encoding': "utf_8"},
    'nebbiolo2':  {'OS'      : "Linux (Ubuntu 20.04.3 LTS)",
                   'Arch'    : "x86_64",
                   'Platform': "x86_64-linux-gnu",
                   'pkgType' : "source",
                   'encoding': "utf_8"},
    'malbec1':    {'OS'      : "Linux (Ubuntu 18.04.5 LTS)",
                   'Arch'    : "x86_64",
                   'Platform': "x86_64-linux-gnu",
                   'pkgType' : "source",
                   'encoding': "utf_8"},
    'malbec2':    {'OS'      : "Linux (Ubuntu 20.04.3 LTS)",
                   'Arch'    : "x86_64",
                   'Platform': "x86_64-linux-gnu",
                   'pkgType' : "source",
                   'encoding': "utf_8"},
    'riesling1':  {'OS'      : "Windows Server 2019 Standard",
                   'Arch'    : "x64",
                   'Platform': "mingw32 / x86_64-w64-mingw32",
                   'pkgType' : "win.binary",
                   'encoding': "iso8859"},
    'debina':     {'OS'      : "Windows Server 2019 Datacenter",
                   'Arch'    : "x64",
                   'Platform': "mingw32 / x86_64-w64-mingw32",
                   'pkgType' : "win.binary",
                   'encoding': "iso8859"},
    'palomino':   {'OS'      : "Windows Server 2022 Datacenter",
                   'Arch'    : "x64",
                   'Platform': "x86_64-w64-mingw32",
                   'pkgType' : "win.binary",
                   'encoding': "iso8859"},
    'tokay1':     {'OS'      : "Windows Server 2012 R2 Standard",
                   'Arch'    : "x64",
                   'Platform': "mingw32 / x86_64-w64-mingw32",
                   'pkgType' : "win.binary",
                   'encoding': "iso8859"},
    'tokay2':     {'OS'      : "Windows Server 2012 R2 Standard",
                   'Arch'    : "x64",
                   'Platform': "mingw32 / x86_64-w64-mingw32",
                   'pkgType' : "win.binary",
                   'encoding': "iso8859"},
    'merida1':    {'OS'      : "macOS 10.14.6 Mojave",
                   'Arch'    : "x86_64",
                   'Platform': "x86_64-apple-darwin18.7.0",
                   'pkgType' : "mac.binary",
                   'encoding': "utf-8"},
    'machv2':     {'OS'      : "macOS 10.14.6 Mojave",
                   'Arch'    : "x86_64",
                   'Platform': "x86_64-apple-darwin18.7.0",
                   'pkgType' : "mac.binary",
                   'encoding': "utf-8"},
    'taxco':      {'OS'      : "macOS 11.0.1 Big Sur",
                   'Arch'    : "arm64",
                   'Platform': "arm64-apple-darwin20.1.0",
                   'pkgType' : "big-sur-arm64",
                   'encoding': "utf-8"}
}
