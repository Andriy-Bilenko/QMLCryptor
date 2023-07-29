QT += quick widgets core


# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
-DANDROID_NDK:PATH=/home/kali/Desktop/SDK1/ndk/25.1.8937393
#ANDROID_NDK_ROOT = /home/kali/Desktop/SDK1/ndk/25.1.8937393/
-DANDROID_SDK_ROOT:PATH=/home/kali/Desktop/SDK1
#ANDROID_SDK_ROOT = /home/kali/Desktop/SDK1/


SOURCES += \
    filecryptor.cpp \
    main.cpp \

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    filecryptor.hpp
