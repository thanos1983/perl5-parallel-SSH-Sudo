package Files;

use Carp;
use strict;
use warnings;

sub new {
    my ($class, $dirs) = @_;
    my $self = {
	_dirs => $dirs,
    };
    bless $self, $class;
    return $self;
}

sub createDirIfDoesNotExist {
    my ( $self ) = @_;
    unless(-e $self->{-dirs} or mkdir $self->{_dirs}) {
        croak "Unable to create $self->{_dirs}\n";
    }
    return;
}

1;
