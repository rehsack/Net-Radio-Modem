package Net::Radio::Modem::Adapter::Static;

use 5.010;

use strict;
use warnings;

use Carp qw(croak);

=head1 NAME

Net::Radio::Modem::Adapter::Static - static modem information adapter

=head1 DESCRIPTION

Allows mocking by defining static information for radio modems.

=head1 SYNOPSIS

  use Net::Radio::Modem;
  my $modem = Net::Radio::Modem->new('Static',
      '/test_0' => {
	  MNC => '262', MCC => '02', IMSI => '262020555017753',
	  LAC => ...},
      '/test_1' => { ... } ... );
  my @modems = $modem->get_modems(); # returns ('/test_0', 'test_1', ...)
  my $local_modem = grep {
         $modem->get_modem_property($_, 'MobileCountryCode') == 364
     } @modems; # find the one for Bahamas

To fill in reasonable value, see

=over 4

=item *

L<http://en.wikipedia.org/wiki/List_of_mobile_country_codes>

=item *

L<http://en.wikipedia.org/wiki/Mobile_Network_Code>

=back

=cut

our $VERSION = '0.001';
use base qw(Net::Radio::Modem::Adapter);

=head1 METHODS

=head2 new

Instantiates new static modem adapter.

B<TODO>: clone (depending on refcount?) provided information to allow
further modification in caller.

=cut

sub new
{
    my $class = shift;
    my %params;

    if ( scalar(@_) == 1 and ref( $_[0] ) eq "HASH" )
    {
        %params = %{ $_[0] };
    }
    elsif ( 0 == ( scalar(@_) % 2 ) )
    {
        %params = @_;
    }
    else
    {
        croak("Expecting hash or hash reference as argument(s)");
    }

    my %info;
    foreach my $modem ( keys %params )
    {
        foreach my $property ( keys %{ $params{$modem} } )
        {
            my $value = $params{$modem}->{$property};
            defined $Net::Radio::Modem::Adapter::Alias{$property}
              and $property = $Net::Radio::Modem::Adapter::Alias{$property};
            $info{$modem}->{$property} = $value;
        }
    }

    return bless( { config => \%info }, $class );
}

=head2 get_modems

Returns the keys of given initialisation hash as list of known modems.

=cut

sub get_modems
{
    return keys %{ $_[0]->{config} };
}

=head2 get_modem_property

Return the specified modem property, when known. Empty value otherwise.

=cut

sub get_modem_property
{
    my ( $self, $modem, $property ) = @_;

    defined( $self->{config}->{$modem} )
      and defined( $self->{config}->{$modem}->{$property} )
      and return $self->{config}->{$modem}->{$property};

    return;
}

1;
