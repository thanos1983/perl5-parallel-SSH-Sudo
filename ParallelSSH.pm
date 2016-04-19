package ParallelSSH;

use strict;
use warnings;

use Carp;
use Files;
use FindBin '$Bin';
use Net::OpenSSH::Parallel;
use Data::Dumper qw(Dumper);

use constant {
    FALSE  => 0,
    TRUE   => 1,
};

sub new {
    my ($class, $hosts) = @_;
    my $self = {
	_pssh  => undef,
        _hosts => $hosts,
    };
    bless $self, $class;
    return $self;
}

sub createSSHConnections {
    my ( $self ) = @_;

    _checkHosts( $self );

    my @hosts = keys %{$self->{_hosts}};

    my $error_policy = 'OSSH_ON_ERROR_ABORT';
    my $maximum_workers = @hosts;
    my $maximum_connections = 2 * $maximum_workers;
    my $maximum_reconnections = 3;

    my %opts = ( workers       => $maximum_workers,
		 connections   => $maximum_connections );

    my @std_fh = ();
    $self->{_pssh} = Net::OpenSSH::Parallel->new( %opts );

    my $fileObject = new Files();
    $fileObject->createDirIfDoesNotExist($self->{_hosts});
    foreach my $host (@hosts) {
;
	if ($self->{_hosts}->{$host}{'dir'}) {
	    chdir("$self->{_hosts}->{$host}{'dir'}/$self->{_hosts}->{$host}{'label'}");
	}
	else {
	    chdir("./$self->{_hosts}->{$host}{'label'}");
	}

	open(my $stdout_fh, '>', $self->{_hosts}->{$host}{'label'}.".log")
	    or croak "Could not open file '".$self->{_hosts}->{$host}{'label'}.".log' $!";

	open(my $stderr_fh, '>>', $self->{_hosts}->{$host}{'label'}.".err")
	    or croak "Could not open file '".$self->{_hosts}->{$host}{'label'}.".err' $!";

	chdir($Bin);

	$self->{_pssh}->add_host(
	    $self->{_hosts}->{$host}{'label'},
	    $host,
	    user     => $self->{_hosts}->{$host}{'user'},
	    port     => $self->{_hosts}->{$host}{'port'},
	    password => $self->{_hosts}->{$host}{'password'},
	    on_error => $error_policy,
	    reconnections     => $maximum_reconnections,
	    default_stdout_fh => $stdout_fh,
	    default_stderr_fh => $stderr_fh
	    );

	push(@std_fh, $stdout_fh, $stderr_fh);
    }

    print Dumper $self->{_pssh};
    exit 0;
    _closeFH(@std_fh);
    return \@std_fh;
    exit 0;
}

sub retrieveOS {
    my ( $self ) = @_;
    $self->{_pssh}->push('*', command => 'ls')
}

sub getHosts {
    my ( $self ) = @_;
    return $self->{_hosts} if _checkHosts( $self );
}

sub _closeFH {
    foreach my $fh (@_) { close $fh or croak "Error closing $!\n"; }
}

sub _checkHosts {
    my ( $self ) = @_;
    croak "Forgot to define hosts on 'new parrallelSSH()'\n"
	if not defined($self->{_hosts});
    return TRUE;
}

1;
