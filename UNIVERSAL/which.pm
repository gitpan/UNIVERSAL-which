package UNIVERSAL::which;
use 5.008001;
use strict;
use warnings;
our $VERSION = sprintf "%d.%02d", q$Revision: 0.2 $ =~ /(\d+)/g;

sub UNIVERSAL::which{
    my ($self, $method) = @_;
    my $coderef = $self->can($method);
    unless ($coderef){
	$method = 'AUTOLOAD';
	$coderef = $self->can($method);
    }
    return unless $coderef;
    require B;
    my $pkg =  B::svref_2object($coderef)->GV->STASH->NAME;
    return wantarray ? ($pkg, $method) : $pkg . '::' . $method;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

UNIVERSAL::which - tells fully qualified name of the method

=head1 SYNOPSIS

  use UNIVERSAL::which;
  use Some::Sub::Class; # which inherits lots of modules
  # ....
  my $o   = Some::Sub::Class->new;
  # in scalar context
  my $fqn = $o->which("method");
  # in list context
  my ($pkg, $name) = $o->which("method");

=head1 DESCRIPTION

UNIVERSAL::which provides only one method, C<which>.

As the name suggests, it returns the fully qualified name of a given
method.  Sometimes you want to know the true origin of a method but
inheritance and AUTOLOAD gets in your way.  This module does just that.

t/*.t illustrates how UNIVERSAL::which behaves more in details.

=head1 SEE ALSO

L<perlobj>, L<UNIVERSAL::canAUTOLOAD>

=head1 AUTHORS

Dan Kogai, E<lt>dankogai@dan.co.jpE<gt>

Original idea seeded by: Koichi Taniguchi, E<lt>taniguchi@livedoor.jpE<gt>

B::svref_2object trick by: HIO, E<lt>hio@hio.jpE<gt>

AUTOLOAD case suggested by: k.daiba, E<lt>keiichi@tokyo.pm.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Dan Kogai

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
