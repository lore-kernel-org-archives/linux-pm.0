From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 34/47] acpi: Register power-off handler with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:41 -0700
Message-ID: <1414425354-10359-35-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with high priority to reflect that the driver explicitly
overrides existing power-off handlers.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
- Replace acpi: with ACPI: in log message
v2:
- Use define to specify poweroff handler priority
- Use pr_warn instead of pr_err

 drivers/acpi/sleep.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 05a31b5..7875b92 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -16,6 +16,8 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/acpi.h>
 #include <linux/module.h>
@@ -827,14 +829,22 @@ static void acpi_power_off_prepare(void)
 	acpi_disable_all_gpes();
 }
 
-static void acpi_power_off(void)
+static int acpi_power_off(struct notifier_block *this,
+			  unsigned long unused1, void *unused2)
 {
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	printk(KERN_DEBUG "%s called\n", __func__);
 	local_irq_disable();
 	acpi_enter_sleep_state(ACPI_STATE_S5);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block acpi_power_off_nb = {
+	.notifier_call = acpi_power_off,
+	.priority = POWER_OFF_PRIORITY_HIGH,
+};
+
 int __init acpi_sleep_init(void)
 {
 	char supported[ACPI_S_STATE_COUNT * 3 + 1];
@@ -851,7 +861,8 @@ int __init acpi_sleep_init(void)
 	if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
 		sleep_states[ACPI_STATE_S5] = 1;
 		pm_power_off_prepare = acpi_power_off_prepare;
-		pm_power_off = acpi_power_off;
+		if (register_power_off_handler(&acpi_power_off_nb))
+			pr_warn("ACPI: Failed to register power-off handler\n");
 	}
 
 	supported[0] = 0;
-- 
1.9.1
