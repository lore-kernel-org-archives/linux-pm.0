From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] remove software_suspend() and fix compile
	w/	SOFTWARE_SUSPEND disabled
Date: Thu, 22 Mar 2007 14:46:32 +0100
Message-ID: <1174571192.32051.5.camel@johannes.berg>
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
To: linux-pm@lists.linux-foundation.org
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This patch kills off software_suspend() and all it's users,
pm_suspend(PM_SUSPEND_DISK) is much cleaner anyway. Also, this
makes the kernel compile again w/o CONFIG_SOFTWARE_SUSPEND after
Rafael's patches to kill the suspend pageflags broke it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Rafael J. Wysocki <rjw@sisk.pl>

---
Have the pageflags removal patches been applied anywhere already? If so
please just apply this on top. If not, could you (Rafael) then fix your
patches to compile w/o software suspend and then I'll post the removal
of software_suspend() as an extra patch.

Alternatively we can just change the order of these patches, i.e. do the
removal of software_suspend() first and then your patches (since the
compile error your patches introduce is related to software_suspend()).

 drivers/acpi/sleep/proc.c    |    2 +-
 drivers/i2c/chips/tps65010.c |    4 +++-
 include/linux/init.h         |    2 +-
 include/linux/suspend.h      |    8 --------
 kernel/power/main.c          |   21 ++++++++-------------
 kernel/sys.c                 |    2 +-
 6 files changed, 14 insertions(+), 25 deletions(-)

--- linux-2.6.orig/kernel/power/main.c	2007-03-22 14:37:07.564654656 +0100
+++ linux-2.6/kernel/power/main.c	2007-03-22 14:37:30.714654656 +0100
@@ -172,17 +172,22 @@ static void suspend_finish(suspend_state
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
+	 * configured, then it cannot be supported (this prevents
+	 * rogue pm_ops from marking it valid which would cause it
+	 * to show up in /sys/power/state.) */
 	if (state =3D=3D PM_SUSPEND_DISK)
+#ifdef CONFIG_SOFTWARE_SUSPEND
 		return 1;
+#else
+		return 0;
+#endif
 =

 	/* all other states need lowlevel support and need to be
 	 * valid to the lowlevel implementation, no valid callback
@@ -232,16 +237,6 @@ static int enter_state(suspend_state_t s
 	return error;
 }
 =

-/*
- * This is main interface to the outside world. It needs to be
- * called from process context.
- */
-int software_suspend(void)
-{
-	return enter_state(PM_SUSPEND_DISK);
-}
-
-
 /**
  *	pm_suspend - Externally visible function for suspending system.
  *	@state:		Enumarted value of state to enter.
--- linux-2.6.orig/include/linux/suspend.h	2007-03-22 14:34:58.344654656 +0=
100
+++ linux-2.6/include/linux/suspend.h	2007-03-22 14:37:30.714654656 +0100
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
--- linux-2.6.orig/drivers/acpi/sleep/proc.c	2007-03-22 14:34:58.444654656 =
+0100
+++ linux-2.6/drivers/acpi/sleep/proc.c	2007-03-22 14:37:30.724654656 +0100
@@ -60,7 +60,7 @@ acpi_system_write_sleep(struct file *fil
 	state =3D simple_strtoul(str, NULL, 0);
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state =3D=3D 4) {
-		error =3D software_suspend();
+		error =3D pm_suspend(PM_SUSPEND_DISK);
 		goto Done;
 	}
 #endif
--- linux-2.6.orig/drivers/i2c/chips/tps65010.c	2007-03-22 14:34:58.7446546=
56 +0100
+++ linux-2.6/drivers/i2c/chips/tps65010.c	2007-03-22 14:37:30.724654656 +0=
100
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
--- linux-2.6.orig/include/linux/init.h	2007-03-22 14:34:58.414654656 +0100
+++ linux-2.6/include/linux/init.h	2007-03-22 14:37:30.724654656 +0100
@@ -228,7 +228,7 @@ void __init parse_early_param(void);
 #define __obsolete_setup(str) 			/* nothing */
 #endif
 =

-/* Data marked not to be saved by software_suspend() */
+/* Data marked not to be saved by software suspend */
 #define __nosavedata __attribute__ ((__section__ (".data.nosave")))
 =

 /* This means "can be init if no module support, otherwise module load
--- linux-2.6.orig/kernel/sys.c	2007-03-22 14:34:58.304654656 +0100
+++ linux-2.6/kernel/sys.c	2007-03-22 14:37:30.734654656 +0100
@@ -881,7 +881,7 @@ asmlinkage long sys_reboot(int magic1, i
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		{
-			int ret =3D software_suspend();
+			int ret =3D pm_suspend(PM_SUSPEND_DISK);
 			unlock_kernel();
 			return ret;
 		}
