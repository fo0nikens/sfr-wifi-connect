.PHONY: all install uninstall link unlink

INSTALL_PATH?=/usr/local

MAIN=sfr-wifi-connect

all:
	@echo "Usage: make install / uninstall / link / unlink"

install:
	cp ./bin/${MAIN} ${INSTALL_PATH}/bin/

uninstall:
	rm ${INSTALL_PATH}/bin/${MAIN}

link:
	ln -s $$(pwd)/bin/${MAIN} ${INSTALL_PATH}/bin/

unlink:
	rm ${INSTALL_PATH}/bin/${MAIN}

