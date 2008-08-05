#!/usr/bin/perl

use LW2;
use WWW::LW2;

my $LW2 = WWW::LW2->new( );

# first let's get the Slashdot homepage and it's HTML data

($response_code, $html_data) = $LW2->getPage( "http://slashdot.org/" );

if(!defined $response_code){
	print "There was an error\n";
	exit;
}

if($response_code == 200){ # the page exists

	print "Current Slashdot departments:\n";

	while( $html_data=~m/from the (.+) dept./g ){
		print "\t$1\n";
	}

} else {

	print "Slashdot response was $response_code.\n";
}

# now, let's download the Cipherwar homepage and save it to a file
# named "cipherwar.html"

$file="cipherwar.html";

$response_code = LW2::getPageToFile( "http://www.cipherwar.com/", $file );

if(!defined $response_code){
	print "There was an error retrieving cipherwar.com page\n";
} else {
	print "Cipherwar homepage saved to $file.\n";
}

print "\n";

