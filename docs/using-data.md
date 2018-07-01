# Using Crawl Data

Currently, crawl data is available in two formats: SQL and JSON.

## MySQL

The easiest way to analyze crawl data collected using the full, distributed
architecture is to use the MySQL server available at
`dragonstone.sprai.org:3306`. There are two databases here, one for development
(`dev_js_crawls`) and one for production (`js_crawls`). Within each database,
there are four tables: `metadata`, `resources`, `scripts`, and `listeners`. The
schema for these tables are shown below. 

### The `metadata` Table

```
+-------------------------------+------------------+------+-----+---------+----------------+
| Field                         | Type             | Null | Key | Default | Extra          |
+-------------------------------+------------------+------+-----+---------+----------------+
| crawl_id                      | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| group_id                      | varchar(50)      | NO   |     | NULL    |                |
| timestamp                     | datetime         | YES  |     | NULL    |                |
| host                          | varchar(50)      | YES  |     | NULL    |                |
| url                           | varchar(200)     | NO   |     | NULL    |                |
| prefix                        | varchar(20)      | NO   |     | NULL    |                |
| headless                      | tinyint(1)       | YES  |     | NULL    |                |
| devtools_connect              | tinyint(1)       | YES  |     | NULL    |                |
| interactive                   | tinyint(1)       | YES  |     | NULL    |                |
| timeout_used                  | int(10) unsigned | YES  |     | NULL    |                |
| num_resources                 | int(10) unsigned | YES  |     | NULL    |                |
| num_scripts                   | int(10) unsigned | YES  |     | NULL    |                |
| num_cookies                   | int(10) unsigned | YES  |     | NULL    |                |
| num_dom_nodes                 | int(10) unsigned | YES  |     | NULL    |                |
| num_event_listeners           | int(10) unsigned | YES  |     | NULL    |                |
| num_unique_event_listeners    | int(10) unsigned | YES  |     | NULL    |                |
| num_attempted_event_listeners | int(10) unsigned | YES  |     | NULL    |                |
| num_triggered_event_listeners | int(10) unsigned | YES  |     | NULL    |                |
| browser_path                  | varchar(200)     | YES  |     | NULL    |                |
| browser_md5                   | char(32)         | YES  |     | NULL    |                |
| browser_version               | varchar(50)      | YES  |     | NULL    |                |
| v8_version                    | varchar(50)      | YES  |     | NULL    |                |
| user_agent                    | varchar(500)     | YES  |     | NULL    |                |
| load_event_fired              | tinyint(1)       | YES  |     | 0       |                |
| tt_first_load_event           | float            | YES  |     | NULL    |                |
| tt_nav_complete               | float            | YES  |     | NULL    |                |
| tt_browser_close              | float            | YES  |     | NULL    |                |
| tt_interact_complete          | float            | YES  |     | NULL    |                |
| tt_finish_success             | float            | YES  |     | NULL    |                |
| coverage_success              | tinyint(1)       | YES  |     | NULL    |                |
| coverage_total_bytes          | int(10) unsigned | YES  |     | NULL    |                |
| coverage_covered_bytes        | int(10) unsigned | YES  |     | NULL    |                |
| coverage_percent_coverage     | float            | YES  |     | NULL    |                |
| git_commit_sha                | char(40)         | YES  |     | NULL    |                |
+-------------------------------+------------------+------+-----+---------+----------------+
```

### The `resources` Table

```
+----------------+------------------+------+-----+---------+-------+
| Field          | Type             | Null | Key | Default | Extra |
+----------------+------------------+------+-----+---------+-------+
| crawl_id       | int(10) unsigned | NO   |     | NULL    |       |
| resource_url   | varchar(500)     | NO   |     | NULL    |       |
| document_url   | varchar(500)     | YES  |     | NULL    |       |
| type           | varchar(20)      | YES  |     | NULL    |       |
| remote_ip      | varchar(16)      | YES  |     | NULL    |       |
| remote_port    | int(10) unsigned | YES  |     | NULL    |       |
| bytes          | int(10) unsigned | YES  |     | NULL    |       |
| initiator_type | varchar(32)      | YES  |     | NULL    |       |
+----------------+------------------+------+-----+---------+-------+
```

### The `scripts` Table
```
+------------------------+------------------+------+-----+---------+-------+
| Field                  | Type             | Null | Key | Default | Extra |
+------------------------+------------------+------+-----+---------+-------+
| crawl_id               | int(10) unsigned | NO   |     | NULL    |       |
| script_id              | int(10) unsigned | NO   |     | NULL    |       |
| base_url               | varchar(500)     | NO   |     | NULL    |       |
| length                 | int(10) unsigned | YES  |     | NULL    |       |
| hash                   | char(40)         | YES  |     | NULL    |       |
| fuzzy_hash             | varchar(128)     | YES  |     | NULL    |       |
| coverage_total_bytes   | int(10) unsigned | YES  |     | NULL    |       |
| coverage_covered_bytes | int(10) unsigned | YES  |     | NULL    |       |
+------------------------+------------------+------+-----+---------+-------+
```

### The `listeners` Table

This table contains a row for each event listener found during a crawl.

```
+----------------+------------------+------+-----+---------+-------+
| Field          | Type             | Null | Key | Default | Extra |
+----------------+------------------+------+-----+---------+-------+
| crawl_id       | int(10) unsigned | NO   |     | NULL    |       |
| script_id      | int(10) unsigned | NO   |     | NULL    |       |
| type           | varchar(50)      | NO   |     | NULL    |       |
| once           | tinyint(1)       | YES  |     | NULL    |       |
| use_capture    | tinyint(1)       | YES  |     | NULL    |       |
| line_number    | int(11)          | YES  |     | NULL    |       |
| column_number  | int(11)          | YES  |     | NULL    |       |
| should_trigger | tinyint(1)       | YES  |     | NULL    |       |
| did_trigger    | tinyint(1)       | YES  |     | NULL    |       |
+----------------+------------------+------+-----+---------+-------+
```

## JSON Results Files

While this database provides easier/faster access, it *does not yet* contain all
data gathered by the crawl. The full crawl data for each page crawled is stored
in a set of JSON files, either stored locally on your computer (for local
crawls) or, when the main architecture is in use, stored at `/data3/js_crawls`. 

### Crawl Metadata

`<url>.metadata.json`

This file contains metadata, both about the parameters used for
the crawl and the results. It contains the following fields:

- `timestamp` - Human readable timestamp taken at the beginning of the crawl
- `host` - The hostname of the machien that carried out the crawl
- `url` - The URL crawled
- `prefix` - The protocol used (http or https)
- `coverage`
    * `success` - Boolean indicating whether coverage measurements succeeded
    * `total_bytes` - The total bytes of JavaScript in the page which could
     potentially be executed
    * `covered_bytes` - the actual number of bytes executed
- `dom_counters`
    * `documents` - Number of documents loaded
    * `jsEventListeners` - Number of JavaScript event listeners registered on the
     page
    * `nodes` - The total number of nodes in the DOM
- `metrics` - As given by DevTools at
  [Performance.getMetrics](https://chromedevtools.github.io/devtools-protocol/tot/Performance#method-getMetrics).
- `num_resources` - The total number of resources loaded by the page
- `timeout_used` - The timeout (in seconds) used for the crawl
- `num_scripts` - The total number of scripts loaded by the page
- `load_event_fired` - Boolean indicating whether or not a load event fired on
  the page
- `ts_start_crawl` - Simple timestamp from beginning of crawl
- `ts_first_load_event` - Simple timestamp from the first load event
- `browser_version`
    * `Protocol-Version` - Version of DevTools Protocol in use
    * `webSocketDebuggerUrl`
    * `Browser` - Browser version
    * `WebKit-Version`
    * `V8-Version`
    * `User-Agent`


---

### JavaScript Trace 

`<url>.trace.json.gz`

This file contains a JSON representation of the JavaScript API call trace for
that particular crawl. The schema for these files are below.

- `trace`
    * `parsing_errors` - Number of parsing errors encountered while parsing trace
    * `script` []
        * `script_id` - Integer identifier for script used by Chrome
        * `base_url` - URL the script originates from. A blank base URL
          indicates that the script was part of the original page
        * `execution` []
            * `callback` - boolean
            * `call` []
                * `call_type` - one of `get`, `set`, `call` or `cons`
                * `class` - Class/Namespace of the API call (ex. `V8Node`)
                * `function` - API function called (without the class)
                * `arg` []
                * `ret_val` - Return value of the API call


---

### Resources

`<url>.resources.json.gz`

This file contains information on the resources (scripts, images, etc.) loaded
during the crawl. It contains information included as a parameter to the
Chrome DevTools
[Network.requestWillBeSent](https://chromedevtools.github.io/devtools-protocol/tot/Network#event-requestWillBeSent)
event, and also includes a `bytes` field containing the size of the resource in
bytes.

---

### Cookies

`<url>.cookies.json`

This file contains all cookies created by the website during the crawl time. For
the format of this file, refer to DevTools
[Network.Cookie](https://chromedevtools.github.io/devtools-protocol/tot/Network#type-Cookie).

---

### DOM Tree

`<url>.dom.json.gz`

This file contains a JSON representation of a DOM snapshot, taken at the end of
the crawl period. The format of the DOM is given by the DevTools
[DOM.Node](https://chromedevtools.github.io/devtools-protocol/tot/DOM#type-Node)
(The DOM tree can be walked starting at the root node).


---

Note: Use of Elasticsearch for crawl data has been discontinued for now.
