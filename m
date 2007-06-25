From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 1/8][bugfix] PM: Introduce
	set_target method in pm_ops
Date: Tue, 26 Jun 2007 00:41:19 +0200
Message-ID: <200706260041.20561.rjw__14339.9764471271$1182811771$gmane$org@sisk.pl>
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

The at91 platform code incorrectly assumes that pm_ops->prepare() will be called
before devices are suspended and uses it to make the PM core set the target
system sleep state used by the platform when suspending devices.  Thus, at91
needs a new member function in 'struct pm_ops' that will be used by the PM core
to convey the target system sleep state to the platform code before devices are
suspended.

Moreover, in the future some drivers may need to use ACPI to determine the low
power states in which to place their devices, but to provide the drivers with
this information the ACPI core needs to know what sleep state the system is
going to enter.  Namely, the device's state should not be too high power for
given system sleep state and, if the device is supposed to be able to wake up
the system, its state should not be too low power for the wake up to be
possible).  However, pm_ops->prepare() is only called after the drivers'
.suspend() callbacks have been executed, so we need an additional means to
convey the target system sleep state to the ACPI core.  The new member function
in 'struct pm_ops', set_target(), can be used for this purpose.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-at91/pm.c |    4 +-
 include/linux/pm.h      |   66 +++++++++++++++++++++++++++++++++++-------------
 kernel/power/main.c     |    6 +++-
 3 files changed, 56 insertions(+), 20 deletions(-)

Index: linux-2.6.22-rc6/include/linux/pm.h
===================================================================
--- linux-2.6.22-rc6.orig/include/linux/pm.h	2007-06-25 21:09:18.000000000 +0200
+++ linux-2.6.22-rc6/include/linux/pm.h	2007-06-25 21:09:30.000000000 +0200
@@ -110,37 +110,67 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
 /**
- * struct pm_ops - Callbacks for managing platform dependent suspend states.
- * @valid: Callback to determine whether the given state can be entered.
- *	Valid states are advertised in /sys/power/state but can still
- *	be rejected by prepare or enter if the conditions aren't right.
- *	There is a %pm_valid_only_mem function available that can be assigned
- *	to this if you only implement mem sleep.
+ * struct pm_ops - Callbacks for managing platform dependent system sleep
+ *	states.
  *
- * @prepare: Prepare the platform for the given suspend state. Can return a
- *	negative error code if necessary.
- *
- * @enter: Enter the given suspend state, must be assigned. Can return a
- *	negative error code if necessary.
- *
- * @finish: Called when the system has left the given state and all devices
- *	are resumed. The return value is ignored.
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
  */
 struct pm_ops {
 	int (*valid)(suspend_state_t state);
+	int (*set_target)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
 };
 
+extern struct pm_ops *pm_ops;
+
 /**
  * pm_set_ops - set platform dependent power management ops
  * @pm_ops: The new power management operations to set.
  */
 extern void pm_set_ops(struct pm_ops *pm_ops);
-extern struct pm_ops *pm_ops;
-extern int pm_suspend(suspend_state_t state);
-
 extern int pm_valid_only_mem(suspend_state_t state);
 
 /**
@@ -161,6 +191,8 @@ extern void arch_suspend_disable_irqs(vo
  */
 extern void arch_suspend_enable_irqs(void);
 
+extern int pm_suspend(suspend_state_t state);
+
 /*
  * Device power management
  */
Index: linux-2.6.22-rc6/kernel/power/main.c
===================================================================
--- linux-2.6.22-rc6.orig/kernel/power/main.c	2007-06-25 21:09:18.000000000 +0200
+++ linux-2.6.22-rc6/kernel/power/main.c	2007-06-25 21:09:30.000000000 +0200
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/pm.h>
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/resume-trace.h>
@@ -161,6 +160,11 @@ int suspend_devices_and_enter(suspend_st
 	if (!pm_ops)
 		return -ENOSYS;
 
+	if (pm_ops->set_target) {
+		error = pm_ops->set_target(state);
+		if (error)
+			return error;
+	}
 	suspend_console();
 	error = device_suspend(PMSG_SUSPEND);
 	if (error) {
Index: linux-2.6.22-rc6/arch/arm/mach-at91/pm.c
===================================================================
--- linux-2.6.22-rc6.orig/arch/arm/mach-at91/pm.c	2007-06-25 21:09:18.000000000 +0200
+++ linux-2.6.22-rc6/arch/arm/mach-at91/pm.c	2007-06-25 21:09:30.000000000 +0200
@@ -53,7 +53,7 @@ static suspend_state_t target_state;
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
-static int at91_pm_prepare(suspend_state_t state)
+static int at91_pm_set_target(suspend_state_t state)
 {
 	target_state = state;
 	return 0;
@@ -201,7 +201,7 @@ error:
 
 static struct pm_ops at91_pm_ops ={
 	.valid		= at91_pm_valid_state,
-	.prepare	= at91_pm_prepare,
+	.set_target	= at91_pm_set_target,
 	.enter		= at91_pm_enter,
 };
 
