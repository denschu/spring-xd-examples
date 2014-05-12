Spring XD - Tackling Big Data Complexity  - Examples
====================

# Installation on Mac OS

	brew install springxd
	brew install hadoop

# Start

	xd-singlenode

# Tail to HDFS

## Create Logfile

	touch /tmp/logfile.json

## Open XD Shell

	xd-shell

## Create simple Stream

	stream create --definition "tail --name=/tmp/logfile.json | log" --name beispiel 

## Delete simple Stream

	stream destroy beispiel

## Create extended Stream

	stream create --definition "tail --name=/tmp/logfile.json | filter --expression=#jsonPath(payload,'$.category').contains('ERROR') | log" --name beispiel

## Deploy stream

	stream deploy beispiel

## Add data to logfile

	echo '{"category":"INFO", "url":"http://server.local:8080/api", "duration":200, "timestamp":1354697760477, "http_code":"200", "message":"This is a logentry."}' >> /tmp/logfile.json

	echo '{"category":"ERROR", "url":"http://server.local:8080/api", "duration":400, "timestamp":1354697760477, "http_code":"200", "message":"This is a logentry."}' >> /tmp/logfile.json

## Create Tap

	stream create --name beispieltap --definition "tap:stream:beispiel > log" --deploy

	stream create --name beispielcount --definition "tap:stream:beispiel > counter --name=requestcount" --deploy

	stream create --name beispielaverage --definition "tap:stream:beispiel > transform --expression=#jsonPath(payload,'$.duration') | rich-gauge --name=averageduration" --deploy

## Get Metrics over HTTP

	http get --target http://localhost:9393/metrics/counters/requestcount
    http get --target http://localhost:9393/metrics/rich-gauges/averageduration
