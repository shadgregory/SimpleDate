package SimpleDate;
use v5.10;
use Moose;

has 'year' => (is => 'rw', isa => 'Int');
has 'month' => (is => 'rw', isa => 'Int');
has 'day' => (is => 'rw', isa => 'Int');
has 'hour' => (is => 'rw', isa => 'Int');
has 'minute' => (is => 'rw', isa => 'Int');
has 'second' => (is => 'rw', isa => 'Int');
has 'date' => (is => 'rw',
	       trigger => \&_process_date);

sub _process_date {
  my ($self, $date) = @_;
  my $hour = 0;
  my $min = 0;
  my $sec = 0;
  if ($date =~ /\//) {
    my @date_array = split("/", $date);
    my ($year, $time) = split(" ", $date_array[2]);
    ($hour, $min, $sec) = split(":", $time) if ($time);
    $self->year($year);
    $self->month($date_array[0]);
    $self->day($date_array[1]);
    $self->hour($hour);
    $self->minute($min);
    $self->second($sec);
  } elsif ($date =~ /-/) {
    my @date_array = split("-", $date);
    my ($day, $time) = split(" ", $date_array[2]);
    ($hour, $min, $sec) = split(":", $time) if ($time);
    $self->year($date_array[0]);
    $self->month($date_array[1]);
    $self->day($day);
    $self->hour($hour);
    $self->minute($min);
    $self->second($sec);
  } else {
    print STDERR "Invalid date format";
  }
}

use overload '>' => \&_overload_greater_than;
use overload '<' => \&_overload_less_than;
use overload '==' => \&_overload_equal;

sub _overload_greater_than {
  my ( $d1, $d2 ) = @_;

  if ($d1->year > $d2->year) {
    return 1;
  } elsif ($d1->year < $d2->year) {
    return 0;
  }
  if ($d1->month > $d2->month) {
    return 1;
  } elsif ($d1->month < $d2->month) {
    return 0;
  }
  if ($d1->day > $d2->day) {
    return 1;
  } elsif ($d1->day < $d2->day) {
    return 0;
  }
  if ($d1->hour > $d2->hour) {
    return 1;
  } elsif ($d1->hour < $d2->hour) {
    return 0;
  }
  if ($d1->minute > $d2->minute) {
    return 1;
  } elsif ($d1->minute < $d2->minute) {
    return 0;
  }
  if ($d1->second > $d2->second) {
    return 1;
  } elsif ($d1->second <= $d2->second) {
    return 0;
  }
}

sub _overload_less_than {
  my ( $d1, $d2 ) = @_;
  if ($d1->year < $d2->year) {
    return 1;
  } elsif ($d1->year > $d2->year) {
    return 0;
  }
  if ($d1->month < $d2->month) {
    return 1;
  } elsif ($d1->month > $d2->month) {
    return 0;
  }
  if ($d1->day < $d2->day) {
    return 1;
  } elsif ($d1->day > $d2->day) {
    return 0;
  }
  if ($d1->hour < $d2->hour) {
    return 1;
  } elsif ($d1->hour > $d2->hour) {
    return 0;
  }
  if ($d1->minute < $d2->minute) {
    return 1;
  } elsif ($d1->minute > $d2->minute) {
    return 0;
  }
  if ($d1->second < $d2->second) {
    return 1;
  } elsif ($d1->second >= $d2->second) {
    return 0;
  }
}

sub _overload_equal {
  my ( $d1, $d2 ) = @_;
  return 0 if ($d1->year != $d2->year);
  return 0 if ($d1->month != $d2->month);
  return 0 if ($d1->day != $d2->day);
  return 0 if ($d1->hour != $d2->hour);
  return 0 if ($d1->minute != $d2->minute);
  return 0 if ($d1->second != $d2->second);
  return 1;
}

1;
