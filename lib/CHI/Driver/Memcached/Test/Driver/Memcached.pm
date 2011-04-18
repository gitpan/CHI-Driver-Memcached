package CHI::Driver::Memcached::Test::Driver::Memcached;
BEGIN {
  $CHI::Driver::Memcached::Test::Driver::Memcached::VERSION = '0.13';
}
use Moose;
use strict;
use warnings;

extends 'CHI::Driver::Memcached';
with 'CHI::Driver::Memcached::Test::Driver::Base';

__PACKAGE__->meta->make_immutable();

1;
