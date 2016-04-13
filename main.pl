#! /usr/bin/perl

use strict;
use warnings;
use InputInitialization;
use Data::Dumper qw(Dumper);

my $object = new InputInitialization('conf.txt');
my ($error, $data) = $object->validateAndExtractData();
print $error if ($error);
# Get configuration file which is set using constructor.
# my $conf_file = $object->getConfFile();
print Dumper \$data;
