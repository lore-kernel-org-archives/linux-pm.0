From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 2/4] PM: Move definition of struct
	pm_ops to suspend.h
Date: Sun, 24 Jun 2007 22:41:38 +0200
Message-ID: <200706242241.39283.rjw__7338.93538495085$1182720750$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706242239.05678.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Move the definition of 'struct pm_ops' and related functions from <linux/pm.h>
to <linux/suspend.h> .

There are, at least, the following reasons to do that:
* 'struct pm_ops' is specifically related to suspend and not to the power
  management in general.
* As long as 'struct pm_ops' is defined in <linux/pm.h>, any modification of it
  causes the entire kernel to be recompiled, which is unnecessary and annoying.
* Some suspend-related features are already defined in <linux/suspend.h>, so it
  is logical to move the definition of 'struct pm_ops' into there.
* 'struct hibernation_ops', being the hibernation-related counterpart of
  'struct pm_ops', is defined in <linux/suspend.h> .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/common/sharpsl_pm.c             |    1 
 arch/arm/mach-at91/pm.c                  |    3 
 arch/arm/mach-omap1/pm.c                 |    3 
 arch/arm/mach-omap2/pm.c                 |    3 
 arch/arm/mach-pnx4008/pm.c               |    2 
 arch/blackfin/mach-common/pm.c           |    2 
 arch/powerpc/platforms/52xx/mpc52xx_pm.c |    2 
 include/linux/pm.h                       |   78 ------------------------
 include/linux/suspend.h                  |  100 +++++++++++++++++++++++++++----
 9 files changed, 96 insertions(+), 98 deletions(-)

Index: linux-2.6.22-rc5/include/linux/pm.h
===================================================================
--- linux-2.6.22-rc5.orig/include/linux/pm.h	2007-06-24 01:42:02.000000000 +0200
+++ linux-2.6.22-rc5/include/linux/pm.h	2007-06-24 18:50:41.000000000 +0200
@@ -102,84 +102,6 @@ struct pm_dev
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
-typedef int __bitwise suspend_state_t;
-
-#define PM_SUSPEND_ON		((__force suspend_state_t) 0)
-#define PM_SUSPEND_STANDBY	((__force suspend_state_t) 1)
-#define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
-#define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
-
-/**
- * struct pm_ops - Callbacks for managing platform dependent system sleep
- *	states.
- *
- * @valid: Callback to determine if given system sleep state is supported by
- *	the platform.  Valid (ie. supported) states are advertised in
- *	/sys/power/state.  Note that it still may be impossible to enter given
- *	system sleep state if the conditions aren't right.
- *	There is the %pm_valid_only_mem function available that can be assigned
- *	to this if the platform only supports mem sleep.
- *
- * @set_target: Tell the platform which system sleep state is going to be
- *	entered.  The information passed to @set_target should be disregarded
- *	by the platform as soon as @finish() is executed and if	@prepare()
- *	fails.
- *	This callback is optional.  However, if it is implemented, the
- *	argument passed to @prepare(), @enter and @finish() must be ignored.
- *
- * @prepare: Prepare the platform for entering the system sleep state indicated
- *	by @set_target().
- *	This callback is optional.  It returns 0 on success or a negative
- *	error code otherwise, in which case the system cannot enter given
- *	sleep state.
- *
- * @enter: Enter the system sleep state indicated by @set_target().
- *	This callback is mandatory.  It returns 0 on success or a negative
- *	error code otherwise, in which case the system cannot enter given
- *	sleep state.
- *
- * @finish: Called when the system has just left a sleep state.
- *	This callback is optional, but should be implemented by platforms that
- *	implement @prepare().  It is always called after @enter() (even if
- *	@enter() fails).
- */
-struct pm_ops {
-	int (*valid)(suspend_state_t state);
-	int (*set_target)(suspend_state_t state);
-	int (*prepare)(suspend_state_t state);
-	int (*enter)(suspend_state_t state);
-	int (*finish)(suspend_state_t state);
-};
-
-extern struct pm_ops *pm_ops;
-
-/**
- * pm_set_ops - set platform dependent power management ops
- * @pm_ops: The new power management operations to set.
- */
-extern void pm_set_ops(struct pm_ops *pm_ops);
-extern int pm_valid_only_mem(suspend_state_t state);
-
-/**
- * arch_suspend_disable_irqs - disable IRQs for suspend
- *
- * Disables IRQs (in the default case). This is a weak symbol in the common
- * code and thus allows architectures to override it if more needs to be
- * done. Not called for suspend to disk.
- */
-extern void arch_suspend_disable_irqs(void);
-
-/**
- * arch_suspend_enable_irqs - enable IRQs after suspend
- *
- * Enables IRQs (in the default case). This is a weak symbol in the common
- * code and thus allows architectures to override it if more needs to be
- * done. Not called for suspend to disk.
- */
-extern void arch_suspend_enable_irqs(void);
-
-extern int pm_suspend(suspend_state_t state);
-
 /*
  * Device power management
  */
Index: linux-2.6.22-rc5/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc5.orig/include/linux/suspend.h	2007-06-24 00:18:28.000000000 +0200
+++ linux-2.6.22-rc5/include/linux/suspend.h	2007-06-24 18:51:56.000000000 +0200
@@ -1,5 +1,5 @@
-#ifndef _LINUX_SWSUSP_H
-#define _LINUX_SWSUSP_H
+#ifndef _LINUX_SUSPEND_H
+#define _LINUX_SUSPEND_H
 
 #if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32) || defined(CONFIG_PPC64)
 #include <asm/suspend.h>
@@ -10,6 +10,92 @@
 #include <linux/pm.h>
 #include <linux/mm.h>
 
+#if defined(CONFIG_PM) && defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
+#else
+static inline int pm_prepare_console(void) { return 0; }
+static inline void pm_restore_console(void) {}
+#endif
+
+typedef int __bitwise suspend_state_t;
+
+#define PM_SUSPEND_ON		((__force suspend_state_t) 0)
+#define PM_SUSPEND_STANDBY	((__force suspend_state_t) 1)
+#define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
+#define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
+
+/**
+ * struct pm_ops - Callbacks for managing platform dependent system sleep
+ *	states.
+ *
+ * @valid: Callback to determine if given system sleep state is supported by
+ *	the platform.  Valid (ie. supported) states are advertised in
+ *	/sys/power/state.  Note that it still may be impossible to enter given
+ *	system sleep state if the conditions aren't right.
+ *	There is the %pm_valid_only_mem function available that can be assigned
+ *	to this if the platform only supports mem sleep.
+ *
+ * @set_target: Tell the platform which system sleep state is going to be
+ *	entered.  The information passed to @set_target should be disregarded
+ *	by the platform as soon as @finish() is executed and if	@prepare()
+ *	fails.
+ *	This callback is optional.  However, if it is implemented, the
+ *	argument passed to @prepare(), @enter and @finish() must be ignored.
+ *
+ * @prepare: Prepare the platform for entering the system sleep state indicated
+ *	by @set_target().
+ *	This callback is optional.  It returns 0 on success or a negative
+ *	error code otherwise, in which case the system cannot enter given
+ *	sleep state.
+ *
+ * @enter: Enter the system sleep state indicated by @set_target().
+ *	This callback is mandatory.  It returns 0 on success or a negative
+ *	error code otherwise, in which case the system cannot enter given
+ *	sleep state.
+ *
+ * @finish: Called when the system has just left a sleep state.
+ *	This callback is optional, but should be implemented by platforms that
+ *	implement @prepare().  It is always called after @enter() (even if
+ *	@enter() fails).
+ */
+struct pm_ops {
+	int (*valid)(suspend_state_t state);
+	int (*set_target)(suspend_state_t state);
+	int (*prepare)(suspend_state_t state);
+	int (*enter)(suspend_state_t state);
+	int (*finish)(suspend_state_t state);
+};
+
+extern struct pm_ops *pm_ops;
+
+/**
+ * pm_set_ops - set platform dependent power management ops
+ * @pm_ops: The new power management operations to set.
+ */
+extern void pm_set_ops(struct pm_ops *pm_ops);
+extern int pm_valid_only_mem(suspend_state_t state);
+
+/**
+ * arch_suspend_disable_irqs - disable IRQs for suspend
+ *
+ * Disables IRQs (in the default case). This is a weak symbol in the common
+ * code and thus allows architectures to override it if more needs to be
+ * done. Not called for suspend to disk.
+ */
+extern void arch_suspend_disable_irqs(void);
+
+/**
+ * arch_suspend_enable_irqs - enable IRQs after suspend
+ *
+ * Enables IRQs (in the default case). This is a weak symbol in the common
+ * code and thus allows architectures to override it if more needs to be
+ * done. Not called for suspend to disk.
+ */
+extern void arch_suspend_enable_irqs(void);
+
+extern int pm_suspend(suspend_state_t state);
+
 /* struct pbe is used for creating lists of pages that should be restored
  * atomically during the resume from disk, because the page frames they have
  * occupied before the suspend are in use.
@@ -24,14 +110,6 @@ struct pbe {
 extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
 
-#if defined(CONFIG_PM) && defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
-extern int pm_prepare_console(void);
-extern void pm_restore_console(void);
-#else
-static inline int pm_prepare_console(void) { return 0; }
-static inline void pm_restore_console(void) {}
-#endif
-
 /**
  * struct hibernation_ops - hibernation platform support
  *
@@ -127,4 +205,4 @@ static inline void register_nosave_regio
 }
 #endif
 
-#endif /* _LINUX_SWSUSP_H */
+#endif /* _LINUX_SUSPEND_H */
Index: linux-2.6.22-rc5/arch/arm/common/sharpsl_pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/common/sharpsl_pm.c	2007-06-23 21:22:43.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/common/sharpsl_pm.c	2007-06-24 19:01:36.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/apm-emulation.h>
+#include <linux/suspend.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
Index: linux-2.6.22-rc5/arch/arm/mach-pnx4008/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-pnx4008/pm.c	2007-06-23 21:22:43.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-pnx4008/pm.c	2007-06-24 19:03:33.000000000 +0200
@@ -15,7 +15,7 @@
 #include <linux/rtc.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
-#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 
Index: linux-2.6.22-rc5/arch/arm/mach-omap1/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-omap1/pm.c	2007-06-23 21:22:43.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-omap1/pm.c	2007-06-24 19:05:17.000000000 +0200
@@ -35,10 +35,9 @@
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
-#include <linux/pm.h>
 #include <linux/interrupt.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
Index: linux-2.6.22-rc5/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-omap2/pm.c	2007-06-17 12:38:46.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-omap2/pm.c	2007-06-24 19:06:08.000000000 +0200
@@ -16,10 +16,9 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
-#include <linux/pm.h>
 #include <linux/interrupt.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
Index: linux-2.6.22-rc5/arch/arm/mach-at91/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/arm/mach-at91/pm.c	2007-06-17 12:38:46.000000000 +0200
+++ linux-2.6.22-rc5/arch/arm/mach-at91/pm.c	2007-06-24 19:07:22.000000000 +0200
@@ -10,10 +10,9 @@
  * (at your option) any later version.
  */
 
-#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
-#include <linux/pm.h>
 #include <linux/interrupt.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
Index: linux-2.6.22-rc5/arch/blackfin/mach-common/pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/blackfin/mach-common/pm.c	2007-06-17 12:38:46.000000000 +0200
+++ linux-2.6.22-rc5/arch/blackfin/mach-common/pm.c	2007-06-24 19:08:21.000000000 +0200
@@ -32,7 +32,7 @@
  * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
 
Index: linux-2.6.22-rc5/arch/powerpc/platforms/52xx/mpc52xx_pm.c
===================================================================
--- linux-2.6.22-rc5.orig/arch/powerpc/platforms/52xx/mpc52xx_pm.c	2007-06-17 12:38:50.000000000 +0200
+++ linux-2.6.22-rc5/arch/powerpc/platforms/52xx/mpc52xx_pm.c	2007-06-24 19:09:20.000000000 +0200
@@ -1,5 +1,5 @@
 #include <linux/init.h>
-#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/io.h>
 #include <asm/time.h>
 #include <asm/cacheflush.h>
