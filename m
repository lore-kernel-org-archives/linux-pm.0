From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 4/8] PM: Move definition of struct
	pm_ops to suspend.h
Date: Tue, 26 Jun 2007 00:47:05 +0200
Message-ID: <200706260047.07010.rjw__44999.354836955$1182812354$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706260039.17530.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706260039.17530.rjw@sisk.pl>
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
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/common/sharpsl_pm.c             |    1 
 arch/arm/mach-at91/pm.c                  |    3 
 arch/arm/mach-omap1/pm.c                 |    3 
 arch/arm/mach-omap2/pm.c                 |    3 
 arch/arm/mach-pnx4008/pm.c               |    2 
 arch/blackfin/mach-common/pm.c           |    2 
 arch/powerpc/platforms/52xx/mpc52xx_pm.c |    2 
 include/linux/pm.h                       |   91 ------------------------
 include/linux/suspend.h                  |  113 +++++++++++++++++++++++++++----
 9 files changed, 109 insertions(+), 111 deletions(-)

Index: linux-2.6.22-rc4-mm2/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc4-mm2.orig/include/linux/suspend.h
+++ linux-2.6.22-rc4-mm2/include/linux/suspend.h
@@ -1,5 +1,5 @@
-#ifndef _LINUX_SWSUSP_H
-#define _LINUX_SWSUSP_H
+#ifndef _LINUX_SUSPEND_H
+#define _LINUX_SUSPEND_H
 
 #if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32) || defined(CONFIG_PPC64)
 #include <asm/suspend.h>
@@ -10,6 +10,105 @@
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
+ *	the platform.
+ *	Valid (ie. supported) states are advertised in /sys/power/state.  Note
+ *	that it still may be impossible to enter given system sleep state if the
+ *	conditions aren't right.
+ *	There is the %pm_valid_only_mem function available that can be assigned
+ *	to this if the platform only supports mem sleep.
+ *
+ * @set_target: Tell the platform which system sleep state is going to be
+ *	entered.
+ *	@set_target() is executed right prior to suspending devices.  The
+ *	information conveyed to the platform code by @set_target() should be
+ *	disregarded by the platform as soon as @finish() is executed and if
+ *	@prepare() fails.  If @set_target() fails (ie. returns nonzero),
+ *	@prepare(), @enter() and @finish() will not be called by the PM core.
+ *	This callback is optional.  However, if it is implemented, the argument
+ *	passed to @prepare(), @enter() and @finish() is meaningless and should
+ *	be ignored.
+ *
+ * @prepare: Prepare the platform for entering the system sleep state indicated
+ *	by @set_target() or represented by the argument if @set_target() is not
+ *	implemented.
+ *	@prepare() is called right after devices have been suspended (ie. the
+ *	appropriate .suspend() method has been executed for each device) and
+ *	before the nonboot CPUs are disabled (it is executed with IRQs enabled).
+ *	This callback is optional.  It returns 0 on success or a negative
+ *	error code otherwise, in which case the system cannot enter the desired
+ *	sleep state (@enter() and @finish() will not be called in that case).
+ *
+ * @enter: Enter the system sleep state indicated by @set_target() or
+ *	represented by the argument if @set_target() is not implemented.
+ *	This callback is mandatory.  It returns 0 on success or a negative
+ *	error code otherwise, in which case the system cannot enter the desired
+ *	sleep state.
+ *
+ * @finish: Called when the system has just left a sleep state, right after
+ *	the nonboot CPUs have been enabled and before devices are resumed (it is
+ *	executed with IRQs enabled).  If @set_target() is not implemented, the
+ *	argument represents the sleep state being left.
+ *	This callback is optional, but should be implemented by the platforms
+ *	that implement @prepare().  If implemented, it is always called after
+ *	@enter() (even if @enter() fails).
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
@@ -24,14 +123,6 @@ struct pbe {
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
@@ -127,4 +218,4 @@ static inline void register_nosave_regio
 }
 #endif
 
-#endif /* _LINUX_SWSUSP_H */
+#endif /* _LINUX_SUSPEND_H */
Index: linux-2.6.22-rc4-mm2/arch/arm/common/sharpsl_pm.c
===================================================================
--- linux-2.6.22-rc4-mm2.orig/arch/arm/common/sharpsl_pm.c
+++ linux-2.6.22-rc4-mm2/arch/arm/common/sharpsl_pm.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/apm-emulation.h>
+#include <linux/suspend.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
Index: linux-2.6.22-rc4-mm2/arch/arm/mach-pnx4008/pm.c
===================================================================
--- linux-2.6.22-rc4-mm2.orig/arch/arm/mach-pnx4008/pm.c
+++ linux-2.6.22-rc4-mm2/arch/arm/mach-pnx4008/pm.c
@@ -15,7 +15,7 @@
 #include <linux/rtc.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
-#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 
Index: linux-2.6.22-rc4-mm2/arch/arm/mach-omap1/pm.c
===================================================================
--- linux-2.6.22-rc4-mm2.orig/arch/arm/mach-omap1/pm.c
+++ linux-2.6.22-rc4-mm2/arch/arm/mach-omap1/pm.c
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
Index: linux-2.6.22-rc4-mm2/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-2.6.22-rc4-mm2.orig/arch/arm/mach-omap2/pm.c
+++ linux-2.6.22-rc4-mm2/arch/arm/mach-omap2/pm.c
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
Index: linux-2.6.22-rc4-mm2/arch/arm/mach-at91/pm.c
===================================================================
--- linux-2.6.22-rc4-mm2.orig/arch/arm/mach-at91/pm.c
+++ linux-2.6.22-rc4-mm2/arch/arm/mach-at91/pm.c
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
Index: linux-2.6.22-rc4-mm2/arch/blackfin/mach-common/pm.c
===================================================================
--- linux-2.6.22-rc4-mm2.orig/arch/blackfin/mach-common/pm.c
+++ linux-2.6.22-rc4-mm2/arch/blackfin/mach-common/pm.c
@@ -32,7 +32,7 @@
  * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
 
Index: linux-2.6.22-rc4-mm2/arch/powerpc/platforms/52xx/mpc52xx_pm.c
===================================================================
--- linux-2.6.22-rc4-mm2.orig/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ linux-2.6.22-rc4-mm2/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -1,5 +1,5 @@
 #include <linux/init.h>
-#include <linux/pm.h>
+#include <linux/suspend.h>
 #include <linux/io.h>
 #include <asm/time.h>
 #include <asm/cacheflush.h>
Index: linux-2.6.22-rc4-mm2/include/linux/pm.h
===================================================================
--- linux-2.6.22-rc4-mm2.orig/include/linux/pm.h
+++ linux-2.6.22-rc4-mm2/include/linux/pm.h
@@ -102,97 +102,6 @@ struct pm_dev
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
- *	the platform.
- *	Valid (ie. supported) states are advertised in /sys/power/state.  Note
- *	that it still may be impossible to enter given system sleep state if the
- *	conditions aren't right.
- *	There is the %pm_valid_only_mem function available that can be assigned
- *	to this if the platform only supports mem sleep.
- *
- * @set_target: Tell the platform which system sleep state is going to be
- *	entered.
- *	@set_target() is executed right prior to suspending devices.  The
- *	information conveyed to the platform code by @set_target() should be
- *	disregarded by the platform as soon as @finish() is executed and if
- *	@prepare() fails.  If @set_target() fails (ie. returns nonzero),
- *	@prepare(), @enter() and @finish() will not be called by the PM core.
- *	This callback is optional.  However, if it is implemented, the argument
- *	passed to @prepare(), @enter() and @finish() is meaningless and should
- *	be ignored.
- *
- * @prepare: Prepare the platform for entering the system sleep state indicated
- *	by @set_target() or represented by the argument if @set_target() is not
- *	implemented.
- *	@prepare() is called right after devices have been suspended (ie. the
- *	appropriate .suspend() method has been executed for each device) and
- *	before the nonboot CPUs are disabled (it is executed with IRQs enabled).
- *	This callback is optional.  It returns 0 on success or a negative
- *	error code otherwise, in which case the system cannot enter the desired
- *	sleep state (@enter() and @finish() will not be called in that case).
- *
- * @enter: Enter the system sleep state indicated by @set_target() or
- *	represented by the argument if @set_target() is not implemented.
- *	This callback is mandatory.  It returns 0 on success or a negative
- *	error code otherwise, in which case the system cannot enter the desired
- *	sleep state.
- *
- * @finish: Called when the system has just left a sleep state, right after
- *	the nonboot CPUs have been enabled and before devices are resumed (it is
- *	executed with IRQs enabled).  If @set_target() is not implemented, the
- *	argument represents the sleep state being left.
- *	This callback is optional, but should be implemented by the platforms
- *	that implement @prepare().  If implemented, it is always called after
- *	@enter() (even if @enter() fails).
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
