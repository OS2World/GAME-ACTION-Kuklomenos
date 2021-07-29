bin_PROGRAMS = kuklomenos
kuklomenos_SOURCES = ai.cc background.cc clock.cc collision.cc conffile.cc coords.cc data.cc\
		     geom.cc gfx.cc invaders.cc keybindings.cc main.cc menu.cc node.cc\
		     overlay.cc player.cc random.cc settings.cc shot.cc\
		     sound.cc state.cc SDL_gfxPrimitivesDirty.cc
noinst_HEADERS = ai.h background.h clock.h collision.h conffile.h coords.h data.h geom.h\
		 gfx.h invaders.h keybindings.h menu.h node.h overlay.h player.h random.h\
		 settings.h shot.h sound.h state.h SDL_gfxPrimitivesDirty.h\
		 SDL_gfxPrimitives_font.h
EXTRA_DIST = Mac
AM_CPPFLAGS=
SUBDIRS = fonts

if SOUND
SUBDIRS += SDL_mixer sounds
LDADD = SDL_mixer/libmixer.a
AM_CPPFLAGS += -DSOUND
endif

if HAVE_CURL
kuklomenos_SOURCES += net.cc highScore.cc
noinst_HEADERS += net.h highScore.h
endif


AM_CXXFLAGS = -Wall -pedantic

AM_CPPFLAGS += -DDATADIR=\"$(pkgdatadir)\"

.PHONY: debug profile

debug:
	    $(MAKE) all "CXXFLAGS=-g -DDEBUG"
profile:
	    $(MAKE) all "CXXFLAGS=-pg"
