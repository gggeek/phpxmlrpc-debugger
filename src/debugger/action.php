<?php

$vendorDir = __DIR__.'/../vendor';

if (!file_exists($vendorDir.'/autoload.php') || !file_exists($vendorDir.'/phpxmlrpc/phpxmlrpc/debugger/action.php'))
    die('Please install the dependencies using composer');

include_once($vendorDir.'/autoload.php');

include_once($vendorDir.'/phpxmlrpc/phpxmlrpc/debugger/action.php');

/// @todo rewrite the stock welcome message from the phpxmlrpc debugger to mention the embedded demo server
