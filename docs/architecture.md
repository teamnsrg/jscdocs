# System Architecture

While the crawler can be used on its own, it is designed for use by a
distrubuted task queue, allowing the assignment of tasks to different workers.
Below, we explain how this crawling architecture is structured.

## Input

Our system takes one or more crawling tasks as input. A crawling task specifies
the parameters for a crawl of one or more web pages. A single crawling task may
entail many website crawls in many different ways. For a more detailed
explanation of crawling tasks, see the documentation [here](/crawl-tasks.md)

