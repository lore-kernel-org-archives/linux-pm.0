From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM: Combine device suspend routines
Date: Sat, 14 Oct 2017 14:41:56 +0200
Message-ID: <1757450.aXvHk4JRfq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On top of a previous change getting rid of the PM QoS flag
PM_QOS_FLAG_REMOTE_WAKEUP, combine two ACPI device suspend routines,
acpi_dev_runtime_suspend() and acpi_dev_suspend_late(), into one,
acpi_dev_suspend(), to eliminate some code duplication.

It also avoids enabling wakeup for devices handled by the ACPI
LPSS middle layer on driver removal.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_lpss.c |    6 ++--
 drivers/acpi/device_pm.c |   61 ++++++++++-------------------------------------
 include/linux/acpi.h     |    2 -
 3 files changed, 18 insertions(+), 51 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -847,37 +847,39 @@ static int acpi_dev_pm_full_power(struct
 }
 
 /**
- * acpi_dev_runtime_suspend - Put device into a low-power state using ACPI.
+ * acpi_dev_suspend - Put device into a low-power state using ACPI.
  * @dev: Device to put into a low-power state.
+ * @wakeup: Whether or not to enable wakeup for the device.
  *
- * Put the given device into a runtime low-power state using the standard ACPI
+ * Put the given device into a low-power state using the standard ACPI
  * mechanism.  Set up remote wakeup if desired, choose the state to put the
  * device into (this checks if remote wakeup is expected to work too), and set
  * the power state of the device.
  */
-int acpi_dev_runtime_suspend(struct device *dev)
+int acpi_dev_suspend(struct device *dev, bool wakeup)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	bool remote_wakeup;
+	u32 target_state = acpi_target_system_state();
 	int error;
 
 	if (!adev)
 		return 0;
 
-	remote_wakeup = acpi_device_can_wakeup(adev);
-	if (remote_wakeup) {
-		error = acpi_device_wakeup_enable(adev, ACPI_STATE_S0);
+	if (wakeup && acpi_device_can_wakeup(adev)) {
+		error = acpi_device_wakeup_enable(adev, target_state);
 		if (error)
 			return -EAGAIN;
+	} else {
+		wakeup = false;
 	}
 
-	error = acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
-	if (error && remote_wakeup)
+	error = acpi_dev_pm_low_power(dev, adev, target_state);
+	if (error && wakeup)
 		acpi_device_wakeup_disable(adev);
 
 	return error;
 }
-EXPORT_SYMBOL_GPL(acpi_dev_runtime_suspend);
+EXPORT_SYMBOL_GPL(acpi_dev_suspend);
 
 /**
  * acpi_dev_resume - Put device into the full-power state using ACPI.
@@ -910,7 +912,7 @@ EXPORT_SYMBOL_GPL(acpi_dev_resume);
 int acpi_subsys_runtime_suspend(struct device *dev)
 {
 	int ret = pm_generic_runtime_suspend(dev);
-	return ret ? ret : acpi_dev_runtime_suspend(dev);
+	return ret ? ret : acpi_dev_suspend(dev, true);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_runtime_suspend);
 
@@ -929,41 +931,6 @@ int acpi_subsys_runtime_resume(struct de
 EXPORT_SYMBOL_GPL(acpi_subsys_runtime_resume);
 
 #ifdef CONFIG_PM_SLEEP
-/**
- * acpi_dev_suspend_late - Put device into a low-power state using ACPI.
- * @dev: Device to put into a low-power state.
- *
- * Put the given device into a low-power state during system transition to a
- * sleep state using the standard ACPI mechanism.  Set up system wakeup if
- * desired, choose the state to put the device into (this checks if system
- * wakeup is expected to work too), and set the power state of the device.
- */
-int acpi_dev_suspend_late(struct device *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	u32 target_state;
-	bool wakeup;
-	int error;
-
-	if (!adev)
-		return 0;
-
-	target_state = acpi_target_system_state();
-	wakeup = device_may_wakeup(dev) && acpi_device_can_wakeup(adev);
-	if (wakeup) {
-		error = acpi_device_wakeup_enable(adev, target_state);
-		if (error)
-			return error;
-	}
-
-	error = acpi_dev_pm_low_power(dev, adev, target_state);
-	if (error && wakeup)
-		acpi_device_wakeup_disable(adev);
-
-	return error;
-}
-EXPORT_SYMBOL_GPL(acpi_dev_suspend_late);
-
 static bool acpi_dev_needs_resume(struct device *dev, struct acpi_device *adev)
 {
 	u32 sys_target = acpi_target_system_state();
@@ -1046,7 +1013,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
 int acpi_subsys_suspend_late(struct device *dev)
 {
 	int ret = pm_generic_suspend_late(dev);
-	return ret ? ret : acpi_dev_suspend_late(dev);
+	return ret ? ret : acpi_dev_suspend(dev, device_may_wakeup(dev));
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
 
Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -713,7 +713,7 @@ static int acpi_lpss_activate(struct dev
 
 static void acpi_lpss_dismiss(struct device *dev)
 {
-	acpi_dev_runtime_suspend(dev);
+	acpi_dev_suspend(dev, false);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -729,7 +729,7 @@ static int acpi_lpss_suspend_late(struct
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_save_ctx(dev, pdata);
 
-	return acpi_dev_suspend_late(dev);
+	return acpi_dev_suspend(dev, device_may_wakeup(dev));
 }
 
 static int acpi_lpss_resume_early(struct device *dev)
@@ -847,7 +847,7 @@ static int acpi_lpss_runtime_suspend(str
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_save_ctx(dev, pdata);
 
-	ret = acpi_dev_runtime_suspend(dev);
+	ret = acpi_dev_suspend(dev, true);
 
 	/*
 	 * This call must be last in the sequence, otherwise PMC will return
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -865,6 +865,7 @@ static inline void arch_reserve_mem_area
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
 int acpi_dev_runtime_suspend(struct device *dev);
+int acpi_dev_suspend(struct device *dev, bool wakeup);
 int acpi_dev_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
@@ -889,7 +890,6 @@ int acpi_subsys_resume_early(struct devi
 int acpi_subsys_suspend(struct device *dev);
 int acpi_subsys_freeze(struct device *dev);
 #else
-static inline int acpi_dev_suspend_late(struct device *dev) { return 0; }
 static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
 static inline void acpi_subsys_complete(struct device *dev) {}

