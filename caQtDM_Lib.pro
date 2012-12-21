include (../caQtDM/qtdefs.pri)

unix {
  TEMPLATE = subdirs
  SUBDIRS = caQtDM_Lib1
  exists("/home/ACS/Control/Lib/libDEV.so") {
         SUBDIRS += caQtDM_Lib2
  }
}

win32 {
QT       += core gui

CONFIG      += qt warn_on thread uitools designer plugin

TARGET = caQtDM_Lib
TEMPLATE = lib

MOC_DIR = moc
OBJECTS_DIR = obj


     win32-msvc* {
        DebugBuild {
                EPICS_LIBS=$${EPICS_BASE}/lib/win32-x86
                OBJECTS_DIR = debug/obj
        }
        ReleaseBuild {
                EPICS_LIBS=$${EPICS_BASE}/lib/win32-x86-debug
                OBJECTS_DIR = release/obj
        }
     }


DESTDIR = .
UI_DIR += ./
VPATH += ./src
INCLUDEPATH += ./src


DEFINES += CAQTDM_LIB_LIBRARY

SOURCES += caqtdm_lib.cpp \
    mutexKnobData.cpp \
    globalPtrs.cpp \
    epicsSubs.c \
    dmsearchfile.cpp \
    MessageWindow.cpp \
    vaPrintf.c \
    myMessageBox.cpp \
    limitsStripplotDialog.cpp

HEADERS += caqtdm_lib.h\
        caQtDM_Lib_global.h \
    mutexKnobDataWrapper.h \
    mutexKnobData.h \
    medmpio.h \
    knobDefines.h \
    knobData.h \
    dbrString.h \
    alarmdefs.h \
    dmsearchfile.h \
    MessageWindow.h \
    messageWindowWrapper.h \
    vaPrintf.h \
    myMessageBox.h \
    limitsStripplotDialog.h
    
HEADERS += \
    JSONValue.h \
    JSON.h

SOURCES += \
    JSONValue.cpp \
    JSON.cpp

INCLUDEPATH += $${QWTHOME}/src
INCLUDEPATH += $${QWTHOME}/include
INCLUDEPATH += $${QTCONTROLS_INCLUDES}
INCLUDEPATH += $${EPICS_BASE}/include
INCLUDEPATH += $${EPICS_BASE}/include/os/win32
     win32-g++ {
	LIBS += $${QWTHOME}/lib/libqwt.a
	LIBS += $${QTCONTROLS_LIBS}/libqtcontrols.a
	LIBS += $${EPICS_LIBS}/ca.lib
	LIBS += $${EPICS_LIBS}/COM.lib
     }
     win32-msvc* {
        DEFINES += CAQTDM_LIB_LIBRARY
        DebugBuild {
                LIBS += $${QWTHOME}/lib/qwtd.lib
                LIBS += $${EPICS_LIBS}/ca.lib
                LIBS += $${EPICS_LIBS}/COM.lib
                LIBS += $${QTCONTROLS}/debug/qtcontrols.lib
        }

        ReleaseBuild {
                LIBS += $${QWTHOME}/lib/qwt.lib
                LIBS += $${EPICS_LIBS}/ca.lib
                LIBS += $${EPICS_LIBS}/COM.lib
                LIBS += $${QTCONTROLS}/release/qtcontrols.lib
                QMAKE_POST_LINK = $${QMAKE_COPY} .\\release\\caQtDM_Lib.dll $${BINARY_LOCATION}

        }
     }

}
