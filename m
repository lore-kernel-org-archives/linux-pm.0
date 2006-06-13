From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/2] Fix console handling during suspend/resume
Date: Tue, 13 Jun 2006 14:40:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


The old code was terminally broken, and would do extremely bad things if =

you used netconsole, for example. Like sending out packets when the device =

had already been suspended etc.

The new version may not be perfect either, but it seems fundamentally like =

a better design: we just hold on to the primary console semaphore over the =

whole suspend event, forcing printk() to just buffer up its data until we =

can show it again. The code is also much simpler and more obvious.

This can potentially make debugging harder when something goes wrong at =

suspend time and a visible printk would have given us a hint _what_ went =

wrong, but on the other hand, it makes fewer things go wrong. Oopses will =

punch through the semaphore anyway, so serious problems aren't affected by =

this.

Adding a debug thing to say "don't get the console semaphore" might be a =

good idea.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---


diff --git a/kernel/power/console.c b/kernel/power/console.c
index 623786d..9110371 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -9,42 +9,20 @@ #include <linux/kbd_kern.h>
 #include <linux/console.h>
 #include "power.h"
 =

-#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
-#define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
-
-static int orig_fgconsole, orig_kmsg;
+extern int console_suspended;
 =

 int pm_prepare_console(void)
 {
 	acquire_console_sem();
-
-	orig_fgconsole =3D fg_console;
-
-	if (vc_allocate(SUSPEND_CONSOLE)) {
-	  /* we can't have a free VC for now. Too bad,
-	   * we don't want to mess the screen for now. */
-		release_console_sem();
-		return 1;
-	}
-
-	set_console(SUSPEND_CONSOLE);
-	release_console_sem();
-
-	if (vt_waitactive(SUSPEND_CONSOLE)) {
-		pr_debug("Suspend: Can't switch VCs.");
-		return 1;
-	}
-	orig_kmsg =3D kmsg_redirect;
-	kmsg_redirect =3D SUSPEND_CONSOLE;
+	console_suspended =3D 1;
+	system_state =3D SYSTEM_BOOTING;
 	return 0;
 }
 =

 void pm_restore_console(void)
 {
-	acquire_console_sem();
-	set_console(orig_fgconsole);
+	console_suspended =3D 0;
+	system_state =3D SYSTEM_BOOTING;
 	release_console_sem();
-	kmsg_redirect =3D orig_kmsg;
 	return;
 }
-#endif
diff --git a/kernel/printk.c b/kernel/printk.c
index c056f33..8adb9ed 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -67,6 +67,7 @@ EXPORT_SYMBOL(oops_in_progress);
  * driver system.
  */
 static DECLARE_MUTEX(console_sem);
+static DECLARE_MUTEX(secondary_console_sem);
 struct console *console_drivers;
 /*
  * This is used for debugging the mess that is the VT code by
@@ -77,6 +78,7 @@ struct console *console_drivers;
  * locked without the console sempahore held
  */
 static int console_locked;
+int console_suspended;
 =

 /*
  * logbuf_lock protects log_buf, log_start, log_end, con_start and logged_=
chars
@@ -707,6 +709,11 @@ int __init add_preferred_console(char *n
  */
 void acquire_console_sem(void)
 {
+	if (console_suspended) {
+		down(&secondary_console_sem);
+		return;
+	}
+
 	BUG_ON(in_interrupt());
 	down(&console_sem);
 	console_locked =3D 1;
@@ -750,6 +757,11 @@ void release_console_sem(void)
 	unsigned long _con_start, _log_end;
 	unsigned long wake_klogd =3D 0;
 =

+	if (console_suspended) {
+		up(&secondary_console_sem);
+		return;
+	}
+
 	for ( ; ; ) {
 		spin_lock_irqsave(&logbuf_lock, flags);
 		wake_klogd |=3D log_start - log_end;
