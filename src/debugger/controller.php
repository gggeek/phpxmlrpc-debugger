<?php

$vendorDir = __DIR__.'/../vendor';

if (!file_exists($vendorDir.'/autoload.php') || !file_exists($vendorDir.'/phpxmlrpc/phpxmlrpc/debugger/controller.php'))
    die('Please install the dependencies using composer');

include_once($vendorDir.'/autoload.php');

include_once($vendorDir.'/phpxmlrpc/phpxmlrpc/debugger/controller.php');
