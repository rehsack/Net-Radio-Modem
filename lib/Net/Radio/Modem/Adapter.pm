package Net::Radio::Modem::Adapter;

use 5.010;

use strict;
use warnings;

=head1 NAME

Net::Radio::Modem::Adapter - base class for adapters to access radio network modems

=head1 METHODS

=cut

our $VERSION = '0.001';
my %aliases = (
                MNC    => 'MobileNetworkCode',
                MCC    => 'MobileCountryCode',
                IMSI   => 'InternationalMobileSubscriberIdentity',
                SNR    => 'SerialNumber',
                LAC    => 'LocationAreaCode',
                MSISDN => 'MobileSubscriberISDN',
                CI     => 'CellId',
              );

=head2 get_aliases

Returns the associative list of known aliases.

C<Net::Radio::Modem::Adapter> known only abbreviations:

    MNC    => 'MobileNetworkCode',
    MCC    => 'MoileCountryCode',
    IMSI   => 'InternationalMobileSubscriberIdentity',
    SNR    => 'SerialNumber',
    LAC    => 'LocationAreaCode',
    MSISDN => 'MobileSubscriberISDN',
    CI     => 'CellId',

But derived classes may know more.

=cut

sub get_aliases { return %aliases; }

=head2 get_alias_for($property)

Returns the alias for given property if known, the property (name) otherwise.

  $adapter->get_alias_for('MNC'); # returns MobileNetworkCode
  $adapter->get_alias_for('CellId'); # returns CellId

=cut

sub get_alias_for
{
    my %a = $_[0]->get_aliases();
    defined $a{ $_[1] } and return $a{ $_[1] };
    return $_[1];
}

=head2 new

Placeholder for initalization routine / constructor for derived N:R:M:A

Throws "unimplemented".

=cut

sub new
{
    die "unimplemented";    # with v5.12 we can use ...
}

=head2 get_modems

Placeholder for method returning the list of known modems.

Throws "unimplemented".

=cut

sub get_modems
{
    die "unimplemented";    # with v5.12 we can use ...
}

=head2 get_modem_property

Placeholder for method returning the value of named property for specified
modem device.

Throws "unimplemented".

=cut

sub get_modem_property
{
    die "unimplemented";    # with v5.12 we can use ...
}

1;
