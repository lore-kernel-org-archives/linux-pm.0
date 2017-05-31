From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] platform: x86: intel-hid: Wake up the system from suspend-to-idle
Date: Thu, 01 Jun 2017 01:26:10 +0200
Message-ID: <2020242.xT8Lc5VtKt@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3454366.uzaJljlWGm@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Allow the intel-hid driver to wake up the system from suspend-to-idle
by configuring its platform device as a wakeup one by default and
switching it over to a system wakeup events triggering mode during
system suspend transitions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel-hid.c |   40 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/platform/x86/intel-hid.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel-hid.c
+++ linux-pm/drivers/platform/x86/intel-hid.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
 #include <acpi/acpi_bus.h>
 
 MODULE_LICENSE("GPL");
@@ -75,6 +76,7 @@ static const struct key_entry intel_arra
 struct intel_hid_priv {
 	struct input_dev *input_dev;
 	struct input_dev *array;
+	bool wakeup_mode;
 };
 
 static int intel_hid_set_enable(struct device *device, bool enable)
@@ -116,23 +118,37 @@ static void intel_button_array_enable(st
 		dev_warn(device, "failed to set button capability\n");
 }
 
-static int intel_hid_pl_suspend_handler(struct device *device)
+static int intel_hid_pm_prepare(struct device *device)
 {
-	intel_hid_set_enable(device, false);
-	intel_button_array_enable(device, false);
+	struct intel_hid_priv *priv = dev_get_drvdata(device);
+
+	priv->wakeup_mode = true;
+	return 0;
+}
 
+static int intel_hid_pl_suspend_handler(struct device *device)
+{
+	if (pm_suspend_via_firmware()) {
+		intel_hid_set_enable(device, false);
+		intel_button_array_enable(device, false);
+	}
 	return 0;
 }
 
 static int intel_hid_pl_resume_handler(struct device *device)
 {
-	intel_hid_set_enable(device, true);
-	intel_button_array_enable(device, true);
+	struct intel_hid_priv *priv = dev_get_drvdata(device);
 
+	priv->wakeup_mode = false;
+	if (pm_resume_via_firmware()) {
+		intel_hid_set_enable(device, true);
+		intel_button_array_enable(device, true);
+	}
 	return 0;
 }
 
 static const struct dev_pm_ops intel_hid_pl_pm_ops = {
+	.prepare = intel_hid_pm_prepare,
 	.freeze  = intel_hid_pl_suspend_handler,
 	.thaw  = intel_hid_pl_resume_handler,
 	.restore  = intel_hid_pl_resume_handler,
@@ -186,6 +202,19 @@ static void notify_handler(acpi_handle h
 	unsigned long long ev_index;
 	acpi_status status;
 
+	if (priv->wakeup_mode) {
+		/* Wake up on 5-button array events only. */
+		if (event == 0xc0 || !priv->array)
+			return;
+
+		if (sparse_keymap_entry_from_scancode(priv->array, event))
+			pm_wakeup_hard_event(&device->dev);
+		else
+			dev_info(&device->dev, "unknown event 0x%x\n", event);
+
+		return;
+	}
+
 	/* 0xC0 is for HID events, other values are for 5 button array */
 	if (event != 0xc0) {
 		if (!priv->array ||
@@ -270,6 +299,7 @@ static int intel_hid_probe(struct platfo
 				 "failed to enable HID power button\n");
 	}
 
+	device_init_wakeup(&device->dev, true);
 	return 0;
 
 err_remove_notify:

