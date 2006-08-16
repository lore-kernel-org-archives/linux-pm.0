From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/3] PM: Make console suspending
	configureable
Date: Wed, 16 Aug 2006 13:09:34 +0200
Message-ID: <200608161309.34370.rjw@sisk.pl>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz>
	<200608161304.51758.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200608161304.51758.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Change suspend_console() so that it waits for all consoles to flush the
remaining messages and make it possible to switch the console suspending
off with the help of a Kconfig option.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/console.h |    5 +++++
 kernel/power/Kconfig    |   11 +++++++++++
 kernel/printk.c         |    8 ++++++++
 3 files changed, 24 insertions(+)

Index: linux-2.6.18-rc4-mm1/include/linux/console.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.18-rc4-mm1.orig/include/linux/console.h	2006-08-16 11:59:56.0=
00000000 +0200
+++ linux-2.6.18-rc4-mm1/include/linux/console.h	2006-08-16 12:00:01.000000=
000 +0200
@@ -120,9 +120,14 @@ extern void console_stop(struct console =

 extern void console_start(struct console *);
 extern int is_console_locked(void);
 =

+#ifndef CONFIG_DISABLE_CONSOLE_SUSPEND
 /* Suspend and resume console messages over PM events */
 extern void suspend_console(void);
 extern void resume_console(void);
+#else
+static inline void suspend_console(void) {}
+static inline void resume_console(void) {}
+#endif /* CONFIG_DISABLE_CONSOLE_SUSPEND */
 =

 /* Some debug stub to catch some of the obvious races in the VT code */
 #if 1
Index: linux-2.6.18-rc4-mm1/kernel/power/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.18-rc4-mm1.orig/kernel/power/Kconfig	2006-08-16 11:59:56.0000=
00000 +0200
+++ linux-2.6.18-rc4-mm1/kernel/power/Kconfig	2006-08-16 12:01:26.000000000=
 +0200
@@ -36,6 +36,17 @@ config PM_DEBUG
 	code. This is helpful when debugging and reporting various PM bugs, =

 	like suspend support.
 =

+config PM_DISABLE_CONSOLE_SUSPEND
+	bool "Keep console(s) enabled during suspend/resume (DANGEROUS)"
+	depends on PM && PM_DEBUG
+	default n
+	---help---
+	This option turns off the console suspend mechanism that prevents
+	debug messages from reaching the console during the suspend/resume
+	operations.  This may be helpful when debugging device drivers'
+	suspend/resume routines, but may itself lead to problems, for example
+	if netconsole is used.
+
 config PM_TRACE
 	bool "Suspend/resume event tracing"
 	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
Index: linux-2.6.18-rc4-mm1/kernel/printk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.18-rc4-mm1.orig/kernel/printk.c	2006-08-16 11:59:56.000000000=
 +0200
+++ linux-2.6.18-rc4-mm1/kernel/printk.c	2006-08-16 12:08:59.000000000 +0200
@@ -702,6 +702,7 @@ int __init add_preferred_console(char *n
 	return 0;
 }
 =

+#ifndef CONFIG_DISABLE_CONSOLE_SUSPEND
 /**
  * suspend_console - suspend the console subsystem
  *
@@ -709,8 +710,14 @@ int __init add_preferred_console(char *n
  */
 void suspend_console(void)
 {
+	printk("Suspending console(s)\n");
 	acquire_console_sem();
 	console_suspended =3D 1;
+	/* This is needed so that all of the messages that have already been
+	 * written to all consoles can be actually transmitted (eg. over a
+	 * network) before we try to suspend the consoles' devices.
+	 */
+	ssleep(2);
 }
 =

 void resume_console(void)
@@ -718,6 +725,7 @@ void resume_console(void)
 	console_suspended =3D 0;
 	release_console_sem();
 }
+#endif /* CONFIG_DISABLE_CONSOLE_SUSPEND */
 =

 /**
  * acquire_console_sem - lock the console system for exclusive use.
