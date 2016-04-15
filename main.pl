#! /usr/bin/perl

use strict;
use warnings;
use ParallelSSH;
use InputInitialization;
use Data::Dumper qw(Dumper);

my $objectInputInialization = new InputInitialization('conf.ini');
my $data = $objectInputInialization->validateAndExtractData();
my @hosts = keys %$data;

my $objectParallelSSH = new ParallelSSH(\@hosts);
my $hosts = $objectParallelSSH->getHosts();
print Dumper $hosts;
# uname -a
# my @listOS = $object->
