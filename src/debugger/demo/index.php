<?php

if (isset($_GET['showSource']) && $_GET['showSource']) {
    $file = debug_backtrace()[0]['file'];
    highlight_file($file);
    die();
}

$vendorDir = __DIR__.'/../../vendor';
$signaturesDir = $vendorDir . '/phpxmlrpc/phpxmlrpc/demo/server/methodProviders';

if (!file_exists($vendorDir.'/autoload.php') || !is_dir($signaturesDir))
    die('Please install the dependencies using composer');

include_once $vendorDir.'/autoload.php';

use PhpXmlRpc\Extras\SelfDocumentingServer;
use PhpXmlRpc\JsonRpc\Server as JsonRpcServer;
use PhpXmlRpc\PhpXmlRpc;

$signatures = array();

// Most of the code used to implement the webservices, and their signatures, are stowed away in neatly organized
// files, each demoing a different topic

// Definitions of webservices used for interoperability testing
$signatures1 = include($signaturesDir.'/interop.php');
$signatures2 = include($signaturesDir.'/validator1.php');

$signatures = array_merge($signatures1, $signatures2);

// Enable support for the NULL extension
PhpXmlRpc::$xmlrpc_null_extension = true;

if (($_SERVER['REQUEST_METHOD'] == 'POST') && isset($_SERVER['CONTENT_TYPE']) &&
    (strpos($_SERVER["CONTENT_TYPE"], 'json') !== false || strpos($_SERVER["CONTENT_TYPE"], 'javascript') !== false)) {
    $s = new JsonRpcServer($signatures, false);
} else {
    $s = new SelfDocumentingServer($signatures, false);
    $s->editorpath = '../jsxmlrpc/debugger/';
}

// NB: when enabling debug mode, the server prepends the response's Json payload with a javascript comment.
// This will be considered an invalid response by most json-rpc client found in the wild - except our client of course
if (isset($_GET['FORCE_DEBUG'])) {
    $s->setDebug($_GET['FORCE_DEBUG']);
}
$s->compress_response = true;

$s->service();
// That should do all we need!
