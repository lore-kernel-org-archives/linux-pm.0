From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 34/47] acpi: Register poweroff handler with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:50 -0700
Message-ID: <1413864783-3271-35-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33890 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbaJUEOd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 00:14:33 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XgQq8-002eLu-NN
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 04:14:32 +0000
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with high priority to reflect that the driver explicitly
overrides existing poweroff handlers.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Use define to specify poweroff handler priority
- Use pr_warn instead of pr_err

 drivers/acpi/sleep.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 05a31b5..1eba563 100644
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
 
+static struct notifier_block acpi_poweroff_nb = {
+	.notifier_call = acpi_power_off,
+	.priority = POWEROFF_PRIORITY_HIGH,
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
+		if (register_power_off_handler(&acpi_poweroff_nb))
+			pr_warn("acpi: Failed to register poweroff handler\n");
 	}
 
 	supported[0] = 0;
-- 
1.9.1

