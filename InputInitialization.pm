package InputInitialization;

sub new {
    my $class = shift;
    my $self = {
        _configurationFile => shift,
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
    $self->{_configurationFile} = $conf_file if defined($conf_file);
    # if ($self->{_configurationFile} !~ /\.ini$/i) {
    # return 'Please enter a valid file with .ini extension\n';
    # }
    return $self->{_configurationFile};
}

1;
