git clone https://github.com/EnterpriseDB/mysql_fdw.git
cd mysql_fdw

# NOTE: need to use gmake to build this, FreeBSD default is pmake
# http://www.freshports.org/devel/gmake/

# NOTE: RTLD_DEEPBIND not available on FreeBSD, so define __APPLE__ to only RTLD_LAZY

PATH=/usr/local/lib/postgresql/bin:$PATH gmake USE_PGXS=1 CFLAGS=-D__APPLE__
sudo PATH=/usr/local/lib/postgresql/bin:$PATH gmake USE_PGXS=1  CFLAGS=-D__APPLE__ install
