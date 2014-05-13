#! /bin/sh
rm /tmp/logfile.json
while [ true ]
do 
	echo "Create logentries...";
	echo '{"category":"INFO", "url":"http://server.local:8080/api", "duration":200, "timestamp":1354697760477, "http_code":"200", "message":"This is only an information."}' >> /tmp/logfile.json;
    echo '{"category":"ERROR", "url":"http://server.local:8080/api", "duration":400, "timestamp":1354697760477, "http_code":"200", "message":"Oh, this is a fatal error."}' >> /tmp/logfile.json;
    sleep 2;
done

