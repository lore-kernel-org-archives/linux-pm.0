From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/9] PM / ACPI: Enable the runtime PM centric approach for system sleep
Date: Wed, 21 Jun 2017 21:21:26 +0200
Message-ID: <1498072888-14782-8-git-send-email-ulf.hansson@linaro.org>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

This change extends the interpretation of the ACPI's no_direct_complete
flag to be used to enable the so called runtime PM centric approach, for
devices being attached to the ACPI PM domain.

The principle behind the runtime PM centric approach is to re-use the
runtime PM callbacks to implement system sleep for drivers/subsystems.
Moreover, using the runtime PM centric approach gives an optimized
behaviour around avoiding to wake up a device from its low power state
during system sleep, unless really needed.

To deploy the runtime PM centric approach for a subsystem/driver, the
following adaptations needs to be made.

First, the runtime PM callbacks may be called when runtime PM has been
disabled for the device. This serves as an indication for the callbacks to
understand they are running in the system sleep sequence, instead of in the
regular runtime PM path. In some cases, a callback needs to take different
actions depending in what path it is being executed in, as is the case for
the ACPI PM domain.

In particular for the ACPI PM domain's ->runtime_suspend|resume()
callbacks, when those finds runtime PM being disabled for the device, it
instead executes the same operations as normally being run when
->suspend_late() and ->resume_early() callbacks are invoked during system
sleep.

Second, at the PM domain level, it is expected that the driver for the
device makes use of pm_runtime_force_suspend|resume(), to re-use the
runtime PM callbacks to put the device into low power state and to wake it
up when needed during system sleep.

For the ACPI PM domain's ->suspend_late() and ->resume_early() callbacks,
it means bypassing the operations putting the device into low power state
and the operations that wakes it up. Instead it shall invoke only the lower
level ->suspend_late() and ->resume_early() callbacks for the driver, if
present.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/acpi_lpss.c | 58 +++++++++++++++++++++++++++++++++---------------
 drivers/acpi/device_pm.c | 56 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 89 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 12bc5c7..adc84b3 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -714,10 +714,11 @@ static int lpss_suspend_late(struct device *dev)
 
 static int acpi_lpss_suspend_late(struct device *dev)
 {
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	int ret;
 
 	ret = pm_generic_suspend_late(dev);
-	if (ret)
+	if (ret || adev->no_direct_complete)
 		return ret;
 
 	return lpss_suspend_late(dev);
@@ -742,13 +743,23 @@ static int lpss_resume_early(struct device *dev)
 
 static int acpi_lpss_resume_early(struct device *dev)
 {
-	int ret;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret = 0;
 
-	ret = lpss_resume_early(dev);
-	if (ret)
-		return ret;
+	if (!adev->no_direct_complete)
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
 
@@ -846,6 +857,9 @@ static int acpi_lpss_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (!pm_runtime_enabled(dev))
+		return lpss_suspend_late(dev);
+
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_save_ctx(dev, pdata);
 
@@ -867,21 +881,29 @@ static int acpi_lpss_runtime_resume(struct device *dev)
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
index 2393a1a..e0324ab 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -859,7 +859,14 @@ EXPORT_SYMBOL_GPL(acpi_dev_runtime_resume);
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
 
@@ -872,7 +879,17 @@ EXPORT_SYMBOL_GPL(acpi_subsys_runtime_suspend);
  */
 int acpi_subsys_runtime_resume(struct device *dev)
 {
-	int ret = acpi_dev_runtime_resume(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret = 0;
+
+	if (!adev)
+		return 0;
+
+	if (!pm_runtime_enabled(dev))
+		ret = acpi_dev_resume_early(dev);
+	else
+		ret = acpi_dev_runtime_resume(dev);
+
 	return ret ? ret : pm_generic_runtime_resume(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_runtime_resume);
@@ -1015,13 +1032,21 @@ EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
  */
 void acpi_subsys_complete(struct device *dev)
 {
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return;
+
 	pm_generic_complete(dev);
 	/*
 	 * If the device had been runtime-suspended before the system went into
 	 * the sleep state it is going out of and it has never been resumed till
-	 * now, resume it in case the firmware powered it up.
+	 * now, resume it in case the firmware powered it up. Also resume it in
+	 * case no_direct_complete is set for the device, to be sure the device
+	 * are managed correctly when firmware has powered it up.
 	 */
-	if (dev->power.direct_complete && pm_resume_via_firmware())
+	if ((dev->power.direct_complete || adev->no_direct_complete) &&
+	    pm_resume_via_firmware())
 		pm_request_resume(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_complete);
@@ -1049,8 +1074,17 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
  */
 int acpi_subsys_suspend_late(struct device *dev)
 {
-	int ret = pm_generic_suspend_late(dev);
-	return ret ? ret : acpi_dev_suspend_late(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret;
+
+	if (!adev)
+		return 0;
+
+	ret = pm_generic_suspend_late(dev);
+	if (ret || adev->no_direct_complete)
+		return ret;
+
+	return acpi_dev_suspend_late(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
 
@@ -1064,7 +1098,15 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
  */
 int acpi_subsys_resume_early(struct device *dev)
 {
-	int ret = acpi_dev_resume_early(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret = 0;
+
+	if (!adev)
+		return 0;
+
+	if (!adev->no_direct_complete)
+		ret = acpi_dev_resume_early(dev);
+
 	return ret ? ret : pm_generic_resume_early(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_resume_early);
-- 
2.7.4

