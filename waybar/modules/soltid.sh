DATE=$(date +"%Y-%m-%d")
HOUR=$(date +"%H")

curl 'https://www.stralsakerhetsmyndigheten.se/api/v1/suntime/calculate' \
	-H 'user-agent: Mozilla/5.0 (X11; Linux x86_64)' \
	-H 'content-type: application/json' \
	--data-raw "{'skintypeId':'2','latitude':'57.70887','dateStr': '$DATE','hour':'$HOUR'}"
