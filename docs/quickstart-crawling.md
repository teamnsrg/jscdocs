# Getting Started with Crawling

## Locally Driven Crawls

Although the crawler is intended to be used as a client of a distributed task
queue, it is possible to drive the crawler locally and complete crawling tasks
without relying on a task queue. Below are the steps to get started with
locally-driven crawling.


#### 1a. (optional) Get the instrumented version of Chromium

You can skip this step if getting the JavaScript traces is not important to you,
as the crawler will work with any recent version of Chrome or Chromium.

A copy of the instrumented version of Chromium is available on the NSRG NFS
drive at `/data3/instrumented_chrome`. You'll need the whole folder
(approximately 3GB).

#### 1b. Install dependencies for instrumented Chrome

This step is easy. Inside the `instrumented_chrome` directory, you will find a
script called `install-deps.sh`. Run it as root.

#### 2. Get the crawler repository

The crawler repository is located at https://github.com/teamnsrg/devtoolCrawl.
Clone the repository onto a machine running OS X or Linux (tested on Ubuntu
16.04). If you don't have access to the repo, [let me
know](mailto:pmurley2@illinois.edu). 


#### 3. Install crawler dependencies

The crawler is written in Python3, so we recommend you [use a virtual environment](https://docs.python.org/3/library/venv.html)
to install all the dependencies and run the crawler. The `requirements.txt` file
in the repository contains all dependencies needed for the crawler, so once you
are inside your virtual environment, just type:
```
pip3 install -r requirements.txt
```

#### 4. Use `localdriver.py` to crawl some things!

`localdriver.py` acts as a wrapper around the main crawling code in `crawler.py`
and allows you to provide parameters for crawls locally and store the results
locally or on a remote server. You can crawl a single site (`-s`) or read a file
containing a list of many sites to crawl (`-f`). Below is the complete help for
`localdriver.py`.

```
usage: localdriver.py [-h] [-s SITE] [-f SITEFILE] [-b BINARY] [-w WORKERS]
                      [-t TIMEOUT] [-g] [-p PREFIX] [-o OUTPUT_MODE]
                      [-d OUTPUT_PATH]

Local driver for the js_crawler

optional arguments:
  -h, --help            show this help message and exit
  -s SITE, --site SITE  Single site to crawl (Overrides [-f sitefile])
  -f SITEFILE, --sitefile SITEFILE
                        File with list of sites to crawl (one per line)
  -b BINARY, --binary BINARY
                        Path to custom Chrome or Chromium binary to use for
                        crawling
  -w WORKERS, --workers WORKERS
                        Number of worker threads to use for crawling
  -t TIMEOUT, --timeout TIMEOUT
                        Timeout in seconds for each site
  -g, --graphical       Crawl with full, graphical browser (requires window
                        manager)
  -p PREFIX, --prefix PREFIX
                        Protocol prefix to use for crawls. It should probably
                        be either "http://" or "https://".
  -o OUTPUT_MODE, --output-mode OUTPUT_MODE
                        Output mode. Can be 'local', 'remote' (SCP to remote
                        server), or 'none'.)
  -d OUTPUT_PATH, --output-path OUTPUT_PATH
                        Output path. Defaults to 'data/' for local output. For
                        remote output, this is the addressed used for SCP and
                        should be formatted accordingly (ex.
                        user@web.server.org:/data/storage/crawl_data)
```


## Scheduling Crawls Via the Celery and RabbitMQ

TODO
