#!/bin/sh
sleep 1
logger "autowhu: Checking the authentication status"
KEYWORD=`curl -s http://baidu.com | grep "172.19.1.9"`
if [[ ${KEYWORD} != "" ]]; then
	logger "autowhu: WARNING: Offline, authenticating"
	USERID=2000000000000
	PASSWORD=000000
	SERVICE=Internet
	QUERY_STRING=`curl -s baidu.com | grep -o "[\?].*[\']" | cut -d '?' -f2 | cut -d \' -f1 | sed 's/&/%2526/g' | sed 's/=/%253D/g'`
	LOGIN_STATUS=`curl -s 'http://172.19.1.9:8080/eportal/InterFace.do?method=login' -H 'Connection: keep-alive' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36 Edg/96.0.1054.53' -H 'DNT: 1' --data-raw "userId=${USERID}&password=${PASSWORD}&service=${SERVICE}&queryString=${QUERY_STRING}&operatorPwd=&operatorUserId=&validcode=&passwordEncrypt=false"`
	LOGIN_RESULT=`echo ${LOGIN_STATUS} | grep "success"`
	if [[ ${LOGIN_RESULT} != "" ]]; then
		logger "autowhu: Authentication is successful"
	else
		logger "autowhu: ERROR: Offline, authentication failed, please try again manually"
	fi
else
	logger "autowhu: Authenticated"
fi
