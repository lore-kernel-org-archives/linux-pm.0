From: "Javi Merino" <javi.merino@arm.com>
Subject: [PATCH] tools/thermal: tmon: fix compilation errors when building statically
Date: Mon,  2 Jun 2014 18:08:17 +0100
Message-ID: <1401728897-25188-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33767 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbaFBRIm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 13:08:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>

tmon fails to build statically with the following error:

$ make LDFLAGS=3D-static
gcc -O1 -Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplic=
it-int -fstack-protector -D VERSION=3D\"1.0\" -static tmon.o tui.o sysfs.o =
pid.o   -o tmon -lm -lpanel -lncursesw  -lpthread
tmon.o: In function `tmon_sig_handler':
tmon.c:(.text+0x21): undefined reference to `stdscr'
tmon.o: In function `tmon_cleanup':
tmon.c:(.text+0xb9): undefined reference to `stdscr'
tmon.c:(.text+0x11e): undefined reference to `stdscr'
tmon.c:(.text+0x123): undefined reference to `keypad'
tmon.c:(.text+0x12d): undefined reference to `nocbreak'
tmon.o: In function `main':
tmon.c:(.text+0x785): undefined reference to `stdscr'
tmon.c:(.text+0x78a): undefined reference to `nodelay'
tui.o: In function `setup_windows':
tui.c:(.text+0x131): undefined reference to `stdscr'
tui.c:(.text+0x176): undefined reference to `stdscr'
tui.c:(.text+0x19f): undefined reference to `stdscr'
tui.c:(.text+0x1cc): undefined reference to `stdscr'
tui.c:(.text+0x1ff): undefined reference to `stdscr'
tui.o:tui.c:(.text+0x229): more undefined references to `stdscr' follow
tui.o: In function `show_cooling_device':
[...]

stdscr() and friends are in libtinfo (part of ncurses) so add it to
the libraries that are linked in when compiling tmon to fix it.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 tools/thermal/tmon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 447321104ec0..e775adcbd29f 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -21,7 +21,7 @@ OBJS =3D tmon.o tui.o sysfs.o pid.o
 OBJS +=3D
=20
 tmon: $(OBJS) Makefile tmon.h
-=09$(CC) ${CFLAGS} $(LDFLAGS) $(OBJS)  -o $(TARGET) -lm -lpanel -lncursesw=
  -lpthread
+=09$(CC) ${CFLAGS} $(LDFLAGS) $(OBJS)  -o $(TARGET) -lm -lpanel -lncursesw=
 -ltinfo -lpthread
=20
 valgrind: tmon
 =09 sudo valgrind -v --track-origins=3Dyes --tool=3Dmemcheck --leak-check=
=3Dyes --show-reachable=3Dyes --num-callers=3D20 --track-fds=3Dyes ./$(TARG=
ET)  1> /dev/null
--=20
1.9.1


