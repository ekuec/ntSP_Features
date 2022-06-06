#! /usr/bin/perl

use strict; use warnings;

open(FILE,'<',"yeast_locus.txt") or die "Missing ref\n";
my @ref=<FILE>; chomp @ref; close(FILE);

open(FILE,'<',"LiP_PeptideList.txt") or die "Missing file\n";
my @file=<FILE>; chomp @file; close(FILE);

open(FILE,'<',"yeast_diso_master.txt") or die "Missing seq\n";
my @seq = <FILE>; chomp @seq; close(FILE);

open(FILE,'<',"dssp_seq_yeast.fa") or die "Missing dssp\n";
my @dss = <FILE>; chomp @dss; close(FILE);

my %map;
for my $line (@ref) { my @a=split("\t",$line); $map{$a[1]}=$a[0] }

my %seq; my $name;
for my $line (@seq) {
  if ( $line =~ />\s+([A-Z0-9_-]+)\s+\|/ ) { $name = $1 }
  else { $seq{$name} = $line }
}

my %dss; 
for my $line (@dss) {
  if ( $line =~ /sp\|([A-Z0-9_-]+)\|/ ) { $name = $1 }
  else { $dss{$name} = $line }
}

print "Locus\tUniprot\tSequence\tStart\tStop\tDSSP\tY/N\n";

my @aas; my @ss;
for my $line (@file) {
  my @a = split("\t",$line);
  my $id = $a[0]; 
  my $srt = $a[2] - 1;
  my $stp = $a[3] - 1;
  
  if ( !$map{$id} ) { print "ERR $id\n" }
  else { 
    @aas = split("",$seq{ $map{$id} });
    @ss  = split("",$dss{ $map{$id} });
    print "$id\t";
    print "$map{$id}\t";
    print "$a[1]\t$a[2]\t$a[3]\t";

    for my $ind ( $srt .. $stp ) { print "$ss[$ind]" }
    print "\t";

    my ($oc,$dc,$ef) = (0,0,0);
    for my $ind ( $srt .. $stp ) { 
      if    ( $aas[$ind] eq "o" ) { ++$oc }
      elsif ( $aas[$ind] eq "D" ) { ++$dc }
      else  { $ef = 1 }
    }
    if ( $ef ) { print "ERR\n" }
    else {
      if ( $oc > $dc ) { print "hit\n" }
      else { print "NA\n" }
    }
  }
}

