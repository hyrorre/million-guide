#!/bin/bash
cd `dirname $0`
DIR=$(cd $(dirname $0); pwd)

if [ -e html ]; then
	echo "Directory 'html' is already exist."
else
	rails s &
	sleep 20
	ruby output.rb
	kill -9 $!
	mkdir html/assets
	ln -s $DIR/app/assets/images/jackets $DIR/app/assets/images/musictypes html/assets/
	ln -s $DIR/app/assets/javascripts/application.js $DIR/app/assets/stylesheets/application.css html/assets/
	ln -s $DIR/public/robots.txt $DIR/public/sitemap.xml.gz html/
	rsync -rptgocvL html/ lolipop:~/web/million/
	rm -r html
fi

exit 0
