XMLRPC Debugger Image
=====================

An xmlrpc and jsonrpc graphical debugger, made available as Docker container.

Also makes available a 'demo' combined xmlrpc/jsonrpoc server, which can be used as test target.

Installation
------------

Atm the container is not in a public Docker Container repository.

    git clone https://github.com/gggeek/phpxmlrpc-debugger.git
    docker build -t phpxmlrpc-debugger phpxmlrpc-debugger

Usage
-----

    docker run -ti -p 80:80 -p 443:443 phpxmlrpc-debugger:latest

Notes:

* the container listens on ports 80 and 443. It is up to you to remap them to the desired ports on the hosts, or to limit
  access to them from a specific subnet, f.e to limit access to it from localhost.

  *NB:* the container runs as an open relay for http requests. Running the container with public access is _not_
  recommended. We take no responsibility for anyone doing so.

* the ssl certificate used for https connections is self-signed. ATM there is no provision to use a valid certificate or
  letsencrypt.org

* the parameters to access the demo server from the debugger are: `host: localhost`, `path: /demo/`

License
-------
Use of this software is subject to the terms in the [license.txt](license.txt) file
