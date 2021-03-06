RM = rm -rf
CONFIG_SCRIPT = tools/configure.py
TARGET = build
CSSLINTFLAGS = --quiet --errors=empty-rules,import,errors --warnings=duplicate-background-images,compatible-vendor-prefixes,display-property-grouping,fallback-colors,duplicate-properties,shorthand,gradients,font-sizes,floats,overqualified-elements,import,regex-selectors,rules-count,unqualified-attributes,vendor-prefix,zero-units
MINIMIZE = java -jar tools/yuicompressor-2.4.7.jar --nomunge

.PHONY: all clean min testX

all: testX

clean:
	- $(RM) *~
	- $(RM) Books
	@# Remove minified JS and CSS files
	- $(RM) lib/*-min.*
	- $(RM) Doc/*~
	- $(RM) Scripts/*~
	- $(RM) config/*~

min: nomin

testX: min
	python $(CONFIG_SCRIPT) config/testX.json

allBooks: testX

nomin:
	@cp JSAV/build/JSAV.js JSAV/build/JSAV-min.js
	@cp lib/odsaUtils.js lib/odsaUtils-min.js
	@cp lib/odsaMOD.js lib/odsaMOD-min.js
	@cp lib/odsaAV.js lib/odsaAV-min.js
	@cp lib/gradebook.js lib/gradebook-min.js
	@cp ODSAkhan-exercises/khan-exercise.js lib/khan-exercise-min.js
	@cp lib/registerbook.js lib/registerbook-min.js
	@cp lib/site.css lib/site-min.css
	@cat lib/normalize.css lib/odsaAV.css > lib/odsaAV-min.css
	@cp lib/odsaMOD.css lib/odsaMOD-min.css
	@cp lib/odsaStyle.css lib/odsaStyle-min.css
	@cp lib/gradebook.css lib/gradebook-min.css

pull:
	git pull
	git submodule update
	make -s -C JSAV
	make -s min
	cd Doc; make

pullx: pull
	make testX
	@cp -fr /home/OpenDSAX/AV /home/OpenDSAX/xblocks/xblock-module/module/public/
	@cp -fr /home/OpenDSAX/JSAV /home/OpenDSAX/xblocks/xblock-module/module/public/
	@cp -fr /home/OpenDSAX/lib /home/OpenDSAX/xblocks/xblock-module/module/public/
	@cp -fr /home/OpenDSAX/Books/testX/html/_static /home/OpenDSAX/xblocks/xblock-module/module/public/
	@cp -fr /home/OpenDSAX/AV /home/OpenDSAX/xblocks/xblock-jsav/jsav/public/
	@cp -fr /home/OpenDSAX/JSAV /home/OpenDSAX/xblocks/xblock-jsav/jsav/public/
	@cp -fr /home/OpenDSAX/lib /home/OpenDSAX/xblocks/xblock-jsav/jsav/public/
	@cp -fr /home/OpenDSAX/Books/testX/html/_static /home/OpenDSAX/xblocks/xblock-jsav/jsav/public/
	@cp -fr /home/OpenDSAX/Books/testX/html /home/OpenDSAX/xblocks/xblock-content/content/public/

restart-edxapp:
	sudo /edx/bin/supervisorctl -c /edx/etc/supervisord.conf restart edxapp:
	
install-utils: xblock-utils restart-edxapp

install-jsav: xblock-jsav restart-edxapp

install-testjsav: xblock-testjsav restart-edxapp

install-module: xblock-module restart-edxapp

install-content: xblock-content restart-edxapp

install-all: xblock-utils xblock-jsav xblock-testjsav xblock-module xblock-content restart-edxapp

xblock-utils: 
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/xblockutils
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/xblock_utils-0.1a0-py2.7.egg-info
	cd /edx/app/edxapp
	sudo -H -u edxapp /edx/bin/pip.edxapp install /home/OpenDSAX/xblocks/xblock-utils/

xblock-jsav: 
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/jsav
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/xblock_jsav-0.3-py2.7.egg-info
	cd /edx/app/edxapp
	sudo -H -u edxapp /edx/bin/pip.edxapp install /home/OpenDSAX/xblocks/xblock-jsav/

xblock-testjsav: 
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/testjsav
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/testjsav_xblock-0.1-py2.7.egg-info
	cd /edx/app/edxapp
	sudo -H -u edxapp /edx/bin/pip.edxapp install /home/OpenDSAX/xblocks/xblock-testjsav/

xblock-module: 
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/module
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/module_xblock-0.1-py2.7.egg-info
	cd /edx/app/edxapp
	sudo -H -u edxapp /edx/bin/pip.edxapp install /home/OpenDSAX/xblocks/xblock-module/

xblock-content: 
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/content
	rm -r /edx/app/edxapp/venvs/edxapp/lib/python2.7/site-packages/content_xblock-0.1-py2.7.egg-info
	cd /edx/app/edxapp
	sudo -H -u edxapp /edx/bin/pip.edxapp install /home/OpenDSAX/xblocks/xblock-content/