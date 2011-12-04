#!/bin/sh


rm -rf tmp/nginx-perl
git clone ../nginx-perl tmp/nginx-perl && \
V=$(grep 'VERSION = ' tmp/nginx-perl/src/http/modules/perl/Nginx.pm | \
perl -lne '/(?:\d+\.?)+/ && print $&') && \
cd tmp && \
rm -f nginx-perl-$V-prerelease.tar.gz && \
rm -rf nginx-perl-$V-prerelease && \
mv nginx-perl nginx-perl-$V-prerelease && \
tar --exclude='.*' -cvzf nginx-perl-$V-prerelease.tar.gz \
	nginx-perl-$V-prerelease && \
rm -rf nginx-perl-$V-prerelease && \
mv nginx-perl-$V-prerelease.tar.gz ../


