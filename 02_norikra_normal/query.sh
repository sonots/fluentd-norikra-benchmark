norikra-client target open access time:integer
norikra-client query remove access_count
norikra-client query add -g access_count access_count "SELECT status, count(*) AS access_count FROM access.win:ext_timed_batch(time * 1000, 5 sec) GROUP BY status"

norikra-client target open api_restful time:integer
norikra-client query remove status_count.all.api_restful
norikra-client query remove status_count.host.api_restful
norikra-client query remove status_count.endpoint.api_restful

# 全体。AS `2xx_count` とはできないので AS count_2xx にしている
norikra-client query add status_count.all.api_restful "$(cat <<EOF
SELECT \
COUNT(1, status REGEXP '^2\d\d$') AS count_2xx, \
COUNT(1, status REGEXP '^3\d\d$') AS count_3xx, \
COUNT(1, status REGEXP '^400$') AS count_400, \
COUNT(1, status REGEXP '^4(?!00)\d\d$') AS count_4xx, \
COUNT(1, status REGEXP '^503$') AS count_503, \
COUNT(1, status REGEXP '^5(?!03)\d\d$') AS count_5xx \
FROM api_restful.win:time_batch(5 sec)
EOF
)"
# ホスト毎
norikra-client query add status_count.host.api_restful "$(cat <<EOF
SELECT \
host, \
COUNT(1, status REGEXP '^2\d\d$') AS count_2xx, \
COUNT(1, status REGEXP '^3\d\d$') AS count_3xx, \
COUNT(1, status REGEXP '^400$') AS count_400, \
COUNT(1, status REGEXP '^4(?!00)\d\d$') AS count_4xx, \
COUNT(1, status REGEXP '^503$') AS count_503, \
COUNT(1, status REGEXP '^5(?!03)\d\d$') AS count_5xx \
FROM api_restful.win:time_batch(5 sec) \
GROUP BY host
EOF
)"

