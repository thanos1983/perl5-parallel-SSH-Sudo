package InputInitialization;

use Fcntl qw(:flock);
use Config::IniFiles;
use Data::Dumper qw(Dumper);

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

    open my $fh , '<' , "".$conf_file.""
	or return "Could not open file: ".$conf_file." - $!\n", $conf_file;

    flock($fh, LOCK_SH)
	or return "Could not lock '".$conf_file."' - $!\n", $conf_file;

    tie my %ini, 'Config::IniFiles', ( -file => "".$conf_file."" )
	or return "Error: IniFiles->new: @Config::IniFiles::errors", $conf_file;

    close ($fh)
	or return "Could not close '".$conf_file."' - $!\n", $conf_file;

    # my %config = %{$ini{"Perl"}};

    # print Dumper(\%config);

    # my @array = split(',',$config{test});

    # print Dumper(\@array);

    # return @array;

    return FALSE, \%ini;
}

1;
