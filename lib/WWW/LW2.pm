########################################################################
# Copyright (C) 2008 by Alexander Sviridenko
########################################################################

#=======================================================================
#                               WWW::LW2
#=======================================================================

package WWW::LW2;

use 5.008008;
use strict;
use warnings;

use vars qw($VERSION $LW2_VERSION);

$VERSION = '0.10';

{
	$LW2_VERSION = $LW2::VERSION;
	die "LW2 not required!" unless defined $LW2_VERSION;
	my @VERSION = split(/\./, $LW2_VERSION);
	if ( $VERSION[0] != 2 || $VERSION[1] < 4 )
	{
		die "We expects LW2 2.4 or later";
	}
}

sub new
{
	my $inv = shift;
	my $class = ref($inv) || $inv;
	my $obj = {
		'request'  => undef,
		'response' => undef,
		'crawler'  => undef,
		
		'cookie' => WWW::LW2::Cookie->new,
		'uri'    => WWW::LW2::URI->new,
		'utils'  => WWW::LW2::Utils->new,
	};
	bless $obj, $class;
	return $obj;
}

sub uri         { shift->{'uri'}    }
sub utils       { shift->{'utils'}  }
sub cookie      { shift->{'cookie'} }

sub config      { shift->{'config'}   }
sub request     { shift->{'request'}  }
sub response    { shift->{'response'} }

sub getRequest  { return $_[0]->{'request'}  }
sub getResponse { return $_[0]->{'response'} }
sub getCrawler  { return $_[0]->{'crawler'}  }

sub newHttpRequest
{
	my $obj = shift;
	$obj->{'request'} = &LW2::http_new_request(@_);
	return $obj->{'request'};
}

sub newHttpResponse
{
	my $obj = shift;
	$obj->{'response'} = &LW2::http_new_response(@_);
	return $obj->{'response'};
}

sub fixupHttpRequest
{
	my $obj = shift;
	my $request = shift || $obj->getRequest;
	&LW2::http_fixup_request( $request );
}

sub doHttpRequest
{
	my $obj = shift;
	return &LW2::http_do_request(@_);
}

sub resetHttp
{
	my $obj = shift;
	&LW2::http_reset( );
}

sub newCrawl
{
	my $obj = shift;
	$obj->{'crawler'} = &LW2::crawl_new(@_);
	return $obj->{'crawler'};
}

sub getPage
{
	my $obj = shift;
	return &LW2::get_page(@_);
}

sub getPageToFile
{
	my $obj = shift;
	return &LW2::get_page_to_file(@_);
}

sub readForms
{
	my $obj = shift;
	return &LW2::forms_read(@_);
}

sub writeForms
{
	my $obj = shift;
	return &LW2::forms_write(@_);
}

sub dump
{
	my $obj = shift;
	return &LW2::dump(@_);
}

#=======================================================================
#                           WWW::LW2::Cookie
#=======================================================================

package WWW::LW2::Cookie;

sub new
{
	my $inv = shift;
	my $class = ref($inv) || $inv;
	my $obj = {
		'jar' => undef,
	};
	bless $obj, $class;
	return $obj;
}

sub getJar { return $_[0]->{'jar'} }

sub newCookieJar
{
	my $obj = shift;
	$obj->{'jar'} = &LW2::cookie_new_jar(@_);
	return $obj->{'jar'};
}

sub readCookie
{
	my $obj = shift;
	return &LW2::cookie_read(@_);
}

sub parseCookie
{
	my $obj = shift;
	return &LW2::cookie_parse(@_);
}

sub writeCookie
{
	my $obj = shift;
	return &LW2::cookie_write(@_);
}

sub setCookie
{
	my $obj = shift;
	return &LW2::cookie_set(@_);
} 

sub getNames
{
	my $obj = shift;
	return &LW2::cookie_get_names(@_);
}

sub getValidNames
{
	my $obj = shift;
	return &LW2::cookie_get_valid_names(@_);
} 

#=======================================================================
#                             WWW::LW2::URI
#=======================================================================

package WWW::LW2::URI;

sub new
{
	my $inv = shift;
	my $class = ref($inv) || $inv;
	my $obj = {
	};
	bless $obj, $class;
	return $obj;
}

sub splitting
{
	my $obj = shift;
	return &LW2::uri_split(@_);	
}

sub joining
{
	my $obj = shift;
	return &LW2::uri_join(@_);
}

sub absolute
{
	my $obj = shift;
	return &LW2::uri_absolute(@_);
}

sub normalize
{
	my $obj = shift;
	return &LW2::uri_normalize(@_);
}

sub getDir
{
	my $obj = shift;
	return &LW2::uri_get_dir(@_);
}

sub stripPathParameters
{
	my $obj = shift;
	return &LW2::uri_strip_path_parameters(@_);
}

sub parseParameters
{
	my $obj = shift;
	return &LW2::uri_parse_parameters(@_);
}

sub escape
{
	my $obj = shift;
	return &LW2::uri_escape(@_);
}

sub unescape
{
	my $obj = shift;
	return &LW2::uri_unescape(@_);
}

package WWW::LW2::Utils;

sub new
{
	my $inv = shift;
	my $class = ref($inv) || $inv;
	my $obj = {
	};
	bless $obj, $class;
	return $obj;
}

sub recperm
{
	my $obj = shift;
	&LW2::utils_recperm(@_);
}

sub shuffleArray
{
	my $obj = shift;
	&LW2::utils_array_shuffle(@_);
}

sub randstr
{
	my $obj = shift;
	return &LW2::utils_randstr;
}

sub openPort
{
	my $obj = shift;
	return &LW2::utils_port_open(@_);
}

sub lowercaseKeys 
{
	my $obj = shift;
	return &LW2::utils_lowercase_keys(@_);
}

sub findLowercaseKey 
{
	my $obj = shift;
	return &LW2::utils_find_lowercase_key(@_);
}

sub findKey
{
	my $obj = shift;
	return &LW2::utils_find_key(@_);
}

sub deleteLowercaseKey
{
	my $obj = shift;
	return &LW2::utils_delete_lowercase_key(@_);
}

sub getOpts
{
	my $obj = shift;
	return &LW2::utils_getopts(@_);
}

sub wrapperText
{
	my $obj = shift;
	return &LW2::utils_text_wrapper(@_);
}

sub bruteUrl
{
	my $obj = shift;
	return &LW2::utils_bruteurl(@_);
}

1;

__END__

########################################################################
# POD Documentation
########################################################################

=head1 NAME

WWW::LW2 - the module for easy and convenient use LW2.

=head1 SYNOPSIS

  use LW2;
  use WWW::LW2;

  $LW2 = WWW::LW2->new;

=head1 DESCRIPTION

C<WWW::LW2> the module for easy and convenient use LW2. You can easily call LW2-functions from LW2 object created by WWW::LW2.

=head1 EXAMPLES

Examples you can find in 'examples' folder:
 api_demo.pl,
 crawl_demo.pl,
 form_demo1.pl,
 form_demo2.pl,
 simple_demo.pl.

=head1 SEE ALSO

LW2 L<http://www.wiretrip.net/rfp/lw.asp>

=head1 AUTHOR

Alexander Sviridenko, E<lt>mail@d2rk.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Alexander Sviridenko

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
