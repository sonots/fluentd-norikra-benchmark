norikra-client target open api_restful time:integer
norikra-client query remove status_count.all.api_restful
norikra-client query remove status_count.host.api_restful
norikra-client query remove status_count.endpoint.api_restful

norikra-client target open api_jsonrpc time:integer
norikra-client query remove status_count.all.api_jsonrpc
norikra-client query remove status_count.host.api_jsonrpc
norikra-client query remove status_count.endpoint.api_jsonrpc

# api_restful 全体
norikra-client query add -g status_count.all status_count.all.api_restful "$(cat <<EOF
SELECT \
COUNT(1, status REGEXP '^2..$') AS count_2xx, \
COUNT(1, status REGEXP '^3..$') AS count_3xx, \
COUNT(1, status REGEXP '^400$') AS count_400, \
COUNT(1, status REGEXP '^4(?!00)..$') AS count_4xx, \
COUNT(1, status REGEXP '^503$') AS count_503, \
COUNT(1, status REGEXP '^5(?!03)..$') AS count_5xx \
FROM api_restful.win:time_batch(5 sec)
EOF
)"
# api_restful ホスト毎
norikra-client query add -g status_count.host status_count.host.api_restful "$(cat <<EOF
SELECT \
host, \
COUNT(1, status REGEXP '^2..$') AS count_2xx, \
COUNT(1, status REGEXP '^3..$') AS count_3xx, \
COUNT(1, status REGEXP '^400$') AS count_400, \
COUNT(1, status REGEXP '^4(?!00)..$') AS count_4xx, \
COUNT(1, status REGEXP '^503$') AS count_503, \
COUNT(1, status REGEXP '^5(?!03)..$') AS count_5xx \
FROM api_restful.win:time_batch(5 sec) \
GROUP BY host
EOF
)"

# api_jsonrpc 全体: AS count_-32603 はエラーとなるため、AS count_32603 としている
norikra-client query add -g status_count.all status_count.all.api_jsonrpc "$(cat <<EOF
SELECT \
COUNT(1, status REGEXP '^-32603$') AS count_32603, \
COUNT(1, status REGEXP '^-3(?!2603)....$') AS count_3xxxx \
FROM api_jsonrpc.win:time_batch(5 sec)
EOF
)"
# api_jsonrpc ホスト毎
norikra-client query add -g status_count.host status_count.host.api_jsonrpc "$(cat <<EOF
SELECT \
host, \
COUNT(1, status REGEXP '^-32603$') AS count_32603, \
COUNT(1, status REGEXP '^-3(?!2603)....$') AS count_3xxxx \
FROM api_jsonrpc.win:time_batch(5 sec) \
GROUP BY host
EOF
)"
