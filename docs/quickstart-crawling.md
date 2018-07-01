# Getting Started with Crawling

There are two ways to use the JSC crawler. The first is to use our distributed
crawling infrastructure, consisting many nodes pulling crawl tasks from a task
queue and storing results in a centralized location. The second is to simply
run the crawler from your own local machine. The steps to crawl sites using
both methods are described below.

---

## Using the Distributed Infrastructure

Our crawling system consists of many distributed crawling nodes which all
connect to a single, central task queue to receive and execute crawling tasks.
To conduct a crawl using our system, you must create a task file. This task
file is a JSON file describing the parameters for one or many crawls you wish
to execute. For further explanation on the format of this file and instructions
on building a task file, look [here](/crawl-tasks.md). Note that the assignment of
a unique `group_id` in your task file is important, so you can later get the results
just for that specific group id.

Once you have this task file, the next step is to add the tasks into the
distributed task queue.  To do this, use a python script in the `devtoolCrawl`
repository called `scheduler.py`. It will parse your task file, check it for
errors, decompose it into all of the individual crawl tasks, and add them to
our crawl task queue for execution.

To monitor the progress of your crawl, you can use the Grafana interface at
`dragonstone.sprai.org:6500`. Here, you can observe the total tasks remaining
in the crawl queue and the rate at which tasks are currently being completed.

Once your crawl is complete, you will want to retrieve and analyze your data. See
[using data](/using-data.md) for a guide to that.

---

## Locally Driven Crawls

Although the crawler is intended to be used as a client of a distributed task
queue, it is possible to drive the crawler locally and complete crawling tasks
without relying on a task queue. Below are the steps to get started with
locally-driven crawling.

### 1a. (optional) Get the instrumented version of Chromium

You can skip this step if getting the JavaScript traces is not important to you,
as the crawler will work with any recent version of Chrome or Chromium.

A copy of the instrumented version of Chromium is available on the NSRG NFS
drive at `/data3/instrumented_chrome`. You'll need the whole folder
(approximately 3GB).

*Note: Currently, the only version of instrumented Chromium is for 64-bit Linux.
If you have a need to run the instrumented version on OS X, please let us know.*

### 1b. (optional) Install dependencies for instrumented Chrome

This step is easy. Inside the `instrumented_chrome` directory you just copied,
you will find a script called `install-deps.sh`. Run it as root.

### 2. Get the crawler repository

The crawler repository is located at https://github.com/teamnsrg/devtoolCrawl.
Clone the repository onto a machine running OS X or Linux (tested on Ubuntu
16.04). If you don't have access to the repo, [let me
know](mailto:pmurley2@illinois.edu). 


### 3. Install crawler dependencies

The crawler is written in Python3, so we recommend you [use a virtual environment](https://docs.python.org/3/library/venv.html)
to install all the dependencies and run the crawler. The `requirements.txt` file
in the repository contains all dependencies needed for the crawler, so once you
are inside your virtual environment, just type:
```
pip3 install -r requirements.txt
```

### 4. Use `localdriver.py` to crawl some things!

`localdriver.py` acts as a wrapper around the main crawling code in `crawler.py`
and allows you to provide parameters for crawls locally and store the results
locally or on a remote server. You can crawl a single site (`-s`) or read a file
containing a list of many sites to crawl (`-f`). Below is the complete help for
`localdriver.py`.

For a local crawl, use should use `-o local` to store results locally. You can set
the output path for results with `-d /Users/myuser/crawl_output`.


```
usage: localdriver.py [-h] [-s SITE] [-f SITEFILE] [-b BINARY] [-w WORKERS]
                      [-t TIMEOUT] [-g] [-i] [-p PREFIX] [-o OUTPUT_MODE]
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
  -i, --interactive     Crawl with interactive mode, simulating user inputs
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

Note that the instrumented binary is located at `instrumented_chrome/chrome`.
The path to it must be passed to `localdriver.py` using the `-b` option, or the
default chromium/chrome installed on the system will be used.


### 5. Retrieve your data

By default, crawl data is stored locally in a directory called `data`. Each
individual crawl gets its own folder, as you can find further information on the
data format [here](/using-data.md).









For instructions on accessing and analyzing the results of your crawl,
see [Using Data](/using-data.md).

