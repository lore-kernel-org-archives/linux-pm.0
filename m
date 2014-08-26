From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/9] PM / Domains: Add APIs to attach/detach a power domain for a device
Date: Tue, 26 Aug 2014 14:07:11 +0200
Message-ID: <1409054837-5667-4-git-send-email-ulf.hansson@linaro.org>
References: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

To maintain scalability let's add common methods to attach and detach
a power domain for a device, dev_pm_domain_attach|detach().

Typically dev_pm_domain_attach() shall be invoked from subsystem level
code at the probe phase to try to attach a device to it's power domain.
The reversed actions may be done a the remove phase and then by invoking
dev_pm_domain_detach().

The supported power domains at this point are the ACPI and the generic
power domains.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/common.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h          | 14 +++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index df2e5ee..f544128 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -11,6 +11,8 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/pm_clock.h>
+#include <linux/acpi.h>
+#include <linux/pm_domain.h>
 
 /**
  * dev_pm_get_subsys_data - Create or refcount power.subsys_data for device.
@@ -82,3 +84,59 @@ int dev_pm_put_subsys_data(struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
+
+/**
+ * dev_pm_domain_attach - Attach a device to it's power domain.
+ * @dev: Device to attach.
+ * @power_on: Used to indicate whether we should power on the device.
+ *
+ * The @dev may only be attached to a single power domain. By iterating through
+ * the available alternatives we try to find a valid domain for the device.
+ *
+ * This function should typically be invoked from subsystem level code during
+ * the probe phase. Especially for those that's hold devices which requires
+ * power management through power domains.
+ *
+ * Callers must ensure proper synchronization of this function with power
+ * management callbacks.
+ *
+ * Returns 0 on successfully attached power domain or negative error code.
+ */
+int dev_pm_domain_attach(struct device *dev, bool power_on)
+{
+	int ret;
+
+	ret = acpi_dev_pm_attach(dev, power_on);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	else
+		ret = genpd_dev_pm_attach(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
+
+/**
+ * dev_pm_domain_detach - Detach a device from it's power domain.
+ * @dev: Device to attach.
+ * @power_off: Used to indicate whether we should power off the device.
+ *
+ * The @dev may be attached to a power domain. By iterating through the
+ * available alternatives we detach it from it's power domain.
+ *
+ * This functions will reverse the actions from dev_pm_domain_attach() and
+ * thus detach the @dev from it's power domain. Typically it should be invoked
+ * from subsystem level code during the remove phase.
+ *
+ * Callers must ensure proper synchronization of this function with power
+ * management callbacks.
+ *
+ * Returns 0 on successfully detached power domain or negative error code.
+ */
+int dev_pm_domain_detach(struct device *dev, bool power_off)
+{
+	if (acpi_dev_pm_detach(dev, power_off))
+		return genpd_dev_pm_detach(dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 72c0fe0..8176b07 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -621,6 +621,20 @@ struct dev_pm_domain {
 	struct dev_pm_ops	ops;
 };
 
+#ifdef CONFIG_PM
+extern int dev_pm_domain_attach(struct device *dev, bool power_on);
+extern int dev_pm_domain_detach(struct device *dev, bool power_off);
+#else
+static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
+{
+	return -ENODEV;
+}
+static inline int dev_pm_domain_detach(struct device *dev, bool power_off)
+{
+	return -ENODEV;
+}
+#endif
+
 /*
  * The PM_EVENT_ messages are also used by drivers implementing the legacy
  * suspend framework, based on the ->suspend() and ->resume() callbacks common
-- 
1.9.1

