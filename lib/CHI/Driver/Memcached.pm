package CHI::Driver::Memcached;
use CHI;
use Cache::Memcached;
use Carp;
use Moose;
use strict;
use warnings;

our $VERSION = '0.09';

has 'memd' => ( is => 'ro', init_arg => undef );

extends 'CHI::Driver::Base::CacheContainer';

# Unsupported methods
#
__PACKAGE__->declare_unsupported_methods(
    qw(dump_as_hash get_keys get_namespaces is_empty clear purge));

__PACKAGE__->meta->make_immutable();

sub BUILD {
    my ( $self, $params ) = @_;

    $self->{mc_params} = $self->non_common_constructor_params($params);
    $self->{mc_params}->{namespace} = $self->{namespace} . ":";
    $self->{memd} = $self->{_contained_cache} = $self->_build_contained_cache;
}

sub _build_contained_cache {
    my ($self) = @_;

    return Cache::Memcached->new( $self->{mc_params} );
}

# Memcached supports fast multiple get
#

sub fetch_multi_hashref {
    my ( $self, $keys ) = @_;
    croak "must specify keys" unless defined($keys);

    return $self->memd->get_multi(@$keys);
}

1;

__END__

=pod

=head1 NAME

CHI::Driver::Memcached -- Distributed cache via memcached (memory cache daemon)

=head1 SYNOPSIS

    use CHI;

    my $cache = CHI->new(
        driver => 'Memcached',
        namespace => 'products',
        servers => [ "10.0.0.15:11211", "10.0.0.15:11212", "/var/sock/memcached",
        "10.0.0.17:11211", [ "10.0.0.17:11211", 3 ] ],
        debug => 0,
        compress_threshold => 10_000,
    );

=head1 DESCRIPTION

A CHI driver that uses Cache::Memcached to store data in the specified
memcached server(s).

=head1 CONSTRUCTOR OPTIONS

Namespace, appended with ":", is passed along to L<Cached::Memcached-E<gt>new>,
along with any constructor options L<not recognized by CHI|CHI/constructor>.
For example:

=over

=item compress_threshold

=item debug

=item no_rehash

=item servers

=back

=head1 METHODS

=over

=item memd

Returns a handle to the underlying Cache::Memcached object. You can use this to
call memcached-specific methods that are not supported by the general API, e.g.

    $self->memd->incr("key");
    my $stats = $self->memd->stats();

=back

=head1 UNSUPPORTED METHODS

These standard CHI methods cannot currently be supported by memcached.

=over

=item dump_as_hash

=item get_keys

=item get_namespaces

=item is_empty

=item purge

=back

=head1 SUPPORT AND DOCUMENTATION

Questions and feedback are welcome, and should be directed to the perl-cache
mailing list:

    http://groups.google.com/group/perl-cache-discuss

Bugs and feature requests will be tracked at RT:

    http://rt.cpan.org/NoAuth/Bugs.html?Dist=CHI-Driver-Memcached

The latest source code can be browsed and fetched at:

    http://github.com/jonswar/perl-chi-driver-memcached/tree/master
    git clone git://github.com/jonswar/perl-chi-driver-memcached.git

=head1 AUTHOR

Jonathan Swartz

=head1 SEE ALSO

L<CHI|CHI>, L<Cache::Memcached|Cache::Memcached>

=head1 COPYRIGHT & LICENSE

Copyright (C) 2007 Jonathan Swartz.

CHI::Driver::Memcached is provided "as is" and without any express or implied
warranties, including, without limitation, the implied warranties of
merchantibility and fitness for a particular purpose.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
