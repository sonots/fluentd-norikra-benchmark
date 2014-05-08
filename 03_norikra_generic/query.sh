norikra-client target open visualizer time:integer
norikra-client query remove status_count.all
norikra-client query remove status_count.host

# 全体
norikra-client query add status_count.all "$(cat <<EOF
SELECT \
label, \
COUNT(1, status REGEXP '^2..$') AS count_2xx, \
COUNT(1, status REGEXP '^3..$') AS count_3xx, \
COUNT(1, status REGEXP '^400$') AS count_400, \
COUNT(1, status REGEXP '^4(?!00)..$') AS count_4xx, \
COUNT(1, status REGEXP '^503$') AS count_503, \
COUNT(1, status REGEXP '^5(?!03)..$') AS count_5xx \
FROM visualizer.win:time_batch(5 sec) \
GROUP BY label
EOF
)"
# ホスト毎
norikra-client query add status_count.host "$(cat <<EOF
SELECT \
label, host, \
COUNT(1, status REGEXP '^2..$') AS count_2xx, \
COUNT(1, status REGEXP '^3..$') AS count_3xx, \
COUNT(1, status REGEXP '^400$') AS count_400, \
COUNT(1, status REGEXP '^4(?!00)..$') AS count_4xx, \
COUNT(1, status REGEXP '^503$') AS count_503, \
COUNT(1, status REGEXP '^5(?!03)..$') AS count_5xx \
FROM visualizer.win:time_batch(5 sec) \
GROUP BY label, host
EOF
)"
