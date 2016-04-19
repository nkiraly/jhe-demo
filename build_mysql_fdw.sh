git clone https://github.com/EnterpriseDB/mysql_fdw.git
cd mysql_fdw

PATH=/usr/lib/postgresql/9.5/bin:$PATH make USE_PGXS=1
sudo PATH=/usr/lib/postgresql/9.5/bin:$PATH make USE_PGXS=1 install
