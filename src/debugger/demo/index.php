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
}

// NB: when enabling debug mode, the server prepends the response's Json payload with a javascript comment.
// This will be considered an invalid response by most json-rpc client found in the wild - except our client of course
if (isset($_GET['FORCE_DEBUG'])) {
    $s->setDebug($_GET['FORCE_DEBUG']);
}
$s->compress_response = true;

/// @todo move this code to the testing framework
/*
// Out-of-band information: let the client manipulate the server operations.
// We do this to help the testsuite script: do not reproduce in production!
if (isset($_GET['RESPONSE_ENCODING'])) {
    $s->response_charset_encoding = $_GET['RESPONSE_ENCODING'];
}
if (isset($_GET['DETECT_ENCODINGS'])) {
    PhpXmlRpc::$xmlrpc_detectencodings = $_GET['DETECT_ENCODINGS'];
}
if (isset($_GET['EXCEPTION_HANDLING'])) {
    $s->exception_handling = $_GET['EXCEPTION_HANDLING'];
}
if (isset($_GET['FORCE_AUTH'])) {
    // We implement both Basic and Digest auth in php to avoid having to set it up in a vhost.
    // Code taken from php.net
    // NB: we do NOT check for valid credentials!
    if ($_GET['FORCE_AUTH'] == 'Basic') {
        if (!isset($_SERVER['PHP_AUTH_USER']) && !isset($_SERVER['REMOTE_USER']) && !isset($_SERVER['REDIRECT_REMOTE_USER'])) {
            header('HTTP/1.0 401 Unauthorized');
            header('WWW-Authenticate: Basic realm="Phpxmlrpc Basic Realm"');
            die('Text visible if user hits Cancel button');
        }
    } elseif ($_GET['FORCE_AUTH'] == 'Digest') {
        if (empty($_SERVER['PHP_AUTH_DIGEST'])) {
            header('HTTP/1.1 401 Unauthorized');
            header('WWW-Authenticate: Digest realm="Phpxmlrpc Digest Realm",qop="auth",nonce="'.uniqid().'",opaque="'.md5('Phpxmlrpc Digest Realm').'"');
            die('Text visible if user hits Cancel button');
        }
    }
}
*/

$s->service();
// That should do all we need!
