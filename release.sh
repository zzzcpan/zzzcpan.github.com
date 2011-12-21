#!/bin/sh

rm -rf tmp/nginx-perl
git clone ../nginx-perl tmp/nginx-perl

V=$(grep 'VERSION = ' tmp/nginx-perl/src/http/modules/perl/Nginx.pm | \
perl -lne '/(?:\d+\.?)+/ && print $&') 

echo "version $V"

rm -f tmp/nginx-perl-$V.tar.gz
rm -f tmp/Nginx-Perl-$V.tar.gz
rm -rf tmp/Nginx-Perl-$V
rm -rf tmp/nginx-perl-$V

touch tmp/nginx-perl/MANIFEST
find tmp/nginx-perl/ | \
	perl -lne 's!tmp/nginx-perl/!!; print if $_ && !/^\./' \
	> tmp/nginx-perl/MANIFEST

( mv tmp/nginx-perl tmp/nginx-perl-$V && \
	cd tmp && \
	tar --exclude='.*' -cvzf nginx-perl-$V.tar.gz \
	nginx-perl-$V )

( mv tmp/nginx-perl-$V tmp/Nginx-Perl-$V && \
	cd tmp && \
	tar --exclude='.*' -cvzf Nginx-Perl-$V.tar.gz \
	Nginx-Perl-$V )

rm -rf tmp/Nginx-Perl-$V
rm -rf tmp/nginx-perl-$V

rm -f nginx-perl/nginx-perl-$V.tar.gz
rm -f Nginx-Perl-$V.tar.gz

mv tmp/nginx-perl-$V.tar.gz nginx-perl/
mv tmp/Nginx-Perl-$V.tar.gz ./

ls -lha nginx-perl/nginx-perl-$V.tar.gz Nginx-Perl-$V.tar.gz
