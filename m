From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] PM / ACPI: Use SAFE_SUSPEND in the generic ACPI PM domain
Date: Tue, 29 Aug 2017 02:59:08 +0200
Message-ID: <3064581.Sjxxt4B3vR@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <4245176.X6JjkhnUAM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59602 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751215AbdH2BKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2017 21:10:02 -0400
In-Reply-To: <4245176.X6JjkhnUAM@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] PM / ACPI: Use SAFE_SUSPEND in the generic ACPI PM domain

Make the generic ACPI PM domain and the ACPI LPSS driver take the
SAFE_SUSPEND driver flag into consideration when deciding whether
or not to runtime resume devices during system suspend.

Namely, if the flag is set, acpi_subsys_suspend() will not attempt
to runtime resume the device unless acpi_subsys_prepare() has found
that the power state of the device has to be updated.  Accordingly,
acpi_subsys_suspend_late(), acpi_subsys_resume_late(),
acpi_lpss_suspend_late(), and acpi_lpss_resume_late() will only
try to update the power state of the device and its wakeup settings
if the device has been runtime resumed beforehand.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_lpss.c |   20 ++++++----
 drivers/acpi/device_pm.c |   90 ++++++++++++++++++++++++++++++++++++-----------
 include/acpi/acpi_bus.h  |    1 
 3 files changed, 84 insertions(+), 27 deletions(-)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -287,6 +287,7 @@ struct acpi_device_power {
 	int state;		/* Current state */
 	struct acpi_device_power_flags flags;
 	struct acpi_device_power_state states[ACPI_D_STATE_COUNT];	/* Power states (D0-D3Cold) */
+	bool update_state;
 };
 
 /* Performance Management */
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -899,6 +899,7 @@ int acpi_dev_runtime_resume(struct devic
 
 	error = acpi_dev_pm_full_power(adev);
 	acpi_device_wakeup_disable(adev);
+	adev->power.update_state = true;
 	return error;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_runtime_resume);
@@ -989,33 +990,47 @@ int acpi_dev_resume_early(struct device
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resume_early);
 
-/**
- * acpi_subsys_prepare - Prepare device for system transition to a sleep state.
- * @dev: Device to prepare.
- */
-int acpi_subsys_prepare(struct device *dev)
+static bool acpi_dev_state_update_needed(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	u32 sys_target;
 	int ret, state;
 
-	ret = pm_generic_prepare(dev);
-	if (ret < 0)
-		return ret;
+	if (!pm_runtime_suspended(dev))
+		return true;
 
-	if (!adev || !pm_runtime_suspended(dev)
-	    || device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
-		return 0;
+	if (device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
+		return true;
 
 	sys_target = acpi_target_system_state();
 	if (sys_target == ACPI_STATE_S0)
-		return 1;
+		return false;
 
 	if (adev->power.flags.dsw_present)
-		return 0;
+		return true;
 
 	ret = acpi_dev_pm_get_state(dev, adev, sys_target, NULL, &state);
-	return !ret && state == adev->power.state;
+	if (ret)
+		return true;
+
+	return state != adev->power.state;
+}
+
+/**
+ * acpi_subsys_prepare - Prepare device for system transition to a sleep state.
+ * @dev: Device to prepare.
+ */
+int acpi_subsys_prepare(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret;
+
+	ret = pm_generic_prepare(dev);
+	if (ret < 0 || !adev)
+		return ret;
+
+	adev->power.update_state = acpi_dev_state_update_needed(dev);
+	return !adev->power.update_state;
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
 
@@ -1024,11 +1039,30 @@ EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
  * @dev: Device to handle.
  *
  * Follow PCI and resume devices suspended at run time before running their
- * system suspend callbacks.
+ * system suspend callbacks, unless the DPM_FLAG_SAFE_SUSPEND driver flag is
+ * set for them.
  */
 int acpi_subsys_suspend(struct device *dev)
 {
-	pm_runtime_resume(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	bool resume = !(dev->power.driver_flags & DPM_FLAG_SAFE_SUSPEND);
+
+	if (adev) {
+		/* The device may have resumed in the meantime. */
+		if (pm_runtime_suspended(dev)) {
+			resume = resume || adev->power.update_state;
+		} else {
+			/*
+			 * Work around a super-theoretical race between runtime
+			 * resume and acpi_dev_state_update_needed().
+			 */
+			adev->power.update_state = true;
+			resume = false;
+		}
+	}
+	if (resume)
+		pm_runtime_resume(dev);
+
 	return pm_generic_suspend(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
@@ -1042,8 +1076,17 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
  */
 int acpi_subsys_suspend_late(struct device *dev)
 {
-	int ret = pm_generic_suspend_late(dev);
-	return ret ? ret : acpi_dev_suspend_late(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret;
+
+	ret = pm_generic_suspend_late(dev);
+	if (ret)
+		return ret;
+
+	if (adev && adev->power.update_state)
+		return acpi_dev_suspend_late(dev);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
 
@@ -1057,8 +1100,15 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend_la
  */
 int acpi_subsys_resume_early(struct device *dev)
 {
-	int ret = acpi_dev_resume_early(dev);
-	return ret ? ret : pm_generic_resume_early(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev && adev->power.update_state) {
+		int ret = acpi_dev_resume_early(dev);
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_resume_early(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_resume_early);
 
Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -719,7 +719,8 @@ static void acpi_lpss_dismiss(struct dev
 #ifdef CONFIG_PM_SLEEP
 static int acpi_lpss_suspend_late(struct device *dev)
 {
-	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct lpss_private_data *pdata = acpi_driver_data(adev);
 	int ret;
 
 	ret = pm_generic_suspend_late(dev);
@@ -729,17 +730,22 @@ static int acpi_lpss_suspend_late(struct
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_save_ctx(dev, pdata);
 
-	return acpi_dev_suspend_late(dev);
+	if (adev->power.update_state)
+		return acpi_dev_suspend_late(dev);
+
+	return 0;
 }
 
 static int acpi_lpss_resume_early(struct device *dev)
 {
-	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
-	int ret;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct lpss_private_data *pdata = acpi_driver_data(adev);
 
-	ret = acpi_dev_resume_early(dev);
-	if (ret)
-		return ret;
+	if (adev->power.update_state) {
+		int ret = acpi_dev_resume_early(dev);
+		if (ret)
+			return ret;
+	}
 
 	acpi_lpss_d3_to_d0_delay(pdata);
 
