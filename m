From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFT/RFC] PM: Skip kernel VT switch during
	suspend/resume with i915/KMS drivers
Date: Sun, 17 Jan 2010 00:25:49 +0100
Message-ID: <201001170025.49758.rjw__45572.4301435568$1263684389$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I've been experimenting with the appended patch for some time.  It appears to
speed up suspend and resume a bit if the box uses i915 with KMS.

It doesn't seem to break things, but of course more testing would be
appreciated.  Comments are welcome as well.

Thanks,
Rafael

---
 drivers/gpu/drm/i915/i915_drv.c |    4 ++++
 include/linux/suspend.h         |    9 +++++++++
 kernel/power/suspend.c          |   16 +++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/suspend.h
===================================================================
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -116,6 +116,13 @@ struct platform_suspend_ops {
 };
 
 #ifdef CONFIG_SUSPEND
+extern bool vt_switch_enabled;
+
+static inline void disable_suspend_vt_switch(void)
+{
+	vt_switch_enabled = false;
+}
+
 /**
  * suspend_set_ops - set platform dependent suspend operations
  * @ops: The new suspend operations to set.
@@ -143,6 +150,8 @@ extern void arch_suspend_enable_irqs(voi
 
 extern int pm_suspend(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
+static inline void disable_suspend_vt_switch(void) {}
+
 #define suspend_valid_only_mem	NULL
 
 static inline void suspend_set_ops(struct platform_suspend_ops *ops) {}
Index: linux-2.6/kernel/power/suspend.c
===================================================================
--- linux-2.6.orig/kernel/power/suspend.c
+++ linux-2.6/kernel/power/suspend.c
@@ -18,6 +18,13 @@
 
 #include "power.h"
 
+/*
+ * If set, switch to a new VT before suspend and switch back to the original
+ * one during resume.
+ */
+bool vt_switch_enabled = true;
+EXPORT_SYMBOL_GPL(vt_switch_enabled);
+
 const char *const pm_states[PM_SUSPEND_MAX] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
 	[PM_SUSPEND_MEM]	= "mem",
@@ -82,7 +89,8 @@ static int suspend_prepare(void)
 	if (!suspend_ops || !suspend_ops->enter)
 		return -EPERM;
 
-	pm_prepare_console();
+	if (vt_switch_enabled)
+		pm_prepare_console();
 
 	error = pm_notifier_call_chain(PM_SUSPEND_PREPARE);
 	if (error)
@@ -100,7 +108,8 @@ static int suspend_prepare(void)
 	usermodehelper_enable();
  Finish:
 	pm_notifier_call_chain(PM_POST_SUSPEND);
-	pm_restore_console();
+	if (vt_switch_enabled)
+		pm_restore_console();
 	return error;
 }
 
@@ -238,7 +247,8 @@ static void suspend_finish(void)
 	suspend_thaw_processes();
 	usermodehelper_enable();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
-	pm_restore_console();
+	if (vt_switch_enabled)
+		pm_restore_console();
 }
 
 /**
Index: linux-2.6/drivers/gpu/drm/i915/i915_drv.c
===================================================================
--- linux-2.6.orig/drivers/gpu/drm/i915/i915_drv.c
+++ linux-2.6/drivers/gpu/drm/i915/i915_drv.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/suspend.h>
 #include "drmP.h"
 #include "drm.h"
 #include "i915_drm.h"
@@ -543,6 +544,9 @@ static int __init i915_init(void)
 		driver.driver_features &= ~DRIVER_MODESET;
 #endif
 
+	if (driver.driver_features & DRIVER_MODESET)
+		disable_suspend_vt_switch();
+
 	return drm_init(&driver);
 }
 
