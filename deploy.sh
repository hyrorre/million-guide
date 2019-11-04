#!/bin/bash
cd `dirname $0`

rails db:seed
rails sitemap:create
rails s -d
ruby output.rb
kill -9 `cat tmp/pids/server.pid`
rsync -a --delete html/ lolipop:~/web/million/
rm -r html
rails sitemap:refresh

exit 0
