From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 8/9] PM / ACPI: Avoid runtime resuming device in acpi_subsys_suspend|freeze()
Date: Wed, 21 Jun 2017 21:21:27 +0200
Message-ID: <1498072888-14782-9-git-send-email-ulf.hansson@linaro.org>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

In the case when the no_direct_complete flag is set for the ACPI device, we
can under some conditions during system sleep, avoid runtime resuming the
device in acpi_subsys_suspend|freeze(). This will of course improve the
time it takes for the system to suspend, but also avoid wasting power.

More precisely, from acpi_subsys_suspend|freeze(), let's call
acpi_dev_needs_resume() when the no_direct_complete flag is set, as it
tells us when runtime resume of the device is needed, thus let's avoid it
if possible.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/device_pm.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index e0324ab..f3061f9 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1056,10 +1056,19 @@ EXPORT_SYMBOL_GPL(acpi_subsys_complete);
  * @dev: Device to handle.
  *
  * Follow PCI and resume devices suspended at run time before running their
- * system suspend callbacks.
+ * system suspend callbacks. However, try to avoid it when no_direct_complete
+ * is set.
  */
 int acpi_subsys_suspend(struct device *dev)
 {
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return 0;
+
+	if (adev->no_direct_complete && !acpi_dev_needs_resume(dev, adev))
+		return pm_generic_suspend(dev);
+
 	pm_runtime_resume(dev);
 	return pm_generic_suspend(dev);
 }
@@ -1117,12 +1126,22 @@ EXPORT_SYMBOL_GPL(acpi_subsys_resume_early);
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
+	 * transitions. At least when no_direct_complete is set, let's try to
+	 * avoid it.
 	 */
+
+	if (adev->no_direct_complete && !acpi_dev_needs_resume(dev, adev))
+		return pm_generic_freeze(dev);
+
 	pm_runtime_resume(dev);
 	return pm_generic_freeze(dev);
 }
-- 
2.7.4

