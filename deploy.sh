#!/bin/bash

mkdocs build
git add *
git commit
git push -u origin master
scp -r site pmurley@webserver.sprai.org:jscdocs.sprai.org
ssh -t pmurley@webserver.sprai.org "sudo rm -rf /var/www/jscdocs.sprai.org && sudo cp -Tr jscdocs.sprai.org /var/www/jscdocs.sprai.org && rm -rf jscdocs.sprai.org"
