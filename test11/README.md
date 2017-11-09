
# First run
1. putty into 10.39.104.40
  - run `../common/build.sh`, please input carefully.
  
2. on windows `\\10.39.104.40`
  - put db dump into data/, 
    * oracle impdp mode data/impdpdata, imp mode in data/impdata.
    * DB2  move mode db2move; restore mode db2retore
  - EE_PARA into /data/EE_PARA, you need modify the hostname.
  - EE_Y into /data/EE_Y, if AP server is weblogic and libertiry, system will auto copy.
  - EAR into data/, must name as `EximBill.ear` if you want auto deploy.
  - MQ: modify queue manager name in `docker-compose.yml`; modify channel name and queue name in `data/eemq_init.mqsc`.
    * PLEASE UPPERCASE your MQ Manager, channel, queue name.
  - modify README.md add user login info.

2. putty into 10.39.104.40
  - **Warning** run `ee_param.sh` to batch rename host ip, but it is dangerous.
  - run `dc up -d` to start container.
  - waiting some minutes.

3. if AP server is WAS, you need:
  - Deploy EAR via WAS admin console.
  - attach share library to EAR
  - change class loader to parent first.

3. daily 
  - putty into 10.39.104.40, `dc start/stop`
  - putty into 10.39.104.40, `restart_was.sh`


