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

## Add data

	echo '{"category":"INFO", "url":"http://server.local:8080/api", "duration":200, "timestamp":1354697760477, "http_code":"200", "message":"This is a logentry."}' >> /tmp/logfile.json


## Create Stream

	xd:> stream create --definition "tail --name=/tmp/logfile.json | hdfs" --name beispiel
	xd:> stream create --definition "tail --name=/tmp/logfile.json | json-field-value-filter --fieldName=category --fieldValue=INFO | hdfs" --name beispiel
	

or for testing without Hadoop

	xd:> stream create --definition "tail --name=/tmp/logfile.json | json-field-value-filter --fieldName=category --fieldValue=INFO | log" --name beispiel

## Create Tap

	stream create --name beispieltap --definition "tap:stream:beispiel > log"
	stream create --name beispielcount --definition "tap:stream:beispiel > counter --name=requestcount"
	stream create --name beispielaverage --definition "tap:stream:beispiel > json-field-extractor --fieldName=duration | richgauge --name=averageduration"

## Get Metrics over HTTP

	http get --target http://localhost:9393/metrics/counters/requestcount
    http get --target http://localhost:9393/metrics/richgauges/averageduration
