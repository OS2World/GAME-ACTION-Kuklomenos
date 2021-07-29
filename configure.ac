#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.62)
AC_INIT(kuklomenos, 0.4.5)
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR([invaders.cc])

AC_CANONICAL_HOST

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_RANLIB

# Checks for libraries.
AC_CHECK_LIB([SDL], [SDL_Init],,AC_MSG_ERROR(Requires SDL))
AC_CHECK_LIB([curl], [curl_global_init],,nocurl=1)

AM_CONDITIONAL(HAVE_CURL, test x$nocurl != x1)

# Copied from SDL_mixer's configure.in:
AC_ARG_ENABLE([sound],
AC_HELP_STRING([--enable-sound], [enable sound [[default=yes]]]),
              [], [enable_sound=yes])
AC_ARG_ENABLE(sound-ogg-tremor,
[  --enable-sound-ogg-tremor   enable OGG sound via libtremor [[default=no]]],
              [], enable_sound_ogg_tremor=no)
AC_ARG_ENABLE([sound-ogg-shared],
AC_HELP_STRING([--enable-sound-ogg-shared], [dynamically load Ogg Vorbis support [[default=yes]]]),
              [], [enable_sound_ogg_shared=yes])
find_lib()
{
    gcc_bin_path=[`$CC -print-search-dirs 2>/dev/null | fgrep programs: | sed 's/[^=]*=\(.*\)/\1/' | sed 's/:/ /g'`]
    gcc_lib_path=[`$CC -print-search-dirs 2>/dev/null | fgrep libraries: | sed 's/[^=]*=\(.*\)/\1/' | sed 's/:/ /g'`]
    env_lib_path=[`echo $LIBS $LDFLAGS | sed 's/-L[ ]*//g'`]
    for path in $gcc_bin_path $gcc_lib_path $env_lib_path /usr/lib /usr/local/lib; do
        lib=[`ls -- $path/$1 2>/dev/null | sort -r | sed 's/.*\/\(.*\)/\1/; q'`]
        if test x$lib != x; then
            echo $lib
            return
        fi
    done
}
AM_CONDITIONAL(SOUND, test x$enable_sound = xyes)
if test x$enable_sound = xyes; then
    if test x$enable_sound_ogg_tremor = xyes; then
        AC_CHECK_HEADER([tremor/ivorbisfile.h], [have_tremor_hdr=yes])
        AC_CHECK_LIB([vorbisidec], [ov_open_callbacks], [have_tremor_lib=yes])
        if test x$have_tremor_hdr = xyes -a x$have_tremor_lib = xyes; then
            case "$host" in
                *-*-darwin*)
                    ogg_lib=[`find_lib libvorbisidec*.dylib`]
                    if test x$ogg_lib = x; then
                        ogg_lib=[`find_lib libvorbisidec.[0-9]`]
                    fi
                    if test x$ogg_lib = x; then
                        ogg_lib=[`find_lib libvorbisidec.[0-9]*`]
                    fi
                    ;;
                *-*-cygwin* | *-*-mingw32*)
                    ogg_lib=[`find_lib "vorbisidec*.dll"`]
                    ;;
                *)
                    ogg_lib=[`find_lib "libvorbisidec.so.[0-9]"`]
                    if test x$ogg_lib = x; then
                        ogg_lib=[`find_lib "libvorbisidec.so.[0-9]*"`]
                    fi
                    ;;
            esac
            MIXER_CFLAGS="$MIXER_CFLAGS -DOGG_SOUND -DOGG_USE_TREMOR"
            if test x$enable_sound_ogg_shared = xyes && test x$ogg_lib != x; then
                echo "-- dynamic libvorbisidec -> $ogg_lib"
                MIXER_CFLAGS="$MIXER_CFLAGS -DOGG_DYNAMIC=\\\"$ogg_lib\\\""
            else
                MIXER_LDFLAGS="$MIXER_LDFLAGS -lvorbisidec"
            fi
        fi
    else
        AC_CHECK_HEADER([vorbis/vorbisfile.h], [have_ogg_hdr=yes])
        AC_CHECK_LIB([vorbisfile], [ov_open_callbacks], [have_ogg_lib=yes])
        if test x$have_ogg_hdr = xyes -a x$have_ogg_lib = xyes; then
            case "$host" in
                *-*-darwin*)
                    ogg_lib=[`find_lib libvorbisfile*.dylib`]
                    ;;
                *-*-cygwin* | *-*-mingw32*)
                    ogg_lib=[`find_lib "libvorbisfile*.dll"`]
                    ;;
                *)
                    ogg_lib=[`find_lib "libvorbisfile.so.[0-9]"`]
                    if test x$ogg_lib = x; then
                        ogg_lib=[`find_lib "libvorbisfile.so.[0-9]*"`]
                    fi
                    ;;
            esac
            MIXER_CFLAGS="$MIXER_CFLAGS -DOGG_SOUND"
            if test x$enable_sound_ogg_shared = xyes && test x$ogg_lib != x; then
                echo "-- dynamic libvorbisfile -> $ogg_lib"
                MIXER_CFLAGS="$MIXER_CFLAGS -DOGG_DYNAMIC=\\\"$ogg_lib\\\""
            else
                MIXER_LDFLAGS="$MIXER_LDFLAGS -lvorbisfile -lvorbis -logg"
            fi
        fi
    fi
    AC_SUBST(MIXER_LDFLAGS)
    AC_SUBST(MIXER_CFLAGS)
fi
# end from SDL_mixer


# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STDBOOL

# Checks for library functions.
AC_CHECK_FUNCS([atexit floor pow sqrt])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile SDL_mixer/Makefile fonts/Makefile sounds/Makefile])
AC_OUTPUT
