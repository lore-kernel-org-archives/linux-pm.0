From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 7/9] PM / ACPI: Avoid runtime resuming device in acpi_subsys_suspend|freeze()
Date: Wed, 23 Aug 2017 16:42:07 +0200
Message-ID: <1503499329-28834-8-git-send-email-ulf.hansson@linaro.org>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

In the case when the no_direct_complete flag is set for the ACPI device, we
can under some conditions during system sleep, avoid runtime resuming the
device in acpi_subsys_suspend|freeze(). This means we can decrease the time
needed for the device to enter its system sleep state, but also that we can
avoid to waste power.

More precisely, calling acpi_dev_needs_resume() from the
acpi_subsys_suspend|freeze() in cases when the no_direct_complete flag has
been set for the device, tells us if a runtime resume of the device is
needed. Thus it may allow us to avoid it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Clarified changelog.
	- Improved comments is code.
	- Rebased.
	- Improved change to avoid open-coding.

---
 drivers/acpi/device_pm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index b595968..5dd23de 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1117,11 +1117,19 @@ EXPORT_SYMBOL_GPL(acpi_subsys_complete);
  * @dev: Device to handle.
  *
  * Follow PCI and resume devices suspended at run time before running their
- * system suspend callbacks.
+ * system suspend callbacks. However, try to avoid it when no_direct_complete
+ * is set.
  */
 int acpi_subsys_suspend(struct device *dev)
 {
-	pm_runtime_resume(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return 0;
+
+	if (!adev->power.no_direct_complete || acpi_dev_needs_resume(dev, adev))
+		pm_runtime_resume(dev);
+
 	return pm_generic_suspend(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
@@ -1178,13 +1186,20 @@ EXPORT_SYMBOL_GPL(acpi_subsys_resume_early);
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
+	 * transitions. In case the no_direct_complete is set, try to avoid it.
 	 */
-	pm_runtime_resume(dev);
+	if (!adev->power.no_direct_complete || acpi_dev_needs_resume(dev, adev))
+		pm_runtime_resume(dev);
+
 	return pm_generic_freeze(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_freeze);
-- 
2.7.4

