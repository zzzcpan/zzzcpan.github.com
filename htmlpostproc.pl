#!/usr/bin/perl

use strict;
use warnings;
no  warnings 'uninitialized';

our $Script  = 'htmlpostproc.pl';
our $VERSION = '0.01';

my $item = shift;
my $base = shift;

local $/;
local $_ = <STDIN>;

my $inj = "<div class=\"top\">\n";

    $inj .= "<h1>nginx-perl</h1>\n";

    foreach ( [ 'Home',        'index.html'      ],
             # [ 'Download',    'download.html'   ],
             # [ 'Benchmark',   'benchmark.html'  ] 
                                                    ) {

        my ($name, $href) = @$_;

        if ($name eq $item) {
            $inj .= "<div class=\"item\"><b>$name</b></div>\n";
        } else {
            $inj .= "<div class=\"item\">".
                        "<a href=\"$base$href\">$name</a></div>\n";
        }
    }

    $inj .= "<div class=\"item\">\n";
    $inj .= "Documentation:<br />\n";
    $inj .= "<blockquote>\n";

    foreach ( [ 'Nginx',        'Nginx.html',     ],
              [ 'Nginx::Util',  'Nginx/Util.html' ],
              [ 'Nginx::Redis', 'Nginx/Redis.html' ] ) {

        my ($name, $href) = @$_;

        if ($name eq $item) {
            $inj .= "<b>$name</b>";
        } else {
            $inj .= "<a href=\"$base$href\">$name</a>";
        }

        $inj .= "<br />";
    }

    $inj .= "</blockquote>\n";
    $inj .= "</div>\n";

$inj .= "</div>\n";

s/(<body[^>]*>)/$1\n$inj/;

print;

