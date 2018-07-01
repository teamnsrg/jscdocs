# Crawl Tasks and Task Files

Crawling tasks are defined using JSON. Tasks consist of settings/parameters
to be used during the crawls. A single crawl task may contain an arbitrary
number of crawls, and a single task file may contain an arbitrary number of
tasks.

## Crawl Task Format

The following fields are included in a crawl tasks. Fields marked as required
*must* be included in each task, or an error will occur. Other fields may be
omitted, and will be set according to the defaults specified. *When multiple
values for a field are specified, a crawl will be conducted for _each combination_
of the values specified.*


#### *url* (required)
  - *Type*: Array of strings
  - *Description*: The URL or URLs to be crawled.


#### *group\_id* (required)
  - *Type*: String
  - *Description*: String to identify this crawl task/group. Since all results are currently stored in the same database,
  this tag will be necessary to analyze your results.

#### *prefix*
  - *Type*: Array of strings
  - *Description*: Prefixes/protocols used. Should probably include only _'http://'_ or _'https://'_.
  - *Default*: `[ 'http://' ]`


#### *interactive*
  - *Type*: Array of booleans
  - *Description*: Whether to crawl interactively (trigger event listeners, etc.)
  - *Default*: `[ False ]`


#### *headless*
  - *Type*: Array of booleans
  - *Description*: Whether the crawl will use a headless browser (as opposed to the full graphical version)
  - *Default*: `[ True ]`


#### *timeout*
  - *Type*: Array of integers
  - *Description*: How long (in seconds) the crawler will remain on the page, regardless of load events
  - *Default*: `[ 45 ]`


#### *binary*
  - *Type*: Array of strings
  - *Description*: Chrome/Chromium binary to use to complete the crawl(s). *Note that, for now, the default
  value should be used for this field.* In the future, we plan to provide multiple browsers as options.
  - *Default*: `[ '/home/js\_crawl/chrome\_build/chrome' ]`


#### *output\_mode*
  - *Type*: string
  - *Description*: Where the crawl results will be stored. Should be `local` or `remote`. If you are using the
  distributed infrastructure, this field should be set to `remote`, or your crawl data will be inaccessible.
  - *Default*: `remote`

#### *output\_path*
  - *Type*: string
  - *Description*: Destination for output storage, either locally or to a remote server.
  - *Default*: `dragonstone.sprai.org:/data3/js_traces`


## Example Task File

This task file contains two crawl tasks. The first task crawls three sites
using a full, graphical browser and a timeout of 60 seconds. The second crawls
_microsoft.com_ eight different times, using every possible combination of the
specified values of `prefix`, `headless`, and `interactive`.

```
{
    "tasks" : [
        {
            "url" : [ "google.com", "cnn.com", "github.com"],
            "group_id" : "test_crawl_01",
            "timeout" : [ 60 ],
            "headless" : [ false ]
        },
        {
            "url" : [ "microsoft.com" ],
            "group_id" : "crawl_which_analyzes_microsoft.com",
            "prefix" : [ "http://", "https://" ],
            "headless" : [ true, false ],
            "interactive" : [ true, false ]
        }
    ]
}
```
## Building Task Files

The repository includes a tool for building task files: `task_file_builder.py`. This tool
allows you to add tasks to an existing task file or create new task files. You can type
the URLs to crawl in manually or load them from a file:

```

usage: task_file_builder.py [-h] (-f SITEFILE | -s [SITES [SITES ...]]) [-x]
                            [-p [PREFIXES [PREFIXES ...]]]
                            [-t [TIMEOUT [TIMEOUT ...]]]
                            [-i [INTERACTIVE [INTERACTIVE ...]]]
                            [-g [GRAPHICAL [GRAPHICAL ...]]] [-o OUTFILE]
                            [-b [BINARY [BINARY ...]]] -n GROUP_ID
                            [-m OUTPUT_MODE] [-a OUTPUT_PATH]

Tool for building task files. Creates one task at a time. Appends tasks to
output file by default. Separate multiple values with spaces.

optional arguments:
  -h, --help            show this help message and exit
  -f SITEFILE, --sitefile SITEFILE
                        File containing sites to crawl. One per line, no
                        protocols (e.g., "https://")
  -s [SITES [SITES ...]], --sites [SITES [SITES ...]]
                        List of sites to crawl. No prefixes. Separate with
                        spaces.
  -x, --overwrite       Overwrites existing task file, if it exists (rather
                        than appending a new task)
  -p [PREFIXES [PREFIXES ...]], --prefixes [PREFIXES [PREFIXES ...]]
                        prefix(es) to use for task. Separate multiple values
                        with spaces.
  -t [TIMEOUT [TIMEOUT ...]], --timeout [TIMEOUT [TIMEOUT ...]]
                        timeout(s) to use for task. Separate multiple values
                        with spaces.
  -i [INTERACTIVE [INTERACTIVE ...]], --interactive [INTERACTIVE [INTERACTIVE ...]]
                        interactive setting(s) to use for task. true, Separate
                        multiple values with spaces.
  -g [GRAPHICAL [GRAPHICAL ...]], --graphical [GRAPHICAL [GRAPHICAL ...]]
                        Setting(s) for using full browser (rather than
                        headless). Separate multiple values with spaces.
  -o OUTFILE, --outfile OUTFILE
                        Output file to write the task to. Set the -x option to
                        overwrite, rather than append.
  -b [BINARY [BINARY ...]], --binary [BINARY [BINARY ...]]
                        Binary or binaries to use for this crawl
  -n GROUP_ID, --group-id GROUP_ID
                        Group ID to identify crawl results
  -m OUTPUT_MODE, --output-mode OUTPUT_MODE
                        Output mode for crawl results. Either "local" or
                        "remote"
  -a OUTPUT_PATH, --output-path OUTPUT_PATH
                        Output path for results.

```
