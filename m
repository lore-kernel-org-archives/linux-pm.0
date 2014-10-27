From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 32/47] x86: olpc: Register xo1 power-off handler with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:39 -0700
Message-ID: <1414425354-10359-33-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50202 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaJ0P5R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 11:57:17 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XimfV-000cz1-B6
	for linux-pm@vger.kernel.org; Mon, 27 Oct 2014 15:57:17 +0000
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with high priority to reflect that the driver
explicitly wants to override default power-off handlers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority

 arch/x86/platform/olpc/olpc-xo1-pm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/olpc-xo1-pm.c
index a9acde7..e1b7ad0 100644
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
 
+static struct notifier_block xo1_power_off_nb = {
+	.notifier_call = xo1_power_off,
+	.priority = POWER_OFF_PRIORITY_HIGH,
+};
+
 static int xo1_power_state_valid(suspend_state_t pm_state)
 {
 	/* suspend-to-RAM only */
@@ -146,8 +155,12 @@ static int xo1_pm_probe(struct platform_device *pdev)
 
 	/* If we have both addresses, we can override the poweroff hook */
 	if (pms_base && acpi_base) {
+		err = register_power_off_handler(&xo1_power_off_nb);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to register power-off handler\n");
+			return err;
+		}
 		suspend_set_ops(&xo1_suspend_ops);
-		pm_power_off = xo1_power_off;
 		printk(KERN_INFO "OLPC XO-1 support registered\n");
 	}
 
@@ -158,12 +171,13 @@ static int xo1_pm_remove(struct platform_device *pdev)
 {
 	mfd_cell_disable(pdev);
 
+	unregister_power_off_handler(&xo1_power_off_nb);
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

