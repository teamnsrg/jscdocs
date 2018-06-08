# Using Crawl Data

Currently, crawl data is stored on the NSRG NFS drive, in a folder
located at `/data3/js_traces`. This directory contains _many_ folders, each named
as follows `/data3/js_traces/<url>-<12 Digit Crawl ID>/`. Each directory,
corresponding to a single crawl, contains the following files:

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

```
TODO
```

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
