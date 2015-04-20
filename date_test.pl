use Test::More;
use SimpleDate;
use v5.10;

my $d1 = SimpleDate->new(date => '4/15/2015');
my $d2 = SimpleDate->new(date => '2015-04-11');
ok ($d1 > $d2);

my $d3 = SimpleDate->new(date => '04/01/2015 12:30:00');
my $d4 = SimpleDate->new(date => '04/01/2015 12:32:29');
ok ($d4 > $d3);
ok ($d3 < $d4);
my $d5 = SimpleDate->new(date => '04/01/2015 12:30:00');
my $d6 = SimpleDate->new(date => '2015-04-01 12:30:00');
ok ($d5 == $d6);
my $d7 = SimpleDate->new(date => '04/01/2015');
my $d8 = SimpleDate->new(date => '2015-04-01');
ok ($d7 == $d8);
my $d9 = SimpleDate->new(date => '04/01/2015');
my $d10 = SimpleDate->new(date => '2015-04-02');
ok ($d9 < $d10);

done_testing();
