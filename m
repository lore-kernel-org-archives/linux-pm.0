From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] remove software_suspend()
Date: Wed, 11 Apr 2007 17:52:37 +0200
Message-ID: <1176306757.19348.1.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch removes software_suspend() and all it's users since
pm_suspend(PM_SUSPEND_DISK) should be equivalent and there's no
point in having two interfaces for the same thing.

The patch also changes the valid_state function to return 0
(false) for PM_SUSPEND_DISK when SOFTWARE_SUSPEND is not configured
instead of accepting it and having the whole thing fail later.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 drivers/acpi/sleep/proc.c    |    2 +-
 drivers/i2c/chips/tps65010.c |    4 +++-
 include/linux/init.h         |    2 +-
 include/linux/suspend.h      |    8 --------
 kernel/power/main.c          |   21 +++++++--------------
 kernel/sys.c                 |    2 +-
 6 files changed, 13 insertions(+), 26 deletions(-)

--- wireless-dev.orig/kernel/power/main.c	2007-04-06 01:21:58.604829459 +02=
00
+++ wireless-dev/kernel/power/main.c	2007-04-06 01:21:59.194829459 +0200
@@ -178,17 +178,21 @@ static void suspend_finish(suspend_state
 static const char * const pm_states[PM_SUSPEND_MAX] =3D {
 	[PM_SUSPEND_STANDBY]	=3D "standby",
 	[PM_SUSPEND_MEM]	=3D "mem",
-#ifdef CONFIG_SOFTWARE_SUSPEND
 	[PM_SUSPEND_DISK]	=3D "disk",
-#endif
 };
 =

 static inline int valid_state(suspend_state_t state)
 {
 	/* Suspend-to-disk does not really need low-level support.
-	 * It can work with reboot if needed. */
+	 * It can work with shutdown/reboot if needed. If it isn't
+	 * configured, then it cannot be supported.
+	 */
 	if (state =3D=3D PM_SUSPEND_DISK)
+#ifdef CONFIG_SOFTWARE_SUSPEND
 		return 1;
+#else
+		return 0;
+#endif
 =

 	/* all other states need lowlevel support and need to be
 	 * valid to the lowlevel implementation, no valid callback
@@ -238,17 +242,6 @@ static int enter_state(suspend_state_t s
 	return error;
 }
 =

-#ifdef CONFIG_SOFTWARE_SUSPEND
-/*
- * This is main interface to the outside world. It needs to be
- * called from process context.
- */
-int software_suspend(void)
-{
-	return enter_state(PM_SUSPEND_DISK);
-}
-#endif
-
 =

 /**
  *	pm_suspend - Externally visible function for suspending system.
--- wireless-dev.orig/include/linux/suspend.h	2007-04-06 01:21:57.094829459=
 +0200
+++ wireless-dev/include/linux/suspend.h	2007-04-06 01:21:59.194829459 +0200
@@ -33,8 +33,6 @@ static inline void pm_restore_console(vo
 #endif
 =

 #if defined(CONFIG_PM) && defined(CONFIG_SOFTWARE_SUSPEND)
-/* kernel/power/swsusp.c */
-extern int software_suspend(void);
 /* kernel/power/snapshot.c */
 extern void __register_nosave_region(unsigned long b, unsigned long e, int=
 km);
 static inline void register_nosave_region(unsigned long b, unsigned long e)
@@ -50,12 +48,6 @@ extern void swsusp_set_page_free(struct =

 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
 #else
-static inline int software_suspend(void)
-{
-	printk("Warning: fake suspend called\n");
-	return -ENOSYS;
-}
-
 static inline void register_nosave_region(unsigned long b, unsigned long e=
) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned l=
ong e) {}
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
--- wireless-dev.orig/drivers/acpi/sleep/proc.c	2007-04-06 01:19:56.1748294=
59 +0200
+++ wireless-dev/drivers/acpi/sleep/proc.c	2007-04-06 01:21:59.194829459 +0=
200
@@ -60,7 +60,7 @@ acpi_system_write_sleep(struct file *fil
 	state =3D simple_strtoul(str, NULL, 0);
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state =3D=3D 4) {
-		error =3D software_suspend();
+		error =3D pm_suspend(PM_SUSPEND_DISK);
 		goto Done;
 	}
 #endif
--- wireless-dev.orig/drivers/i2c/chips/tps65010.c	2007-04-06 01:19:56.2048=
29459 +0200
+++ wireless-dev/drivers/i2c/chips/tps65010.c	2007-04-06 01:21:59.194829459=
 +0200
@@ -351,8 +351,10 @@ static void tps65010_interrupt(struct tp
 #if 0
 			/* REVISIT:  this might need its own workqueue
 			 * plus tweaks including deadlock avoidance ...
+			 * also needs to get error handling and probably
+			 * an #ifdef CONFIG_SOFTWARE_SUSPEND
 			 */
-			software_suspend();
+			pm_suspend(PM_SUSPEND_DISK);
 #endif
 			poll =3D 1;
 		}
--- wireless-dev.orig/include/linux/init.h	2007-04-06 01:19:56.144829459 +0=
200
+++ wireless-dev/include/linux/init.h	2007-04-06 01:21:59.194829459 +0200
@@ -228,7 +228,7 @@ void __init parse_early_param(void);
 #define __obsolete_setup(str) 			/* nothing */
 #endif
 =

-/* Data marked not to be saved by software_suspend() */
+/* Data marked not to be saved by software suspend */
 #define __nosavedata __attribute__ ((__section__ (".data.nosave")))
 =

 /* This means "can be init if no module support, otherwise module load
--- wireless-dev.orig/kernel/sys.c	2007-04-06 01:19:56.104829459 +0200
+++ wireless-dev/kernel/sys.c	2007-04-06 01:21:59.204829459 +0200
@@ -881,7 +881,7 @@ asmlinkage long sys_reboot(int magic1, i
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		{
-			int ret =3D software_suspend();
+			int ret =3D pm_suspend(PM_SUSPEND_DISK);
 			unlock_kernel();
 			return ret;
 		}
