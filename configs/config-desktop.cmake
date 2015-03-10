############################################################################
# config-desktop.cmake
# Copyright (C) 2014  Belledonne Communications, Grenoble France
#
############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
############################################################################

# Define default values for the linphone builder options
set(DEFAULT_VALUE_ENABLE_VIDEO ON)
set(DEFAULT_VALUE_ENABLE_GPL_THIRD_PARTIES ON)
set(DEFAULT_VALUE_ENABLE_FFMPEG ON)
set(DEFAULT_VALUE_ENABLE_ZRTP ON)
set(DEFAULT_VALUE_ENABLE_SRTP ON)
set(DEFAULT_VALUE_ENABLE_AMRNB ON)
set(DEFAULT_VALUE_ENABLE_AMRWB ON)
set(DEFAULT_VALUE_ENABLE_G729 ON)
set(DEFAULT_VALUE_ENABLE_GSM ON)
set(DEFAULT_VALUE_ENABLE_ILBC ON)
set(DEFAULT_VALUE_ENABLE_ISAC ON)
set(DEFAULT_VALUE_ENABLE_OPUS ON)
set(DEFAULT_VALUE_ENABLE_SILK ON)
set(DEFAULT_VALUE_ENABLE_SPEEX ON)
set(DEFAULT_VALUE_ENABLE_WEBRTC_AEC OFF)
set(DEFAULT_VALUE_ENABLE_H263 ON)
set(DEFAULT_VALUE_ENABLE_H263P ON)
set(DEFAULT_VALUE_ENABLE_MPEG4 ON)
set(DEFAULT_VALUE_ENABLE_OPENH264 ON)
set(DEFAULT_VALUE_ENABLE_VPX ON)
set(DEFAULT_VALUE_ENABLE_X264 OFF)
set(DEFAULT_VALUE_ENABLE_TUNNEL OFF)
set(DEFAULT_VALUE_ENABLE_UNIT_TESTS ON)


# Global configuration
set(LINPHONE_BUILDER_HOST "")
if(APPLE)
	set(CMAKE_OSX_DEPLOYMENT_TARGET "10.6")
	if(CMAKE_SIZEOF_VOID_P EQUAL 8)
		set(CMAKE_OSX_ARCHITECTURES "x86_64")
		set(LINPHONE_BUILDER_HOST "x86_64-apple-darwin")
	else()
		set(CMAKE_OSX_ARCHITECTURES "i386")
		set(LINPHONE_BUILDER_HOST "i686-apple-darwin")
	endif()
	set(LINPHONE_BUILDER_CPPFLAGS "-mmacosx-version-min=${CMAKE_OSX_DEPLOYMENT_TARGET} -arch ${CMAKE_OSX_ARCHITECTURES}")
	set(LINPHONE_BUILDER_OBJCFLAGS "-mmacosx-version-min=${CMAKE_OSX_DEPLOYMENT_TARGET} -arch ${CMAKE_OSX_ARCHITECTURES}")
	set(LINPHONE_BUILDER_LDFLAGS "-mmacosx-version-min=${CMAKE_OSX_DEPLOYMENT_TARGET} -arch ${CMAKE_OSX_ARCHITECTURES}")
	set(CMAKE_MACOSX_RPATH 1)
endif()
if(WIN32)
	set(LINPHONE_BUILDER_CPPFLAGS "-D_WIN32_WINNT=0x0501 -D_ALLOW_KEYWORD_MACROS")
endif()

# Adjust PKG_CONFIG_PATH to include install directory
if(UNIX)
	set(LINPHONE_BUILDER_PKG_CONFIG_PATH "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/:$ENV{PKG_CONFIG_PATH}:/usr/lib/pkgconfig/:/usr/lib/x86_64-linux-gnu/pkgconfig/:/usr/share/pkgconfig/:/usr/local/lib/pkgconfig/:/opt/local/lib/pkgconfig/")
else() # Windows
	set(LINPHONE_BUILDER_PKG_CONFIG_PATH "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/")
endif()


list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" _IS_SYSTEM_DIR)
if("${_IS_SYSTEM_DIR}" STREQUAL "-1")
   set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
endif()


# Include builders
include(builders/CMakeLists.txt)

# linphone
if(WIN32)
	list(APPEND EP_linphone_CMAKE_OPTIONS "-DENABLE_RELATIVE_PREFIX=YES")
endif()

# sqlite3
if(WIN32)
	set(EP_sqlite3_LINKING_TYPE "-DENABLE_STATIC=YES")
endif()

# vpx
if(WIN32)
	set(EP_vpx_LINKING_TYPE "--enable-static" "--disable-shared" "--enable-pic")
endif()


# Create a shortcut to linphone.exe in install prefix
if(WIN32)
	set(SHORTCUT_PATH "${CMAKE_INSTALL_PREFIX}/linphone.lnk")
	set(SHORTCUT_TARGET_PATH "${CMAKE_INSTALL_PREFIX}/bin/linphone.exe")
	set(SHORTCUT_WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}")
	configure_file("${CMAKE_CURRENT_SOURCE_DIR}/configs/desktop/winshortcut.vbs.in" "${CMAKE_CURRENT_BINARY_DIR}/winshortcut.vbs" @ONLY)
	add_custom_command(OUTPUT "${SHORTCUT_PATH}"
		COMMAND "cscript" "${CMAKE_CURRENT_BINARY_DIR}/winshortcut.vbs"
	)
	add_custom_target(linphone_winshortcut ALL DEPENDS "${SHORTCUT_PATH}" TARGET_linphone)
endif()
