#!/usr/bin/perl

use LW2;
use WWW::LW2;

my $LW2 = WWW::LW2->new( );

$TARGET = 'www.example.com';

$LW2->newHttpRequest(
	host    => $TARGET,
	method  =>   'GET',
	timeout =>      10,
);

$LW2->request->{'User-Agent'} = 'libwhisker-crawler-demo/1.0';
$LW2->request->{whisker}->{port} = 80;

$LW2->fixupHttpRequest( $LW2->getRequest ); # or $LW2->fixupHttpReques;

$LW2->newCrawl(
	"http://$TARGET/",	# start URL
	2,					# depth
	$LW2->getRequest	# premade LW request
);

$LW2->{'crawler'}->{config}->{save_cookies}=1;
$LW2->{'crawler'}->{config}->{save_skipped}=1;

$result = $LW2->{'crawler'}->{crawl}->( );

if( !defined $result ){
	print "There was an error:\n";
	print $LW2->{'crawler'}->{errors}->[0];
} else {
	print "We crawled $result URL(s)\n";
}

my ($key, $value);

# $TRACK is a hash ref (\%TRACK)
my $TRACK_HASH = $LW2->{'crawler'}->{track};

print "\n\nCODE\tURL\n";
while( ($key,$value) = each (%$TRACK_HASH) ){
	print "$value\t$key\n";
}


