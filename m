From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 6/8] PM / ACPI: Enable the runtime PM centric approach for system sleep
Date: Tue, 29 Aug 2017 16:56:48 +0200
Message-ID: <1504018610-10822-7-git-send-email-ulf.hansson@linaro.org>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34294 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754675AbdH2O5M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 10:57:12 -0400
Received: by mail-lf0-f41.google.com with SMTP id d17so14396923lfe.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2017 07:57:11 -0700 (PDT)
In-Reply-To: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

This change enables the ACPI PM domain to cope with drivers that deploys
the runtime PM centric path for system sleep.

Currently the ACPI PM domain supports the direct_complete path, which
offers some nice optimizations from PM point of view during system sleep.
However, the runtime PM centric path have some additional optimizations
that this change enables for the ACPI PM domain. Let's walk through them.

*)
The runtime PM centric path, doesn't require the device to be runtime
suspended during system suspend, when later during system resume trying to
avoid to bring it back into full power. That is the case for the
direct_complete path. This further avoids wasting power during system
resume, but should also decrease the time it takes to resume the device.

**)
When the runtime PM centric path is used, the PM core does not skip calling
any system sleep callbacks for the device, which is the case in the
direct_complete path. Based on that knowledge and relying on the driver to
do the right thing, the ACPI PM domain may avoid to always runtime resume
the device in the device_suspend() phase.

***)
In the runtime PM centric path, the device may remain runtime PM enabled
until the device_suspend_late() phase, instead of as in the direct_complete
path, in the device_suspend() phase. This is convenient if the device needs
to be runtime resumed sometime during the device_suspend() phase.

To deploy the runtime PM centric approach for the ACPI PM domain, and make
it benefit from the above optimizations, the follow changes are made.

First, the ACPI PM domain's runtime PM callbacks may be called when runtime
PM has been disabled for the device. This serves as an indication to
understand when they are running in the system sleep sequence, instead of
in the regular runtime PM path. For these cases, make the ACPI PM domain to
execute the same operations as normally being run, when the
->suspend_late() and the ->resume_early() callbacks are invoked.

Second, the ACPI PM domain's ->suspend_late() callback, shall not execute
the regular operations to put the device into low power state, when the
runtime PM centric path is used. Calling pm_generic_suspend_late() is
sufficient. Vice verse applies to the ACPI PM domain's ->resume_early()
callback.

Third, in the ACPI PM domain's ->suspend|freeze() callbacks, let's avoid
runtime resuming the device in case the runtime PM centric path is used,
unless there are ACPI PM domain specific reasons to not.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Convert to use the PM core flag, is_rpm_sleep flag.
	- Fold in changes from patch v2 7/9, which means avoiding to runtime
	resume the device in the ACPI PM domain's ->suspend|freeze() callbacks.
	- Updated changelog to reflect new changes.

---
 drivers/acpi/acpi_lpss.c | 56 ++++++++++++++++++++++++++++++---------------
 drivers/acpi/device_pm.c | 59 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 87 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index e726173..2e34f69 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -732,7 +732,7 @@ static int acpi_lpss_suspend_late(struct device *dev)
 	int ret;
 
 	ret = pm_generic_suspend_late(dev);
-	if (ret)
+	if (ret || dev_pm_is_rpm_sleep(dev))
 		return ret;
 
 	return lpss_suspend_late(dev);
@@ -757,13 +757,22 @@ static int lpss_resume_early(struct device *dev)
 
 static int acpi_lpss_resume_early(struct device *dev)
 {
-	int ret;
+	int ret = 0;
 
-	ret = lpss_resume_early(dev);
-	if (ret)
-		return ret;
+	if (!dev_pm_is_rpm_sleep(dev))
+		ret = lpss_resume_early(dev);
 
-	return pm_generic_resume_early(dev);
+	return ret ? ret : pm_generic_resume_early(dev);
+}
+#else
+static inline int lpss_suspend_late(struct device *dev)
+{
+	return 0;
+}
+
+static inline int lpss_resume_early(struct device *dev)
+{
+	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */
 
@@ -861,6 +870,9 @@ static int acpi_lpss_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (!pm_runtime_enabled(dev))
+		return lpss_suspend_late(dev);
+
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_save_ctx(dev, pdata);
 
@@ -882,21 +894,29 @@ static int acpi_lpss_runtime_resume(struct device *dev)
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
 
-	/*
-	 * This call is kept first to be in symmetry with
-	 * acpi_lpss_runtime_suspend() one.
-	 */
-	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
-		lpss_iosf_exit_d3_state();
+	if (pm_runtime_enabled(dev)) {
+		/*
+		 * This call is kept first to be in symmetry with
+		 * acpi_lpss_runtime_suspend() one.
+		 */
+		if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON &&
+		    iosf_mbi_available())
+			lpss_iosf_exit_d3_state();
 
-	ret = acpi_dev_runtime_resume(dev);
-	if (ret)
-		return ret;
+		ret = acpi_dev_runtime_resume(dev);
+		if (ret)
+			return ret;
 
-	acpi_lpss_d3_to_d0_delay(pdata);
+		acpi_lpss_d3_to_d0_delay(pdata);
 
-	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
-		acpi_lpss_restore_ctx(dev, pdata);
+		if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
+			acpi_lpss_restore_ctx(dev, pdata);
+
+	} else {
+		ret = lpss_resume_early(dev);
+		if (ret)
+			return ret;
+	}
 
 	return pm_generic_runtime_resume(dev);
 }
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 5181057..f5c4d0e 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -913,7 +913,14 @@ EXPORT_SYMBOL_GPL(acpi_dev_runtime_resume);
 int acpi_subsys_runtime_suspend(struct device *dev)
 {
 	int ret = pm_generic_runtime_suspend(dev);
-	return ret ? ret : acpi_dev_runtime_suspend(dev);
+
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_enabled(dev))
+		return acpi_dev_suspend_late(dev);
+
+	return acpi_dev_runtime_suspend(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_runtime_suspend);
 
@@ -926,7 +933,13 @@ EXPORT_SYMBOL_GPL(acpi_subsys_runtime_suspend);
  */
 int acpi_subsys_runtime_resume(struct device *dev)
 {
-	int ret = acpi_dev_runtime_resume(dev);
+	int ret = 0;
+
+	if (!pm_runtime_enabled(dev))
+		ret = acpi_dev_resume_early(dev);
+	else
+		ret = acpi_dev_runtime_resume(dev);
+
 	return ret ? ret : pm_generic_runtime_resume(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_runtime_resume);
@@ -1023,7 +1036,7 @@ int acpi_subsys_prepare(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (!adev || !pm_runtime_suspended(dev))
+	if (!adev || dev_pm_is_rpm_sleep(dev) || !pm_runtime_suspended(dev))
 		return 0;
 
 	return !acpi_dev_needs_resume(dev, adev);
@@ -1042,7 +1055,8 @@ void acpi_subsys_complete(struct device *dev)
 	 * the sleep state it is going out of and it has never been resumed till
 	 * now, resume it in case the firmware powered it up.
 	 */
-	if (dev->power.direct_complete && pm_resume_via_firmware())
+	if ((dev->power.direct_complete || dev_pm_is_rpm_sleep(dev)) &&
+	    pm_resume_via_firmware())
 		pm_request_resume(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_complete);
@@ -1052,11 +1066,20 @@ EXPORT_SYMBOL_GPL(acpi_subsys_complete);
  * @dev: Device to handle.
  *
  * Follow PCI and resume devices suspended at run time before running their
- * system suspend callbacks.
+ * system suspend callbacks. However, try to avoid it in case the runtime PM
+ * centric path is used for the device and then trust the driver to do the
+ * right thing.
  */
 int acpi_subsys_suspend(struct device *dev)
 {
-	pm_runtime_resume(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return 0;
+
+	if (!dev_pm_is_rpm_sleep(dev) || acpi_dev_needs_resume(dev, adev))
+		pm_runtime_resume(dev);
+
 	return pm_generic_suspend(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
@@ -1071,7 +1094,11 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
 int acpi_subsys_suspend_late(struct device *dev)
 {
 	int ret = pm_generic_suspend_late(dev);
-	return ret ? ret : acpi_dev_suspend_late(dev);
+
+	if (ret || dev_pm_is_rpm_sleep(dev))
+		return ret;
+
+	return acpi_dev_suspend_late(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
 
@@ -1085,7 +1112,11 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
  */
 int acpi_subsys_resume_early(struct device *dev)
 {
-	int ret = acpi_dev_resume_early(dev);
+	int ret = 0;
+
+	if (!dev_pm_is_rpm_sleep(dev))
+		ret = acpi_dev_resume_early(dev);
+
 	return ret ? ret : pm_generic_resume_early(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_resume_early);
@@ -1096,13 +1127,21 @@ EXPORT_SYMBOL_GPL(acpi_subsys_resume_early);
  */
 int acpi_subsys_freeze(struct device *dev)
 {
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return 0;
+
 	/*
 	 * This used to be done in acpi_subsys_prepare() for all devices and
 	 * some drivers may depend on it, so do it here.  Ideally, however,
 	 * runtime-suspended devices should not be touched during freeze/thaw
-	 * transitions.
+	 * transitions. In case the runtime PM centric path is used, let's try
+	 * to avoid it.
 	 */
-	pm_runtime_resume(dev);
+	if (!dev_pm_is_rpm_sleep(dev) || acpi_dev_needs_resume(dev, adev))
+		pm_runtime_resume(dev);
+
 	return pm_generic_freeze(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_freeze);
-- 
2.7.4
