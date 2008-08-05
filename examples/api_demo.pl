#!/usr/bin/perl

use LW2;
use WWW::LW2;

my $LW2 = WWW::LW2->new( );

$TARGET = 'http://example.com';

if($TARGET!~m#^https*://#){
	print "Usage: $0 http://target-host/url\n";
	exit;
}

$LW2->newHttpRequest();
$LW2->newHttpResponse();

my $jar = $LW2->newCookieJar();

$LW2->uri->splitting($TARGET, $LW2->getRequest);

$LW2->fixupHttpRequest( $LW2->getRequest );

if( $LW2->doHttpRequest( $LW2->getRequest,$LW2->getResponse ))
{
	print 'ERROR: ', $LW2->response->{'whisker'}->{'error'}, "\n";
	print $LW2->response->{'whisker'}->{'data'}, "\n";
} else {

	# save any cookies sent to us into our $jar
	#$LW2->cookie->readCookie($jar,$response);

	print $LW2->response->{'whisker'}->{'code'}, "\n"; # HTTP return code
	print $LW2->response->{'Server'}, "\n";		# Server banner

	# If we wanted to save the SSL info
	if($LW2->request->{whisker}->{ssl}>0 && 
			$LW->request->{whisker}->{ssl_save_info}>0){
		print 'SSL cipher: ',
			$LW2->response->{whisker}->{ssl_cipher},"\n";
		print "Server cert:\n\t",
			$LW2->response->{whisker}->{ssl_cert_subject},"\n";
		print "Cert issuer:\n\t",
			$LW2->response->{whisker}->{ssl_cert_issuer},"\n";
	}

	# Uncomment following line to dump out the entire response hash
	#print $LW2->dump('response', $response);
}
