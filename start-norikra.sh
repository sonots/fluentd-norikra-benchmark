rbenv local norikra
norikra start \
-Xmx4096m \
-Xms4096m \
-Xss2048k \
-XX:+UseConcMarkSweepGC \
-XX:+UseCompressedOops \
-XX:CMSInitiatingOccupancyFraction=70 \
-XX:+UseCMSInitiatingOccupancyOnly \
-XX:NewRatio=1 \
-XX:NewSize=2048m \
-XX:-UseGCOverheadLimit \
-XX:SurvivorRatio=2 \
-XX:MaxTenuringThreshold=15 \
-XX:TargetSurvivorRatio=80 \
-XX:SoftRefLRUPolicyMSPerMB=200 \
-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps \
-XX:+HeapDumpOnOutOfMemoryError \
--port=26571 \
--ui-port=8080 \
--stats=/var/log/norikra/stats.json \
--gc-log=/var/log/norikra/gc.log \
--inbound-threads=10 \
--outbound-threads=10 \
--route-threads=6 \
--timer-threads=6 \
--verbose \
--rpc-threads=33 \
--web-threads=33