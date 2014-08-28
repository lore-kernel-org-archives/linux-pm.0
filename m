From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/9] PM / Domains: Add APIs to attach/detach a PM domain for a device
Date: Thu, 28 Aug 2014 10:38:56 +0200
Message-ID: <1409215142-8218-4-git-send-email-ulf.hansson@linaro.org>
References: <1409215142-8218-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:62419 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936412AbaH1IjT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 04:39:19 -0400
Received: by mail-lb0-f176.google.com with SMTP id s7so493043lbd.7
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2014 01:39:17 -0700 (PDT)
In-Reply-To: <1409215142-8218-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>

To maintain scalability let's add common methods to attach and detach
a PM domain for a device, dev_pm_domain_attach|detach().

Typically dev_pm_domain_attach() shall be invoked from subsystem level
code at the probe phase to try to attach a device to it's PM domain.
The reversed actions may be done a the remove phase and then by invoking
dev_pm_domain_detach().

The supported PM domains at this point are the ACPI and the generic
PM domains.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/base/power/common.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h          | 14 ++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index df2e5ee..c143d20 100644
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
@@ -82,3 +84,57 @@ int dev_pm_put_subsys_data(struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
+
+/**
+ * dev_pm_domain_attach - Attach a device to it's PM domain.
+ * @dev: Device to attach.
+ * @power_on: Used to indicate whether we should power on the device.
+ *
+ * The @dev may only be attached to a single PM domain. By iterating through
+ * the available alternatives we try to find a valid PM domain for the device.
+ *
+ * This function should typically be invoked from subsystem level code during
+ * the probe phase. Especially for those that's hold devices which requires
+ * power management through PM domains.
+ *
+ * Callers must ensure proper synchronization of this function with power
+ * management callbacks.
+ *
+ * Returns 0 on successfully attached PM domain or negative error code.
+ */
+int dev_pm_domain_attach(struct device *dev, bool power_on)
+{
+	int ret;
+
+	ret = acpi_dev_pm_attach(dev, power_on);
+	if (!ret || ret == -EPROBE_DEFER)
+		return ret;
+
+	return genpd_dev_pm_attach(dev);
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
+
+/**
+ * dev_pm_domain_detach - Detach a device from it's PM domain.
+ * @dev: Device to attach.
+ * @power_off: Used to indicate whether we should power off the device.
+ *
+ * The @dev may be attached to a PM domain. By iterating through the available
+ * alternatives we detach it from it's PM domain.
+ *
+ * This functions will reverse the actions from dev_pm_domain_attach() and thus
+ * detach the @dev from it's PM domain. Typically it should be invoked from
+ * subsystem level code during the remove phase.
+ *
+ * Callers must ensure proper synchronization of this function with power
+ * management callbacks.
+ *
+ * Returns 0 on successfully detached PM domain or negative error code.
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

