package InputInitialization;

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

sub getConfFile {
    my ( $self ) = @_;
    return $self->{_configurationFile};
}

sub validateAndExtractData {
    my ( $self, $conf_file ) = @_;
    $conf_file = $self->{_configurationFile} if not defined($conf_file);

    if ($conf_file !~ /\.ini$/i and $conf_file !~ /\.cfg$/i) {
	return "Please enter a valid file with .ini extension or .cfg\n", $conf_file;
    }
    return FALSE, $conf_file;
}

1;
