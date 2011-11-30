package CHI::Driver::Memcached::Test::Driver::libmemcached;
BEGIN {
  $CHI::Driver::Memcached::Test::Driver::libmemcached::VERSION = '0.14';
}
use Moose;
use strict;
use warnings;

extends 'CHI::Driver::Memcached::libmemcached';
with 'CHI::Driver::Memcached::Test::Driver::Base';

__PACKAGE__->meta->make_immutable();

1;
