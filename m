From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 5/9] PM / ACPI: Provide option to disable direct_complete for ACPI devices
Date: Wed, 23 Aug 2017 16:42:05 +0200
Message-ID: <1503499329-28834-6-git-send-email-ulf.hansson@linaro.org>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

In some cases a driver for an ACPI device needs to be able to prevent the
ACPI PM domain from using the direct_complete path during system sleep.

One typical case is when the driver for the device needs its device to stay
runtime enabled, during the __device_suspend phase. This isn't the case
when the direct_complete path is being executed by the PM core, as it then
disables runtime PM for the device in __device_suspend(). Any following
attempts to runtime resume the device after that point, just fails.

A workaround to this problem is to let the driver runtime resume its device
from its ->prepare() callback, as that would prevent the direct_complete
path from being executed. However, that may often be a waste, especially if
it turned out that no one really needed the device.

For this reason, invent acpi_dev_disable|enable_direct_complete(), to allow
drivers to inform the ACPI PM domain to change its default behaviour during
system sleep, and thus control whether it may use the direct_complete path
or not.

Typically a driver should call acpi_dev_disable_direct_comlete() during
->probe() and acpi_dev_enable_direct_complete() in ->remove().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Moved the no_direct_complete flag to the struct acpi_device_power.

---
 drivers/acpi/device_pm.c | 38 +++++++++++++++++++++++++++++++++++++-
 include/acpi/acpi_bus.h  |  1 +
 include/linux/acpi.h     |  4 ++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 5181057..f7bf596 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -933,6 +933,41 @@ EXPORT_SYMBOL_GPL(acpi_subsys_runtime_resume);
 
 #ifdef CONFIG_PM_SLEEP
 /**
+ * acpi_dev_disable_direct_complete - Disable the direct_complete path for ACPI.
+ * @dev: Device to disable the path for.
+ *
+ * Per default the ACPI PM domain tries to use the direct_complete path for its
+ * devices during system sleep. This function allows a user, typically a driver
+ * during probe, to disable the direct_complete path from being used by ACPI.
+ */
+void acpi_dev_disable_direct_complete(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev)
+		adev->power.no_direct_complete = true;
+}
+EXPORT_SYMBOL_GPL(acpi_dev_disable_direct_complete);
+
+/**
+ * acpi_dev_enable_direct_complete - Enable the direct_complete path for ACPI.
+ * @dev: Device to enable the path for.
+ *
+ * Enable the direct_complete path to be used during system suspend for the ACPI
+ * PM domain, which is the default option. Typically a driver that disabled the
+ * path during ->probe(), must call this function during ->remove() to re-enable
+ * the direct_complete path to be used by ACPI.
+ */
+void acpi_dev_enable_direct_complete(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev)
+		adev->power.no_direct_complete = false;
+}
+EXPORT_SYMBOL_GPL(acpi_dev_enable_direct_complete);
+
+/**
  * acpi_dev_suspend_late - Put device into a low-power state using ACPI.
  * @dev: Device to put into a low-power state.
  *
@@ -1023,7 +1058,8 @@ int acpi_subsys_prepare(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (!adev || !pm_runtime_suspended(dev))
+	if (!adev || adev->power.no_direct_complete ||
+	    !pm_runtime_suspended(dev))
 		return 0;
 
 	return !acpi_dev_needs_resume(dev, adev);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index dedf9d7..bdec5f2 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -285,6 +285,7 @@ struct acpi_device_power_state {
 
 struct acpi_device_power {
 	int state;		/* Current state */
+	bool no_direct_complete;
 	struct acpi_device_power_flags flags;
 	struct acpi_device_power_state states[ACPI_D_STATE_COUNT];	/* Power states (D0-D3Cold) */
 };
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c1a5213..ec33c41 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -867,6 +867,8 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
+void acpi_dev_disable_direct_complete(struct device *dev);
+void acpi_dev_enable_direct_complete(struct device *dev);
 int acpi_dev_suspend_late(struct device *dev);
 int acpi_dev_resume_early(struct device *dev);
 int acpi_subsys_prepare(struct device *dev);
@@ -876,6 +878,8 @@ int acpi_subsys_resume_early(struct device *dev);
 int acpi_subsys_suspend(struct device *dev);
 int acpi_subsys_freeze(struct device *dev);
 #else
+static inline void acpi_dev_disable_direct_complete(struct device *dev) {}
+static inline void acpi_dev_enable_direct_complete(struct device *dev) {}
 static inline int acpi_dev_suspend_late(struct device *dev) { return 0; }
 static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
-- 
2.7.4

