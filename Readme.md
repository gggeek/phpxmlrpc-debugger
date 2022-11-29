XMLRPC Debugger Image
=====================

An xmlrpc and jsonrpc graphical debugger, made available as Docker container.

Also makes available a 'demo' combined xmlrpc/jsonrpoc server, which can be used as test target.

Based on the https://github.com/gggeek/phpxmlrpc, https://github.com/gggeek/phpxmlrpc-jsonrpc and
https://github.com/gggeek/jsxmlrpc libraries.

Installation
------------

    docker pull ghcr.io/gggeek/phpxmlrpc-debugger:latest

Usage
-----

    docker run -ti -p 80:80 -p 443:443 ghcr.io/gggeek/phpxmlrpc-debugger:latest

Then access `http://localhost/`, or whatever the hostname/IP is of the VM used to run the Container.

Notes:

* the container listens on ports 80 and 443. It is up to you to remap them to the desired ports on the hosts, or to limit
  access to them from a specific subnet, f.e to limit access to it from localhost.

  *NB:* the container runs as an open relay for http requests. Running the container with public access is _not_
  recommended. We take no responsibility for anyone doing so.

* the ssl certificate used for https connections is self-signed. ATM there is no provision to use a valid certificate or
  letsencrypt.org

* the parameters to access the demo server from the debugger are: `host: localhost`, `path: /demo/`

Development
-----------

To build and test locally the Container, you should follow a workflow similar to:

    git clone https://github.com/gggeek/phpxmlrpc-debugger.git
    docker build -t phpxmlrpc-debugger phpxmlrpc-debugger-local
    docker run -ti -p 80:80 -p 443:443 ghcr.io/gggeek/phpxmlrpc-debugger-local

License
-------
Use of this software is subject to the terms in the [license.txt](license.txt) file
