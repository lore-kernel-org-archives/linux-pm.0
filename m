From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 32/47] x86: olpc: Register xo1 poweroff handler with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:48 -0700
Message-ID: <1413864783-3271-33-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33819 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbaJUEO1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 00:14:27 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XgQq3-002eH8-A8
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 04:14:27 +0000
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with high priority to reflect that the driver
explicitly wants to override default poweroff handlers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use define to specify poweroff handler priority

 arch/x86/platform/olpc/olpc-xo1-pm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/olpc-xo1-pm.c
index a9acde7..a8e427f 100644
--- a/arch/x86/platform/olpc/olpc-xo1-pm.c
+++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
@@ -15,6 +15,7 @@
 #include <linux/cs5535.h>
 #include <linux/platform_device.h>
 #include <linux/export.h>
+#include <linux/notifier.h>
 #include <linux/pm.h>
 #include <linux/mfd/core.h>
 #include <linux/suspend.h>
@@ -92,7 +93,8 @@ asmlinkage __visible int xo1_do_sleep(u8 sleep_state)
 	return 0;
 }
 
-static void xo1_power_off(void)
+static int xo1_power_off(struct notifier_block *this, unsigned long unused1,
+			 void *unused2)
 {
 	printk(KERN_INFO "OLPC XO-1 power off sequence...\n");
 
@@ -108,8 +110,15 @@ static void xo1_power_off(void)
 
 	/* Write SLP_EN bit to start the machinery */
 	outl(0x00002000, acpi_base + CS5536_PM1_CNT);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block xo1_poweroff_nb = {
+	.notifier_call = xo1_power_off,
+	.priority = POWEROFF_PRIORITY_HIGH,
+};
+
 static int xo1_power_state_valid(suspend_state_t pm_state)
 {
 	/* suspend-to-RAM only */
@@ -146,8 +155,12 @@ static int xo1_pm_probe(struct platform_device *pdev)
 
 	/* If we have both addresses, we can override the poweroff hook */
 	if (pms_base && acpi_base) {
+		err = register_power_off_handler(&xo1_poweroff_nb);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to register poweroff handler\n");
+			return err;
+		}
 		suspend_set_ops(&xo1_suspend_ops);
-		pm_power_off = xo1_power_off;
 		printk(KERN_INFO "OLPC XO-1 support registered\n");
 	}
 
@@ -158,12 +171,13 @@ static int xo1_pm_remove(struct platform_device *pdev)
 {
 	mfd_cell_disable(pdev);
 
+	unregister_power_off_handler(&xo1_poweroff_nb);
+
 	if (strcmp(pdev->name, "cs5535-pms") == 0)
 		pms_base = 0;
 	else if (strcmp(pdev->name, "olpc-xo1-pm-acpi") == 0)
 		acpi_base = 0;
 
-	pm_power_off = NULL;
 	return 0;
 }
 
-- 
1.9.1

