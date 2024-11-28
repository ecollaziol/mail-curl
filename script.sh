#!/bin/bash

# File containing the list of values
FILE="list.txt"

# Sentence to search for in the response
SEARCH_SENTENCE="Your subscription request has been received"

# Read each line in the file
while IFS= read -r VALUE; do
    # Fetch the HTML response for each value
    response=$(curl "https://mailman.aps.anl.gov/mailman/subscribe/${VALUE}" \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: en-US,en;q=0.9,pt-BR;q=0.8,pt;q=0.7' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'cookie: __cf_bm=jlWNYUEG7fCryLs5oE23DVR9gh8izei7TC_14W_4ZQM-1732799433-1.0.1.1-o8m2WXcdlKcR8mWEHdTKy7u4_KaQ9CPU6sQGRK.sN8PxMWh_lbcqb7oGW61pw5L4.FqNsS.l4LhT42u0NGrswA' \
  -H 'dnt: 1' \
  -H 'origin: https://mailman.aps.anl.gov' \
  -H 'priority: u=0, i' \
  -H "referer: https://mailman.aps.anl.gov/mailman/listinfo/${VALUE}" \
  -H 'sec-ch-ua: "Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' \
  --data-raw 'email=eduardocollaziol%40outlook.com&fullname=&pw=&pw-conf=&digest=0&email-button=Subscribe' ;)

    # Check if the sentence is present in the response
    if echo "$response" | grep -qF "$SEARCH_SENTENCE"; then
        echo "For VALUE '${VALUE}': OK"
    else
        echo "For VALUE '${VALUE}': Error"
    fi
done < "$FILE"