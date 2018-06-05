# Using Crawl Data

## Metadata

Metadata from the crawls is currently being stored in an
[Elasticsearch](https://www.elastic.co/) instance running on
_dragonstone.sprai.org_. Elasticsearch offers a REST API (listening at
`dragonstone.sprai.org:9200`.

You can also explore the metadata using
[Kibana](https://www.elastic.co/products/kibana), a visualization tool for
Elasticsearch data. You can access the Kibana web interface
[here](https://dragonstone.sprai.org:5601).

In order to access data via Elasticsearch or Kibana, you will need an account.
To get one, please [contact an adminstrator](mailto:pmurley2@illinois.edu).

## Trace and Resource data

Currently, trace and resource data is stored on the NSRG NFS drive, in a folder
located at `/data3/js_traces`. This directory contains _many_ folders, each
named as follows:
```
/data3/js_traces/<timestamp>-<url>/
```

Within each directory, there are three files:

* `<url>.metadata.json` - Same information as stored in Elasticsearch,
  basic metadata about that particular crawl
* `<url>.resources.json` - List of resources loaded by the page, and their
  size in bytes
* `<url>.trace.json.gz` - Gzipped JSON file containing the full JavaScript
  trace of the website.


Work is ongoing to put this data into a more accessible format. 
