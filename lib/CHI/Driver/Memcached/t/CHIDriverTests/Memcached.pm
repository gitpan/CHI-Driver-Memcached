package CHI::Driver::Memcached::t::CHIDriverTests::Memcached;
BEGIN {
  $CHI::Driver::Memcached::t::CHIDriverTests::Memcached::VERSION = '0.13';
}
use strict;
use warnings;
use base qw(CHI::Driver::Memcached::t::CHIDriverTests::Base);

sub testing_driver_class { 'CHI::Driver::Memcached' }
sub test_driver_class    { 'CHI::Driver::Memcached::Test::Driver::Memcached' }
sub memcached_class      { 'Cache::Memcached' }

1;
