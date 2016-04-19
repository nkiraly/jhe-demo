git clone https://github.com/nahanni/rw_redis_fdw.git
cd rw_redis_fdw

# NOTE: need to use gmake to build this, FreeBSD default is pmake
# http://www.freshports.org/devel/gmake/

PATH=/usr/local/lib/postgresql/bin:$PATH gmake
sudo PATH=/usr/local/lib/postgresql/bin:$PATH gmake install
