package CHI::Driver::Memcached::Test::Driver::Fast;
BEGIN {
  $CHI::Driver::Memcached::Test::Driver::Fast::VERSION = '0.14';
}
use Moose;
use strict;
use warnings;

extends 'CHI::Driver::Memcached::Fast';
with 'CHI::Driver::Memcached::Test::Driver::Base';

__PACKAGE__->meta->make_immutable();

1;
