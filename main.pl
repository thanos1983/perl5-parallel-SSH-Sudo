#! /usr/bin/perl

use strict;
use warnings;
use InputInitialization;
use Data::Dumper qw(Dumper);

die "Please use correct input: 'perl $0 [Configuration File.ini]'\n" if @ARGV > 1;

my $object = new InputInitialization($ARGV[0]);
# Get configuration file which is set using constructor.
my $conf_file = $object->getConfFile();

print Dumper \$conf_file;
