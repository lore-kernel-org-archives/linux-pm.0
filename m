From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 30/48] x86: iris: Register with kernel power-off handler
Date: Thu,  6 Nov 2014 08:43:14 -0800
Message-ID: <1415292213-28652-31-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56390 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaKFQow (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 11:44:52 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XmQB2-000UTN-1Y
	for linux-pm@vger.kernel.org; Thu, 06 Nov 2014 16:44:52 +0000
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with high priority to reflect that the original code
overwrites existing power-off handlers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5:
- Rebase to v3.18-rc3
v4:
- Do not use notifiers but internal functions and data structures to manage
  the list of power-off handlers. Drop unused parameters from callbacks, and
  make the power-off function type void
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Use devm_register_power_off_handler

 arch/x86/platform/iris/iris.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/iris/iris.c b/arch/x86/platform/iris/iris.c
index 4d171e8..7152814 100644
--- a/arch/x86/platform/iris/iris.c
+++ b/arch/x86/platform/iris/iris.c
@@ -47,15 +47,18 @@ static bool force;
 module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Set to one to force poweroff handler installation.");
 
-static void (*old_pm_power_off)(void);
-
-static void iris_power_off(void)
+static void iris_power_off(struct power_off_handler_block *this)
 {
 	outb(IRIS_GIO_PULSE, IRIS_GIO_OUTPUT);
 	msleep(850);
 	outb(IRIS_GIO_REST, IRIS_GIO_OUTPUT);
 }
 
+static struct power_off_handler_block iris_power_off_hb = {
+	.handler = iris_power_off,
+	.priority = POWER_OFF_PRIORITY_HIGH,
+};
+
 /*
  * Before installing the power_off handler, try to make sure the OS is
  * running on an Iris.  Since Iris does not support DMI, this is done
@@ -65,20 +68,25 @@ static void iris_power_off(void)
 static int iris_probe(struct platform_device *pdev)
 {
 	unsigned char status = inb(IRIS_GIO_INPUT);
+	int ret;
+
 	if (status == IRIS_GIO_NODEV) {
 		printk(KERN_ERR "This machine does not seem to be an Iris. "
 			"Power off handler not installed.\n");
 		return -ENODEV;
 	}
-	old_pm_power_off = pm_power_off;
-	pm_power_off = &iris_power_off;
+
+	ret = devm_register_power_off_handler(&pdev->dev, &iris_power_off_hb);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register power-off handler\n");
+		return ret;
+	}
 	printk(KERN_INFO "Iris power_off handler installed.\n");
 	return 0;
 }
 
 static int iris_remove(struct platform_device *pdev)
 {
-	pm_power_off = old_pm_power_off;
 	printk(KERN_INFO "Iris power_off handler uninstalled.\n");
 	return 0;
 }
-- 
1.9.1

