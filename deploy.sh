#!/bin/bash

mkdocs build
scp -r site pmurley@webserver.sprai.org:jscdocs.sprai.org
ssh -t pmurley@webserver.sprai.org "sudo cp -r jscdocs.sprai.org /var/www/"
