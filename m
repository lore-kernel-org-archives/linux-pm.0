From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/5] platform: x86: intel-vbtn: Wake up the system from suspend-to-idle
Date: Wed, 26 Apr 2017 23:24:54 +0200
Message-ID: <2369689.4LNdffUpJi@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Allow the intel-vbtn driver to wake up the system from suspend-to-idle
by configuring its platform device as a wakeup one by default and
switching it over to a system wakeup events triggering mode during
system suspend transitions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel-vbtn.c |   38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

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
@@ -42,6 +43,7 @@ static const struct key_entry intel_vbtn
 
 struct intel_vbtn_priv {
 	struct input_dev *input_dev;
+	bool wakeup_mode;
 };
 
 static int intel_vbtn_input_setup(struct platform_device *device)
@@ -69,9 +71,15 @@ static void notify_handler(acpi_handle h
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
@@ -105,6 +113,7 @@ static int intel_vbtn_probe(struct platf
 	if (ACPI_FAILURE(status))
 		return -EBUSY;
 
+	device_init_wakeup(&device->dev, true);
 	return 0;
 }
 
@@ -121,10 +130,33 @@ static int intel_vbtn_remove(struct plat
 	return 0;
 }
 
+static int intel_vbtn_pm_prepare(struct device *dev)
+{
+	struct platform_device *device = to_platform_device(dev);
+	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
+
+	priv->wakeup_mode = true;
+	return 0;
+}
+
+static void intel_vbtn_pm_complete(struct device *dev)
+{
+	struct platform_device *device = to_platform_device(dev);
+	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
+
+	priv->wakeup_mode = false;
+}
+
+static const struct dev_pm_ops intel_vbtn_pm_ops = {
+	.prepare = intel_vbtn_pm_prepare,
+	.complete = intel_vbtn_pm_complete,
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

