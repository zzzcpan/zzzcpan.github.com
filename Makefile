
NGINXPERL = ../nginx-perl
POD2XHTML = pod2xhtml --toplink 0
HTMLPOSTPROC = perl htmlpostproc.pl
DEPS = Makefile \
	htmlpostproc.pl \
	nginx-perl/.exists

web: \
	nginx-perl/pod.css \
	nginx-perl/index.css \
	nginx-perl/index.html \
	nginx-perl/Nginx.html \
	nginx-perl/Nginx/Util.html \
	nginx-perl/Nginx/Redis.html

nginx-perl/pod.css: \
		$(DEPS) \
		nginx-perl-pod.css
	cp nginx-perl-pod.css nginx-perl/pod.css

nginx-perl/index.css: \
		$(DEPS) \
		nginx-perl-index.css
	cp nginx-perl-index.css nginx-perl/index.css

nginx-perl/index.html: \
		$(DEPS) \
		nginx-perl/index.html.in
	$(HTMLPOSTPROC) Home \
		< nginx-perl/index.html.in \
		> nginx-perl/index.html

nginx-perl/Nginx.html: \
		$(DEPS) \
		nginx-perl/Nginx.html.in
	$(HTMLPOSTPROC) Nginx \
		< nginx-perl/Nginx.html.in \
		> nginx-perl/Nginx.html

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

nginx-perl/index.html.in: \
		$(DEPS) \
		nginx-perl-index.pod
	$(POD2XHTML) --noindex --css index.css \
		< nginx-perl-index.pod \
		> nginx-perl/index.html.in

nginx-perl/Nginx.html.in: \
		$(DEPS) \
		$(NGINXPERL)/src/http/modules/perl/Nginx.pm
	$(POD2XHTML) --css pod.css \
		< $(NGINXPERL)/src/http/modules/perl/Nginx.pm \
		> nginx-perl/Nginx.html.in

nginx-perl/Nginx/Util.html.in: \
		$(DEPS) \
		nginx-perl/Nginx/.exists \
	$(NGINXPERL)/src/http/modules/perl/Util.pm
	$(POD2XHTML) --css ../pod.css \
		< $(NGINXPERL)/src/http/modules/perl/Util.pm \
		> nginx-perl/Nginx/Util.html.in

nginx-perl/Nginx/Redis.html.in: \
		$(DEPS) \
		nginx-perl/Nginx/.exists \
	$(NGINXPERL)/src/http/modules/perl/Redis.pm
	$(POD2XHTML) --css ../pod.css \
		< $(NGINXPERL)/src/http/modules/perl/Redis.pm \
		> nginx-perl/Nginx/Redis.html.in

nginx-perl/Nginx/.exists: \
		$(DEPS)
	mkdir -p nginx-perl/Nginx
	touch nginx-perl/Nginx/.exists

nginx-perl/.exists:
	mkdir -p nginx-perl
	touch nginx-perl/.exists

clean:
	rm -rf nginx-perl/

