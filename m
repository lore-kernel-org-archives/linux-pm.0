From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v5 11/11] ACPI / PM: Convert acpi_dev_pm_detach() into a static function
Date: Fri, 19 Sep 2014 20:27:44 +0200
Message-ID: <1411151264-16245-12-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:59362 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799AbaISS21 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 14:28:27 -0400
Received: by mail-pd0-f177.google.com with SMTP id fp1so431498pdb.36
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2014 11:28:26 -0700 (PDT)
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

The ->detach() callback for the PM domain has now been fully adopted,
thus there no users left of the acpi_dev_pm_detach() API. This allow us
to convert it into a static function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/device_pm.c | 69 ++++++++++++++++++++++++------------------------
 include/linux/acpi.h     |  2 --
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index eec5ed5..bea6896 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1041,6 +1041,40 @@ static struct dev_pm_domain acpi_general_pm_domain = {
 };
 
 /**
+ * acpi_dev_pm_detach - Remove ACPI power management from the device.
+ * @dev: Device to take care of.
+ * @power_off: Whether or not to try to remove power from the device.
+ *
+ * Remove the device from the general ACPI PM domain and remove its wakeup
+ * notifier.  If @power_off is set, additionally remove power from the device if
+ * possible.
+ *
+ * Callers must ensure proper synchronization of this function with power
+ * management callbacks.
+ */
+static void acpi_dev_pm_detach(struct device *dev, bool power_off)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
+		dev->pm_domain = NULL;
+		acpi_remove_pm_notifier(adev);
+		if (power_off) {
+			/*
+			 * If the device's PM QoS resume latency limit or flags
+			 * have been exposed to user space, they have to be
+			 * hidden at this point, so that they don't affect the
+			 * choice of the low-power state to put the device into.
+			 */
+			dev_pm_qos_hide_latency_limit(dev);
+			dev_pm_qos_hide_flags(dev);
+			acpi_device_wakeup(adev, ACPI_STATE_S0, false);
+			acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
+		}
+	}
+}
+
+/**
  * acpi_dev_pm_attach - Prepare device for ACPI power management.
  * @dev: Device to prepare.
  * @power_on: Whether or not to power on the device.
@@ -1077,39 +1111,4 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
-
-/**
- * acpi_dev_pm_detach - Remove ACPI power management from the device.
- * @dev: Device to take care of.
- * @power_off: Whether or not to try to remove power from the device.
- *
- * Remove the device from the general ACPI PM domain and remove its wakeup
- * notifier.  If @power_off is set, additionally remove power from the device if
- * possible.
- *
- * Callers must ensure proper synchronization of this function with power
- * management callbacks.
- */
-void acpi_dev_pm_detach(struct device *dev, bool power_off)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-
-	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
-		dev->pm_domain = NULL;
-		acpi_remove_pm_notifier(adev);
-		if (power_off) {
-			/*
-			 * If the device's PM QoS resume latency limit or flags
-			 * have been exposed to user space, they have to be
-			 * hidden at this point, so that they don't affect the
-			 * choice of the low-power state to put the device into.
-			 */
-			dev_pm_qos_hide_latency_limit(dev);
-			dev_pm_qos_hide_flags(dev);
-			acpi_device_wakeup(adev, ACPI_STATE_S0, false);
-			acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(acpi_dev_pm_detach);
 #endif /* CONFIG_PM */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 807cbc4..b7926bb 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -587,7 +587,6 @@ static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
 struct acpi_device *acpi_dev_pm_get_node(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
-void acpi_dev_pm_detach(struct device *dev, bool power_off);
 #else
 static inline struct acpi_device *acpi_dev_pm_get_node(struct device *dev)
 {
@@ -597,7 +596,6 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return -ENODEV;
 }
-static inline void acpi_dev_pm_detach(struct device *dev, bool power_off) {}
 #endif
 
 #ifdef CONFIG_ACPI
-- 
1.9.1

