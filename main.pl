#! /usr/bin/perl

use strict;
use warnings;
use ParallelSSH;
use InputInitialization;
use Data::Dumper qw(Dumper);

my $objectInputInialization = new InputInitialization('conf.ini');
my $data = $objectInputInialization->validateAndExtractData();

my $objectParallelSSH = new ParallelSSH( $data );
my $hosts = $objectParallelSSH->createSSHConnections();
print Dumper $hosts;
# uname -a
# my @listOS = $object->
