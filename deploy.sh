#!/bin/bash



export PORT=5108
export MIX_ENV=prod
export GIT_PATH=/home/webuser1/SmsClient

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "webuser1" ]; then
	echo "Error: must run as user 'webuser1'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/smsClient ]; then
	echo mv ~/www/smsClient ~/old/$NOW
	mv ~/www/smsClient ~/old/$NOW
fi

mkdir -p ~/www/smsClient
REL_TAR=~/SmsClient/_build/prod/rel/smsClient/releases/0.0.1/smsClient.tar.gz
(cd ~/www/smsClient && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/webuser1/SmsClient/start.sh
CRONTAB

#. start.sh
