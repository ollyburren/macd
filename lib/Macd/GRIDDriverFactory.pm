package Macd::GRIDDriverFactory;
 
use strict; 

sub instantiate {
	my $invoker	= shift;
	my $requested_type = shift;
	my $location	= "Macd/GRIDDriver/$requested_type.pm";
	my $class	= "Macd::GRIDDriver::$requested_type";
	require $location;
	return $class->new(@_);
}

1;                                                         
