#! /usr/bin/perl

use strict; use warnings;
use diagnostics;

open(FILE,'<',"PKref.tsv") or die "Missing input\n";
my @file=<FILE>; chomp @file; close(FILE);

open(FILE,'<',"PKref.sasa") or die "Missing SASA\n";
my @sasa=<FILE>; chomp @sasa; close(FILE);


my %sasa;
for my $line (@sasa) {
  my @a = split("\t",$line);
  my $tmp = $a[1];
  $tmp =~ tr/\[\]\ //d;
  my @b = split(",",$tmp);
  for my $ind (0 .. $#b) { $sasa{$a[0]}[$ind] = $b[$ind] }
}

my $l = 0;
for my $line (@file) {
  if ( $line =~/^Y/ ) {
    ++$l;
    my @a = split("\t",$line);
    my $srt = $a[3] - 1; my $stp = $a[4] - 1;
    
    if ( length($sasa{$a[1]}[0]) ) {
      my $sum = 0;
      for my $ind ($srt .. $stp) { 
        if ( !length $sasa{$a[1]}[$ind] ) { print "!!ERR $l $a[0] $ind\n" }
        else { $sum = $sum + $sasa{$a[1]}[$ind] } 
      }
      my $len = $stp - $srt + 1;
      $sum = int($sum*100)/100;
      my $rel = int(($sum/$len)*100)/100;
      print "$line\t$sum\t$rel\t$len\n";
    }
  }
}
