From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 7/8] tools/thermal: tmon: use pkg-config to determine library dependencies
Date: Tue, 17 Feb 2015 18:18:35 -0800
Message-ID: <1424225916-13488-8-git-send-email-computersforpeace@gmail.com>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Brian Norris <computersforpeace@gmail.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Some distros (e.g., Arch Linux) don't package the tinfo library
separately from ncurses, so don't unconditionally include it. Instead,
use pkg-config.

The $(STATIC) ugliness is to handle the reported build case from commit
6b533269fb25 ("tools/thermal: tmon: fix compilation errors when building
statically"), where a developer wants to be able to build with:

  make LDFLAGS=-static

which requires an additional pkg-config flag.

Finally, support a lowest common denominator fallback (-lpanel
-lncurses) for build systems that don't have pkg-config entries for
ncurses.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 tools/thermal/tmon/Makefile | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 13d1876c7889..0788621c8d76 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -16,12 +16,21 @@ INSTALL_CONFIGFILE=install -m 644 -p
 CONFIG_FILE=
 CONFIG_PATH=
 
+# Static builds might require -ltinfo, for instance
+ifneq ($(findstring -static, $(LDFLAGS)),)
+STATIC := --static
+endif
+
+TMON_LIBS=-lm -lpthread
+TMON_LIBS += $(shell pkg-config --libs $(STATIC) panelw ncursesw 2> /dev/null || \
+		     pkg-config --libs $(STATIC) panel ncurses 2> /dev/null || \
+		     echo -lpanel -lncurses)
 
 OBJS = tmon.o tui.o sysfs.o pid.o
 OBJS +=
 
 tmon: $(OBJS) Makefile tmon.h
-	$(CC) ${CFLAGS} $(LDFLAGS) $(OBJS)  -o $(TARGET) -lm -lpanel -lncursesw -ltinfo -lpthread
+	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS)  -o $(TARGET) $(TMON_LIBS)
 
 valgrind: tmon
 	 sudo valgrind -v --track-origins=yes --tool=memcheck --leak-check=yes --show-reachable=yes --num-callers=20 --track-fds=yes ./$(TARGET)  1> /dev/null
-- 
1.9.1
