#!/bin/bash
cd `dirname $0`
DIR=$(cd $(dirname $0); pwd)

rails db:seed
rails sitemap:create
rails s -d
ruby output.rb
kill -9 `cat tmp/pids/server.pid`
ls app/assets/images | xargs -I{} ln -s $DIR/app/assets/images/{} html/assets/
rsync -acvL html/ lolipop:~/web/million/
rm -r html
rails sitemap:refresh

exit 0
