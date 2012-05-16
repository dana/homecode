package Home::Utils;

use common::sense;
use Moose::Autobox;
use IO::Socket::INET;

sub
update_carbon {
    my @metrics = @_;
    eval {
        my $sock = IO::Socket::INET->new(
            PeerAddr => '127.0.0.1',
            PeerPort => 2003,
            Proto    => 'tcp') or die "IO::Socket::INET->new returned false\n";
        @metrics->map(sub {
            my $ts = $_->{ts} || time;
            $sock->print("$_->{metric} $_->{value} $ts\n");
            $_->{debug}->($_) if $_->{debug};
        });
        $sock->close;
    };
    die "Home::Utils::update_carbon failed: $@\n" if $@;
    return 1;
}

1;

__END__
update_carbon(
    {   metric => 'foo.bar',
        value => 10.1,
        ts => 1234567
    },{
        metric => 'foo.this',
        value => 10.2
    }
);
