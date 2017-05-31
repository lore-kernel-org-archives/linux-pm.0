From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] platform: x86: intel-vbtn: Wake up the system from suspend-to-idle
Date: Thu, 01 Jun 2017 01:24:58 +0200
Message-ID: <2310427.y67sGNgvdM@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49140 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751004AbdEaXe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 19:34:57 -0400
In-Reply-To: <3454366.uzaJljlWGm@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Allow the intel-vbtn driver to wake up the system from suspend-to-idle
by configuring its platform device as a wakeup one by default and
switching it over to a system wakeup events triggering mode during
system suspend transitions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel-vbtn.c |   39 +++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/platform/x86/intel-vbtn.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel-vbtn.c
+++ linux-pm/drivers/platform/x86/intel-vbtn.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
 #include <acpi/acpi_bus.h>
 
 MODULE_LICENSE("GPL");
@@ -46,6 +47,7 @@ static const struct key_entry intel_vbtn
 
 struct intel_vbtn_priv {
 	struct input_dev *input_dev;
+	bool wakeup_mode;
 };
 
 static int intel_vbtn_input_setup(struct platform_device *device)
@@ -73,9 +75,15 @@ static void notify_handler(acpi_handle h
 	struct platform_device *device = context;
 	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
 
-	if (!sparse_keymap_report_event(priv->input_dev, event, 1, true))
-		dev_info(&device->dev, "unknown event index 0x%x\n",
-			 event);
+	if (priv->wakeup_mode) {
+		if (sparse_keymap_entry_from_scancode(priv->input_dev, event)) {
+			pm_wakeup_hard_event(&device->dev);
+			return;
+		}
+	} else if (sparse_keymap_report_event(priv->input_dev, event, 1, true)) {
+		return;
+	}
+	dev_info(&device->dev, "unknown event index 0x%x\n", event);
 }
 
 static int intel_vbtn_probe(struct platform_device *device)
@@ -109,6 +117,7 @@ static int intel_vbtn_probe(struct platf
 	if (ACPI_FAILURE(status))
 		return -EBUSY;
 
+	device_init_wakeup(&device->dev, true);
 	return 0;
 }
 
@@ -125,10 +134,34 @@ static int intel_vbtn_remove(struct plat
 	return 0;
 }
 
+static int intel_vbtn_pm_prepare(struct device *dev)
+{
+	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+
+	priv->wakeup_mode = true;
+	return 0;
+}
+
+static int intel_vbtn_pm_resume(struct device *dev)
+{
+	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+
+	priv->wakeup_mode = false;
+	return 0;
+}
+
+static const struct dev_pm_ops intel_vbtn_pm_ops = {
+	.prepare = intel_vbtn_pm_prepare,
+	.resume = intel_vbtn_pm_resume,
+	.restore = intel_vbtn_pm_resume,
+	.thaw = intel_vbtn_pm_resume,
+};
+
 static struct platform_driver intel_vbtn_pl_driver = {
 	.driver = {
 		.name = "intel-vbtn",
 		.acpi_match_table = intel_vbtn_ids,
+		.pm = &intel_vbtn_pm_ops,
 	},
 	.probe = intel_vbtn_probe,
 	.remove = intel_vbtn_remove,
