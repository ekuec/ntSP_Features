#! /usr/bin/perl

use strict; use warnings;

open(FILE,'<',"yst_contact_order.dat") or die "Missing file\n";
my @file =<FILE>; chomp(@file); close(FILE);

for my $line (@file) {
  if ($line =~ /AF-([A-Z0-9_]+)-F1.*Relative Contact Order: ([0-9.]+)/) {
     my $uid=$1; my $rco=$2;
     print "$uid\t$rco\n";
  }
}
