#!/bin/bash
value=$(face_recognition original webcam | cut -d ',' -f 2)
echo $value
if [ "$value" == "eduardo" ];then
	gpio mode 7 out
	gpio write 7 1
	sleep 3
	gpio write 7 0
else
	gpio mode 7 out
	gpio write 7 1
	echo "not found"
fi

