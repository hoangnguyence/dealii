#####
##
## Copyright (C) 2012 by the deal.II authors
##
## This file is part of the deal.II library.
##
## <TODO: Full License information>
## This file is dual licensed under QPL 1.0 and LGPL 2.1 or any later
## version of the LGPL license.
##
## Author: Matthias Maier <matthias.maier@iwr.uni-heidelberg.de>
##
#####

#
# This file implements the DEAL_II_INITIALIZE_VARIABLES macro, which is
# part of the deal.II library.
#
# Usage:
#       DEAL_II_INITIALIZE_CACHED_VARIABLES()
#
# This sets some cached variables to the values used for compiling the
# deal.II library.
#
# This macro has to be called before PROJECT()!
#

MACRO(DEAL_II_INITIALIZE_CACHED_VARIABLES)

  IF(NOT DEAL_II_PROJECT_CONFIG_INCLUDED)
    MESSAGE(FATAL_ERROR
      "\nDEAL_II_INITIALIZE_CACHED_VARIABLES can only be called in external "
      "projects after the inclusion of deal.IIConfig.cmake. It is not "
      "intended for internal use.\n\n"
      )
  ENDIF()

  #
  # Set build type according to available libraries
  #
  IF(DEAL_II_BUILD_TYPE MATCHES "Debug")
    SET(CMAKE_BUILD_TYPE "Debug" CACHE STRING
      "Choose the type of build, options are: Debug, Release"
      )
  ELSE()
    SET(CMAKE_BUILD_TYPE "Release" CACHE STRING
      "Choose the type of build, options are: Debug, Release"
      )
  ENDIF()

  #
  # Bail out if build type is unknown...
  #
  IF( NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release" AND
      NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Debug" )
    MESSAGE(FATAL_ERROR
      "\nCMAKE_BUILD_TYPE does neither match Release nor Debug!\n\n"
      )
  ENDIF()
  #
  # ... or unsupported
  #
  IF(NOT DEAL_II_BUILD_TYPE MATCHES "${CMAKE_BUILD_TYPE}")
    MESSAGE(FATAL_ERROR "\n"
      "CMAKE_BUILD_TYPE \"${CMAKE_BUILD_TYPE}\" unsupported by current installation!\n"
      "deal.II was build with \"${DEAL_II_BUILD_TYPE}\" only build type.\n\n"
      )
  ENDIF()

  SET(CMAKE_CXX_COMPILER ${DEAL_II_CXX_COMPILER} CACHE STRING
    "CXX Compiler.")

  SET(CMAKE_CXX_FLAGS ${DEAL_II_CXX_FLAGS} CACHE STRING
    "Flags used by the compiler during all build types."
    )

  SET(CMAKE_CXX_FLAGS_DEBUG ${DEAL_II_CXX_FLAGS_DEBUG} CACHE STRING
    "Flags used by the compiler during debug builds."
    )

  SET(CMAKE_CXX_FLAGS_RELEASE ${DEAL_II_CXX_FLAGS_RELEASE} CACHE STRING
    "Flags used by the compiler during release builds."
    )

  MARK_AS_ADVANCED(CMAKE_INSTALL_PREFIX)

ENDMACRO()

