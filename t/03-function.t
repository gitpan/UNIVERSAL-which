use strict;
use warnings;
use UNIVERSAL::which;
use Test::More;
package Foo;
use Carp;
our $DEBUG = 0;
sub DESTROY {};
sub AUTOLOAD{
    my $method = our $AUTOLOAD;
    $DEBUG and carp $method;
    $method =~ s/.*:://o;
    no strict 'refs';
    *{$AUTOLOAD} = sub{
	my $self = shift;
	$self->{$method} = shift if @_;
	$self->{$method};
    };
    shift->$method(@_); # goto &$AUTOLOAD
}
package Bar;
use base 'Foo';
sub new { bless {}, shift };
package main;
plan tests => 3;
my $u = Bar->new;
is(UNIVERSAL::which('Bar', 'new'), 'Bar::new');
is(UNIVERSAL::which('Bar', 'foo'), 'Foo::AUTOLOAD');
$u->foo('bar'); # now Foo::foo is defined by invocation
is(UNIVERSAL::which('Bar', 'foo'), 'Foo::foo');

