############################################################################
# polarssl.cmake
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

set(EP_polarssl_GIT_REPOSITORY "git://git.linphone.org/polarssl.git")
set(EP_polarssl_GIT_TAG_LATEST "linphone-1.4")
set(EP_polarssl_GIT_TAG "68ed1474bf3919248f0b9f52fc582d60d4c2991d")
set(EP_polarssl_EXTERNAL_SOURCE_PATHS "polarssl")

set(EP_polarssl_CMAKE_OPTIONS "-DENABLE_PROGRAMS=0" "-DENABLE_TESTING=0")
set(EP_polarssl_LINKING_TYPE "-DUSE_SHARED_POLARSSL_LIBRARY=1")
if(MSVC)
	set(EP_polarssl_EXTRA_LDFLAGS "/SAFESEH:NO")
endif()
