From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 09:26:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
	<20060615161446.GA23859@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615161446.GA23859@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> =

> That said... Linus, can I get latest version of that patch? I'll fix
> it up to work with s2disk...

I don't think I've done anything but fix the SYSTEM_RUNNING thing you =

noticed and fixed a header problem that DaveJ noticed with =

CONFIG_VT_CONSOLE not being enabled. But here it is again.

(I'm told that the linux-pm list corrupts things with MIME, but at least =

Pavel should get a non-corrupt version thanks to being directly on the =

participants list)

Btw, the new console prepare/restore code is so simple that I'm not sure =

it's worthwhile even having a special file for it. It would actually clean =

things up to move these things into kernel/printk.c (and make the =

"console_suspended" flag static to that file).

		Linus

----
Author: Linus Torvalds <torvalds@macmini.osdl.org>
Date:   Thu Jun 8 15:29:09 2006 -0700

    Fix console handling during suspend/resume
    =

    The old code was terminally broken, and would do extremely bad
    things if you used netconsole, for example. Like sending out packets
    when the device had already been suspended etc.
    =

    The new version may not be perfect either, but it seems fundamentally
    like a better design.
    =

    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 37c1c76..c03b17f 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -43,13 +43,9 @@ #ifdef CONFIG_PM
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
 =

-#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
-#else
-static inline int pm_prepare_console(void) { return 0; }
-static inline void pm_restore_console(void) {}
-#endif /* defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE) */
+
 #else
 static inline int software_suspend(void)
 {
diff --git a/kernel/power/console.c b/kernel/power/console.c
index 623786d..6e039ca 100644
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
+	system_state =3D SYSTEM_RUNNING;
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
