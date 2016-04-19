git clone https://github.com/nahanni/rw_redis_fdw.git
cd rw_redis_fdw

PATH=/usr/lib/postgresql/9.5/bin:$PATH make
sudo PATH=/usr/lib/postgresql/9.5/bin:$PATH make install
