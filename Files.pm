package Files;

use Carp;
use strict;
use warnings;
use Data::Dumper;

sub new {
    my ($class, $dirs) = @_;
    my $self = {
	_dirs => $dirs,
    };
    bless $self, $class;
    return $self;
}

sub createDirIfDoesNotExist {
    my ( $self, $hosts ) = @_;
    foreach my $host (keys %$hosts) {
	if ($hosts->{$host}{'dir'}) {
	    unless(-e "$hosts->{$host}{'dir'}/$hosts->{$host}{'label'}" or
		   mkdir("$hosts->{$host}{'dir'}/$hosts->{$host}{'label'}", 0700)) {
		croak "Unable to create $hosts->{$host}{'dir'}/$hosts->{$host}{'label'}\n";
	    }
	    chdir(".")
	}
	else {
	    unless(-e "./$hosts->{$host}{'label'}" or
		   mkdir("./$hosts->{$host}{'label'}", 0700)) {
		croak "Unable to create ./".$hosts->{$host}{'label'}."\n";
	    }
	    chdir(".")
	}
    }
    return;
}

1;
