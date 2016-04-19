git clone https://github.com/nahanni/rw_redis_fdw.git
cd rw_redis_fdw

PATH=/usr/local/lib/postgresql/bin:$PATH gmake
sudo PATH=/usr/local/lib/postgresql/bin:$PATH gmake install
