
NGINXPERL = ../nginx-perl
POD2XHTML = pod2xhtml --toplink 0
HTMLPOSTPROC = perl htmlpostproc.pl
DEPS = Makefile \
	htmlpostproc.pl \
	nginx-perl.in/style.css \
	nginx-perl.in/podpre.html \
	nginx-perl.in/podpost.html \
	htmlpostproc.pl \
	nginx-perl/.exists

web: \
	nginx-perl/nginx-perl.gif \
	nginx-perl/nginx-perl-big.gif \
	nginx-perl/index.html \
	nginx-perl/Nginx.html \
	nginx-perl/Nginx/Test.html \
	nginx-perl/Nginx/Util.html \
	nginx-perl/Nginx/Redis.html \
	nginx-perl/Nginx/HTTP.html \
	nginx-perl/Redis/Parser/XS.html \
	nginx-perl/HTTP/Parser2/XS.html \
	nginx-perl/Nginx/Perl.html

nginx-perl/nginx-perl.gif: \
		$(DEPS) \
		nginx-perl.in/nginx-perl.gif
	cp nginx-perl.in/nginx-perl.gif nginx-perl/nginx-perl.gif

nginx-perl/nginx-perl-big.gif: \
		$(DEPS) \
		nginx-perl.in/nginx-perl-big.gif
	cp nginx-perl.in/nginx-perl-big.gif nginx-perl/nginx-perl-big.gif

nginx-perl/index.html: \
		$(DEPS) \
		nginx-perl.in/index.html
	$(HTMLPOSTPROC) Home \
		< nginx-perl.in/index.html \
		> nginx-perl/index.html

nginx-perl/Nginx.html: \
		$(DEPS) \
		nginx-perl/Nginx.html.in
	$(HTMLPOSTPROC) Nginx \
		< nginx-perl/Nginx.html.in \
		> nginx-perl/Nginx.html

nginx-perl/Nginx/Test.html: \
		$(DEPS) \
		nginx-perl/Nginx/Test.html.in
	$(HTMLPOSTPROC) Nginx::Test ../ \
		< nginx-perl/Nginx/Test.html.in \
		> nginx-perl/Nginx/Test.html

nginx-perl/Nginx/Util.html: \
		$(DEPS) \
		nginx-perl/Nginx/Util.html.in
	$(HTMLPOSTPROC) Nginx::Util ../ \
		< nginx-perl/Nginx/Util.html.in \
		> nginx-perl/Nginx/Util.html

nginx-perl/Nginx/Redis.html: \
		$(DEPS) \
		nginx-perl/Nginx/Redis.html.in
	$(HTMLPOSTPROC) Nginx::Redis ../ \
		< nginx-perl/Nginx/Redis.html.in \
		> nginx-perl/Nginx/Redis.html

nginx-perl/Nginx/HTTP.html: \
		$(DEPS) \
		nginx-perl/Nginx/HTTP.html.in
	$(HTMLPOSTPROC) Nginx::HTTP ../ \
		< nginx-perl/Nginx/HTTP.html.in \
		> nginx-perl/Nginx/HTTP.html

nginx-perl/Redis/Parser/XS.html: \
		$(DEPS) \
		nginx-perl/Redis/Parser/XS.html.in
	$(HTMLPOSTPROC) Redis::Parser::XS ../../ \
		< nginx-perl/Redis/Parser/XS.html.in \
		> nginx-perl/Redis/Parser/XS.html

nginx-perl/HTTP/Parser2/XS.html: \
		$(DEPS) \
		nginx-perl/HTTP/Parser2/XS.html.in
	$(HTMLPOSTPROC) Redis::Parser::XS ../../ \
		< nginx-perl/HTTP/Parser2/XS.html.in \
		> nginx-perl/HTTP/Parser2/XS.html

nginx-perl/Nginx/Perl.html: \
		$(DEPS) \
		nginx-perl/Nginx/Perl.html.in
	$(HTMLPOSTPROC) Nginx::Perl ../ \
		< nginx-perl/Nginx/Perl.html.in \
		> nginx-perl/Nginx/Perl.html

nginx-perl/Nginx.html.in: \
		$(DEPS) \
		$(NGINXPERL)/src/http/modules/perl/Nginx.pm
	$(POD2XHTML) \
		< $(NGINXPERL)/src/http/modules/perl/Nginx.pm \
		> nginx-perl/Nginx.html.in

nginx-perl/Nginx/Test.html.in: \
		$(DEPS) \
		nginx-perl/Nginx/.exists \
	$(NGINXPERL)/src/http/modules/perl/Test.pm
	$(POD2XHTML) \
		< $(NGINXPERL)/src/http/modules/perl/Test.pm \
		> nginx-perl/Nginx/Test.html.in

nginx-perl/Nginx/Util.html.in: \
		$(DEPS) \
		nginx-perl/Nginx/.exists \
	$(NGINXPERL)/src/http/modules/perl/Util.pm
	$(POD2XHTML) \
		< $(NGINXPERL)/src/http/modules/perl/Util.pm \
		> nginx-perl/Nginx/Util.html.in

nginx-perl/Nginx/Redis.html.in: \
		$(DEPS) \
		nginx-perl/Nginx/.exists \
		../Nginx-Redis/lib/Nginx/Redis.pm
	$(POD2XHTML) \
		< ../Nginx-Redis/lib/Nginx/Redis.pm \
		> nginx-perl/Nginx/Redis.html.in

nginx-perl/Nginx/HTTP.html.in: \
		$(DEPS) \
		nginx-perl/Nginx/.exists \
		../Nginx-HTTP/lib/Nginx/HTTP.pm
	$(POD2XHTML) \
		< ../Nginx-HTTP/lib/Nginx/HTTP.pm \
		> nginx-perl/Nginx/HTTP.html.in

nginx-perl/Redis/Parser/XS.html.in: \
		$(DEPS) \
		nginx-perl/Redis/Parser/.exists \
		../Redis-Parser-XS/lib/Redis/Parser/XS.pm
	$(POD2XHTML) \
		< ../Redis-Parser-XS/lib/Redis/Parser/XS.pm \
		> nginx-perl/Redis/Parser/XS.html.in

nginx-perl/HTTP/Parser2/XS.html.in: \
		$(DEPS) \
		nginx-perl/HTTP/Parser2/.exists \
		../HTTP-Parser2-XS/lib/HTTP/Parser2/XS.pm
	$(POD2XHTML) \
		< ../HTTP-Parser2-XS/lib/HTTP/Parser2/XS.pm \
		> nginx-perl/HTTP/Parser2/XS.html.in

nginx-perl/Nginx/Perl.html.in: \
		$(DEPS) \
		nginx-perl/Nginx/.exists \
	$(NGINXPERL)/src/http/modules/perl/Perl.pm
	$(POD2XHTML) \
		< $(NGINXPERL)/src/http/modules/perl/Perl.pm \
		> nginx-perl/Nginx/Perl.html.in

nginx-perl/Redis/Parser/.exists: \
		$(DEPS)
	mkdir -p nginx-perl/Redis/Parser
	touch nginx-perl/Redis/Parser/.exists

nginx-perl/HTTP/Parser2/.exists: \
		$(DEPS)
	mkdir -p nginx-perl/HTTP/Parser2
	touch nginx-perl/HTTP/Parser2/.exists

nginx-perl/Nginx/.exists: \
		$(DEPS)
	mkdir -p nginx-perl/Nginx
	touch nginx-perl/Nginx/.exists

nginx-perl/.exists:
	mkdir -p nginx-perl
	touch nginx-perl/.exists

clean:
	rm -rf nginx-perl/

