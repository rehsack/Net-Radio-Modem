package Net::Radio::Modem::Adapter::Null;

use 5.010;

use strict;
use warnings;

=head1 NAME

Net::Radio::Modem::Adapter::Null - Null modem adapter

=head1 DESCRIPTION

This radio modem adapter doesn't provide any information.
It simply returns empty results on all requests.

=head1 SYNOPSIS

  use Net::Radio::Modem;
  my $null_modem = Net::Radio::Adapter->new("Null");
  my @empty_list = $null_modem->get_modems();

Sure, it would be easier to get an empty list. But TIAMTWTDO ;)

=cut

our $VERSION = '0.001';
use base qw(Net::Radio::Modem::Adapter);

=head1 METHODS

=head2 new

Initializes Net::Radio::Modem::Adapter::Null object.

=cut

sub new
{
    my $class = shift;
    return bless( {}, $class );
}

=head2 get_modems

Returns an empty list of known modems.

=cut

sub get_modems
{
    return;
}

=head2 get_modem_property

Returns an empty value for the request to the property of not existing modem.

=cut

sub get_modem_property
{
    return;
}

1;
