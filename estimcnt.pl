#!/usr/bin/perl

use strict;
use Digest::MD5 qw(md5_hex);

my $bitmap = "\0" x (shift || 65536);
my $len = length($bitmap) * 8;
my ($cnt, $empty);

while (<STDIN>) {
    my ($key) = split ' ', $_, 2;

    vec ($bitmap, (hex substr md5_hex($key), 0, 8) % $len, 1) = 1, 
     $cnt++
}

vec($bitmap, $_, 1) == 0 && ++$empty  for 0 .. $len - 1;

print int(-$len * log($empty / $len));
print "/$cnt\n";

