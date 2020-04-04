#-------------------------------------------------
#
# Project created by QtCreator 2014-09-27T04:27:25
#
#-------------------------------------------------
# * ***********************************************************************
# * Andama
# * (C) 2014-2018 by Yiannis Bourkelis (hello@andama.org)
# *
# * This file is part of Andama.
# *
# * Andama is free software: you can redistribute it and/or modify
# * it under the terms of the GNU General Public License as published by
# * the Free Software Foundation, either version 3 of the License, or
# * (at your option) any later version.
# *
# * Andama is distributed in the hope that it will be useful,
# * but WITHOUT ANY WARRANTY; without even the implied warranty of
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# * GNU General Public License for more details.
# *
# * You should have received a copy of the GNU General Public License
# * along with Andama.  If not, see <http://www.gnu.org/licenses/>.
# * ***********************************************************************/

#QMAKE_MAC_SDK = macosx10.12

include(mousekeyb/mousekeyb.pri)

        QT += core gui quick
windows:QT += winextras
#linux:QMAKE_CXXFLAGS += -g -O0 #an thelw na kanw debugging se linux, kataxwrei etsi debug symbols

CONFIG += c++11
#CONFIG += qt debug #debug symbols. na to vgazw opote den to xreiazomai

linux:CONFIG += static
# ./configure -static -prefix /home/yiannis/Qt5.3.2-src -qt-xcb
# make
# make install
#linux

# disable all the deprecated APIs in Qt <= 5.7
        DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x050700
windows:DEFINES += NOMINMAX

mac:QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.9 #xreiazetai gia na ypostirizetai to std::async kai std::future
mac:QMAKE_LFLAGS += -F /System/Library/Frameworks/CoreFoundation.framework/
mac:LIBS += -framework CoreFoundation
mac:LIBS += -framework ApplicationServices
mac:LIBS += -framework IOKit #xreiazetai gia na ksypnaei to monitor

#@--gia na ginei compile se ubuntu 14 x64 prepei na orisw ta paths tis opengl gia kapoio logo
#linux:QMAKE_LIBS_OPENGL     = /usr/lib/x86_64-linux-gnu/mesa/libGL.so.1
#linux:QMAKE_LIBS_OPENGL_QT  = /usr/lib/x86_64-linux-gnu/mesa/libGL.so.1
#se CENTOS x64 to path einai /usr/lib64/libGL.so.1

#se windows build me minGW xreiazetai na prosthetw tis vivliothikes
win32-g++ {
LIBS += -lgdi32
LIBS += -lws2_32
}

#QMAKE_MAC_SDK = macosx10.11

#na ginetai comment afti i grammi an thelw na to treksw mesa apo ton QT Creator
#release:QMAKE_LFLAGS_WINDOWS += /MANIFESTUAC:\"level=\'asInvoker\' uiAccess=\'true\'\"
#LINK=/SUBSYSTEM:WINDOWS,5.01

linux:LIBS += -lXtst -lX11
#for raspbian linux use the LIBS with the -ldl if build fails
#linux:LIBS += -lXtst -lX11 -ldl
windows:LIBS += -luser32
windows:LIBS += -lgdi32

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT

TARGET = Andama
TEMPLATE = app
VERSION = 0.2.0

DEFINES += APP_NAME=\\\"$$TARGET\\\"
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
#mac:DEFINES += APP_MAC

SOURCES += main.cpp\
    clientserver.cpp \
    mainwindow.cpp \
    screenshotsworker.cpp \
    helperfuncs.cpp \
    keepalive.cpp \
    PasswordProtection.cpp \
    About.cpp \
    engine.cpp \
    screenshotprovider.cpp \
    p2pserver.cpp \
    clientsocket.cpp \
    clientserverprotocol.cpp \
    serversocket.cpp \
    protocolsupervisor.cpp \
    tbllogmodel.cpp \
    tbllogsortfilterproxymodel.cpp \
    tbllogdata.cpp \
    ../Shared/AndamaHeaders/byte_functions.cpp \
    ../Shared/AndamaHeaders/exception_helper.cpp \
    ../Shared/AndamaHeaders/socket_functions.cpp \
    ../Shared/Cryptography/openssl_aes.cpp \
    ../Shared/General/bench.cpp \
    ../Shared/UPnP/addportmappingresponse.cpp \
    ../Shared/UPnP/deviceresponse.cpp \
    ../Shared/UPnP/upnpaddportmapping.cpp \
    ../Shared/UPnP/upnpdiscovery.cpp \
    ../Shared/UPnP/upnpengine.cpp

HEADERS  += clientserver.h \
    mainwindow.h \
    screenshotsworker.h \
    helperfuncs.h \
    keepalive.h \
    PasswordProtection.h \
    About.h \
    engine.h \
    screenshotprovider.h \
    p2pserver.h \
    clientsocket.h \
    clientserverprotocol.h \
    serversocket.h \
    protocolsupervisor.h \
    tbllogmodel.h \
    tbllogsortfilterproxymodel.h \
    tbllogdata.h \
    imageconfig.h \
    ../Shared/AndamaHeaders/byte_functions.h \
    ../Shared/AndamaHeaders/exception_helper.h \
    ../Shared/AndamaHeaders/finally.h \
    ../Shared/AndamaHeaders/shared_constants.h \
    ../Shared/AndamaHeaders/shared_enums.h \
    ../Shared/AndamaHeaders/socket_functions.h \
    ../Shared/Cryptography/openssl_aes.h \
    ../Shared/Cryptography/openssl_zalocator.h \
    ../Shared/General/bench.h \
    ../Shared/General/finally.h \
    ../Shared/UPnP/addportmappingresponse.h \
    ../Shared/UPnP/deviceresponse.h \
    ../Shared/UPnP/upnpaddportmapping.h \
    ../Shared/UPnP/upnpdiscovery.h \
    ../Shared/UPnP/upnpengine.h

FORMS    += mainwindow.ui \
    About.ui

RESOURCES += \
    resources.qrc

OTHER_FILES +=


#on mac you should set DYLD_LIBRARY_PATH for the OSXObjectiveCBridge build folder like: DYLD_LIBRARY_PATH = /Users/your user name/Projects/AndamaRemoteDesktop/Builds/OSXObjectiveCBridge/Debug  (on Projects > Run > Run Environment)
macx: LIBS += -L$$PWD/../OSXObjectiveCBridge/OSXReleaseBuild/ -lOSXObjectiveCBridge
INCLUDEPATH += $$PWD/../OSXObjectiveCBridge
DEPENDPATH += $$PWD/../OSXObjectiveCBridge

#***************************************************************
#openssl library

# osx compile guide:
# (https://gist.github.com/tmiz/1441111)
# open a terminal window in OpenSSL-x.x folder
# osx build commands:
# ./Configure darwin64-x86_64-cc -shared
# make clean
# make
macx:LIBS += -L$$PWD/../OpenSSL-1.1.0g/ -lcrypto
macx:INCLUDEPATH += $$PWD/../OpenSSL-1.1.0g/include/

# windows compile guide:
# install activeperl - https://www.activestate.com/activeperl
# install nasm - http://www.nasm.us/
# go inside OpenSSL-x.x folder from visual studio 2010 command line prompt
# type :
# 1)    perl.exe Configure VC-WIN32
# 2)    nmake clean
# 3)    nmake
# this should compile openssl on windows
windows:LIBS += -L$$PWD/../OpenSSL-1.1.0g/ -llibcrypto
windows:INCLUDEPATH += $$PWD/../OpenSSL-1.1.0g/include/

# linux compile guide:
# go inside OpenSSL-x.x folder using the terminal
# type:
# 1)    ./config
# 2)    make clean
# 3)    make
# this should compile openssl on linux
linux:LIBS += -L$$PWD/../OpenSSL-1.1.0g -lcrypto
linux:INCLUDEPATH += $$PWD/../OpenSSL-1.1.0g/include
#***************************************************************

DISTFILES += \
    main.qml

# TRANSLATION GUIDE
# http://www.andama.org/translation-guide
#
# When a translation is complete e.g. we have a new Andama_it.ts file, we should create
# a .qm file for the translation by running:
# /Users/yiannis/Qt.3.0.2/5.10.0/clang_64/bin/lrelease Andama_it.ts  Andama.pro
# (We should open a terminal window inside the folder where Andama.pro recides)
# Then we should import the generated Andama_it.qm file inside the Resources/resources.qrc/ from
# Qt Creator, by right clicking on "/" (Resources folder), > Add existing files.
# Then we rebuild the project.
# To test the translation we can uncomment the related line inside the void loadTranslator(QApplication *a,  QTranslator *translator)
