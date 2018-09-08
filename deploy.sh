#!/bin/bash
cd `dirname $0`
DIR=$(cd $(dirname $0); pwd)

if [ -e html ]; then
	echo "Directory 'html' is already exist."
else
	rails db:seed
	rails sitemap:create
	rails s -d
	ruby output.rb
	kill -9 `cat tmp/pids/server.pid`
	ln -s $DIR/app/assets/images/jackets $DIR/app/assets/images/musictypes html/assets/
	rsync -acvL html/ lolipop:~/web/million/
	rm -r html
	rails sitemap:refresh
fi

exit 0
