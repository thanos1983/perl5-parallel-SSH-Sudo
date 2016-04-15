package ParallelSSH;

use Carp;
use Net::OpenSSH::Parallel;
use Data::Dumper qw(Dumper);

use constant {
    FALSE  => 0,
    TRUE   => 1,
};

sub new {
    my ($class, $hosts) = @_;
    my $self = {
        _hosts => $hosts,
    };
    bless $self, $class;
    return $self;
}

sub getHosts {
    my ( $self ) = @_;
    return $self->{_hosts} if _checkHosts( $self );
}

sub _checkHosts {
    my ( $self ) = @_;
    croak "Forgot to define hosts on 'new parrallelSSH()'\n"
	if not defined($self->{_hosts});
    return TRUE;
}

1;
