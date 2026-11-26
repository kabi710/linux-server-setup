#!/bin/bash

STATUS_LOG="$HOME/logs/status.log"
NGINX_ACCESS="/var/log/nginx/access.log"
REPORT="$HOME/logs/report_$(date +%Y%m%d_%H%M%S).txt"

{
    echo "===== Server Status Report ====="
    echo "Generated: $(date)"
    echo ""

    echo "--- status.log summary ---"
    if [ -f "$STATUS_LOG" ]; then
        TOTAL_CHECKS=$(wc -l < "$STATUS_LOG")
        INACTIVE_COUNT=$(grep -c "hello-service: inactive\|hello-service: failed" "$STATUS_LOG")
        echo "Total status checks recorded: $TOTAL_CHECKS"
        echo "Times hello-service was NOT active: $INACTIVE_COUNT"
        echo "Most recent check:"
        tail -n 1 "$STATUS_LOG"
    else
        echo "status.log not found"
    fi
    echo ""

    echo "--- Nginx access log summary ---"
    if sudo test -r "$NGINX_ACCESS"; then
    	TOTAL_REQUESTS=$(sudo wc -l < "$NGINX_ACCESS")
        echo "Total requests logged: $TOTAL_REQUESTS"
        echo ""
        echo "Requests by HTTP status code:"
        sudo awk '{print $9}' "$NGINX_ACCESS" | sort | uniq -c | sort -rn
        echo ""
        echo "Top 5 requesting IP addresses:"
        sudo awk '{print $1}' "$NGINX_ACCESS" | sort | uniq -c | sort -rn | head -5
    else
        echo "Nginx access log not found"
    fi

} | tee "$REPORT"

echo ""
echo "Report saved to: $REPORT"


