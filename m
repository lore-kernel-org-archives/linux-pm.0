From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 20:24:19 +0200
Message-ID: <20060615182419.GA1711@elf.ucw.cz>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
	<20060615161446.GA23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > That said... Linus, can I get latest version of that patch? I'll fix
> > it up to work with s2disk...
> =

> I don't think I've done anything but fix the SYSTEM_RUNNING thing you =

> noticed and fixed a header problem that DaveJ noticed with =

> CONFIG_VT_CONSOLE not being enabled. But here it is again.

Okay, console switches are really needed -- so that X gets it chance
to save graphics state. Try your version from accelerated X -- it
would break AFAICS.

So we basically need the old code -- to switch consoles -- and then
your new code -- to prevent writing to console that is suspended.

Oh and I'm not sure about that system_state. We probably should have
SYSTEM_SUSPENDING, and definitely should not be setting this from
console-handling routines... is setting system_state needed at all?

Does this solve your problem? It will probably break compilation in
some weird setups, and definitely has some wrong warnings...
								Pavel

diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index f8d5e2a..b9d24a4 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -72,5 +72,6 @@ void dpm_resume(void)
 void device_resume(void)
 {
+	pm_unfreeze_console();
 	down(&dpm_sem);
 	dpm_resume();
 	up(&dpm_sem);
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 9231942..41ba63a 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -86,5 +86,6 @@ int device_suspend(pm_message_t state)
 	int error =3D 0;
 =

+	pm_freeze_console();
 	down(&dpm_sem);
 	down(&dpm_list_sem);
 	while (!list_empty(&dpm_active) && error =3D=3D 0) {
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 37c1c76..c03b17f 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -43,13 +43,9 @@ extern void mark_free_pages(struct zone =

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
index 623786d..2be3ef2 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -9,24 +9,25 @@
 #include <linux/console.h>
 #include "power.h"
 =

-#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 =

 static int orig_fgconsole, orig_kmsg;
+extern int console_suspended;
 =

 int pm_prepare_console(void)
 {
 	acquire_console_sem();
-
 	orig_fgconsole =3D fg_console;
 =

 	if (vc_allocate(SUSPEND_CONSOLE)) {
-	  /* we can't have a free VC for now. Too bad,
-	   * we don't want to mess the screen for now. */
+		/* we can't have a free VC for now. Too bad,
+		 * we don't want to mess the screen for now. */
 		release_console_sem();
 		return 1;
 	}
 =

+	/* We need to switch to text-mode console, so that X has chance
+	   to save its state. */
 	set_console(SUSPEND_CONSOLE);
 	release_console_sem();
 =

@@ -36,15 +37,31 @@ int pm_prepare_console(void)
 	}
 	orig_kmsg =3D kmsg_redirect;
 	kmsg_redirect =3D SUSPEND_CONSOLE;
+ 	return 0;
+}
+
+void pm_freeze_console(void)
+{
+	acquire_console_sem();
+	console_suspended =3D 1;
+	system_state =3D SYSTEM_BOOTING;
 	return 0;
 }
 =

+void pm_unfreeze_console(void)
+{
+	console_suspended =3D 0;
+	system_state =3D SYSTEM_RUNNING;
+	release_console_sem();
+	return;
+}
+
 void pm_restore_console(void)
 {
 	acquire_console_sem();
 	set_console(orig_fgconsole);
+
 	release_console_sem();
 	kmsg_redirect =3D orig_kmsg;
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


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
