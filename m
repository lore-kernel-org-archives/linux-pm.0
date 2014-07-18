From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / button: Do not propagate wakeup-from-suspend events
Date: Sat, 19 Jul 2014 00:43:42 +0200
Message-ID: <4168275.1UDt9lgQxY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Peter Ziljstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

During system suspend mark ACPI buttons (other than the lid) as
"suspended" and if in that state, report wakeup events on button
events, but do not propagate those events up the stack.

This prevents systems from being turned off after a button-triggered
wakeup from the "freeze" sleep state.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=77611
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/button.c
===================================================================
--- linux-pm.orig/drivers/acpi/button.c
+++ linux-pm/drivers/acpi/button.c
@@ -79,11 +79,13 @@ static int acpi_button_remove(struct acp
 static void acpi_button_notify(struct acpi_device *device, u32 event);
 
 #ifdef CONFIG_PM_SLEEP
+static int acpi_button_suspend(struct device *dev);
 static int acpi_button_resume(struct device *dev);
 #else
+#define acpi_button_suspend NULL
 #define acpi_button_resume NULL
 #endif
-static SIMPLE_DEV_PM_OPS(acpi_button_pm, NULL, acpi_button_resume);
+static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
 
 static struct acpi_driver acpi_button_driver = {
 	.name = "button",
@@ -102,6 +104,7 @@ struct acpi_button {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
+	bool suspended;
 };
 
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
@@ -293,15 +296,19 @@ static void acpi_button_notify(struct ac
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
 			acpi_lid_send_state(device);
 		} else {
-			int keycode = test_bit(KEY_SLEEP, input->keybit) ?
-						KEY_SLEEP : KEY_POWER;
+			int keycode;
+
+			pm_wakeup_event(&device->dev, 0);
+			if (button->suspended)
+				break;
 
+			keycode = test_bit(KEY_SLEEP, input->keybit) ?
+						KEY_SLEEP : KEY_POWER;
 			input_report_key(input, keycode, 1);
 			input_sync(input);
 			input_report_key(input, keycode, 0);
 			input_sync(input);
 
-			pm_wakeup_event(&device->dev, 0);
 			acpi_bus_generate_netlink_event(
 					device->pnp.device_class,
 					dev_name(&device->dev),
@@ -316,11 +323,21 @@ static void acpi_button_notify(struct ac
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int acpi_button_suspend(struct device *dev)
+{
+	struct acpi_device *device = to_acpi_device(dev);
+	struct acpi_button *button = acpi_driver_data(device);
+
+	button->suspended = true;
+	return 0;
+}
+
 static int acpi_button_resume(struct device *dev)
 {
 	struct acpi_device *device = to_acpi_device(dev);
 	struct acpi_button *button = acpi_driver_data(device);
 
+	button->suspended = false;
 	if (button->type == ACPI_BUTTON_TYPE_LID)
 		return acpi_lid_send_state(device);
 	return 0;
