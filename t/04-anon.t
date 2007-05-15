use strict;
use warnings;
use UNIVERSAL::which;
use Test::More;

{
    no warnings 'once';
    package Foo;
    my $code = sub { 1 };
    *moge = \&Bar::muge;
    package Bar;
    *muge = $code;
}

plan tests => 2;
is(Bar->which('muge'), 'Foo::__ANON__');
is(Foo->which('moge'), 'Bar::muge');
