package InputInitialization;

use Carp;
use strict;
use warnings;
use Fcntl qw(:flock);
use Config::IniFiles;

use constant {
    FALSE  => 0,
    TRUE   => 1,
};


sub new {
    my $class = shift;
    my $self = {
        _configurationFile => shift || undef,
    };
    bless $self, $class;
    return $self;
}

sub validateAndExtractData {
    my ( $self ) = @_;
    my $conf_file = $self->{_configurationFile} if (_checkConfFileInput( $self ));

    if ($conf_file !~ /\.ini$/i and $conf_file !~ /\.cfg$/i) {
	croak "Please enter a valid file with .ini extension or .cfg\n";
    }

    open my $fh , '<' , "".$conf_file.""
	or croak "Could not open file: ".$conf_file." - $!\n";

    flock($fh, LOCK_SH)
	or croak "Could not lock '".$conf_file."' - $!\n";

    tie my %ini, 'Config::IniFiles', ( -file => "".$conf_file."" )
	or croak "Error: IniFiles->new: @Config::IniFiles::errors";

    close ($fh)
	or croak "Could not close '".$conf_file."' - $!\n";

    return \%ini;
}

sub getConfFile {
    my $self = @_;
    return $self->{_configurationFile} if _checkConfFileInput($self);
}

sub _checkConfFileInput {
    my ( $self ) = @_;
    croak "Forgot to define hosts on 'new InputInitialization()'\n"
	if (not defined($self->{_configurationFile}));
    return TRUE;
}

1;
