#!/usr/bin/perl

use strict;
use warnings;
no  warnings 'uninitialized';

our $Script  = 'htmlpostproc.pl';
our $VERSION = '0.01';

my $item = shift;
my $base = shift || '';

local $/;
local $_ = <STDIN>;


my $docum;
my $documli;

    foreach my $pair ( [ 'Nginx',        'Nginx.html',      ],
                       [ 'Nginx::Test',  'Nginx/Test.html'  ],
                       [ 'Nginx::Util',  'Nginx/Util.html'  ],
                       [ 'Nginx::Redis', 'Nginx/Redis.html' ], 
                       [ 'Redis::Parser::XS', 'Redis/Parser/XS.html', 'hidden' ], 
                       [ 'Nginx::Perl',  'Nginx/Perl.html', 'hidden'  ] ) {

        my ($name, $href, $opt) = @$pair;

        if ($opt ne 'hidden') {

            $documli .= "<li>";

            if ($name eq $item) {
                $docum   .= "<b>$name</b>";
                $documli .= "<b>$name</b>";
            } else {
                $docum   .= "<a href=\"$base$href\">$name</a>";
                $documli .= "<a href=\"$base$href\">$name</a>";
                
                s!<cite>$name</cite>!<a href="$base$href">$name</a>!gs;
            }

            $documli .= "</li>\n";

            $docum .= " &nbsp;&nbsp; ";

        } else {

            if ($name ne $item) {
                s!<cite>$name</cite>!<a href="$base$href">$name</a>!gs;
            }
        }
    }




my $css     = do { open my $fh, '<', 'nginx-perl.in/style.css'; <$fh> };
my $podpre  = do { open my $fh, '<', 'nginx-perl.in/podpre.html'; <$fh> };
my $podpost = do { open my $fh, '<', 'nginx-perl.in/podpost.html'; <$fh> };

my $style = <<"END";
<style type="text/css"><!--
$css
--></style>
END

if ($item eq 'Home') {
    $podpre = 
    $podpost = '';
}

s/(<body[^>]*>)/$style\n$1\n$podpre/;
s/>Index</>$item</;
s/(<\/body[^>]*>)/$podpost\n$1/;

s/%% DOCUM %%/$docum/g;
s/%% DOCUMLI %%/$documli/g;
s/%% BASE %%/$base/g;

print;

