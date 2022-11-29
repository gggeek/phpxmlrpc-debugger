XMLRPC Debugger Image
=====================

An xmlrpc and jsonrpc graphical debugger, made available as Docker container.

Also makes available a 'demo' combined xmlrpc/jsonrpoc server, which can be used as test target.

*WORK IN PROGRESS*

Installation
------------

Atm the container is not in a public Docker Container repository.

    git clone https://github.com/gggeek/phpxmlrpc-debugger.git
    docker build -t phpxmlrpc_debugger phpxmlrpc-debugger

Usage
-----

    docker run -ti -p 80:80 -p 443:443 phpxmlrpc_debugger:latest

License
-------
Use of this software is subject to the terms in the [license.txt](license.txt) file
