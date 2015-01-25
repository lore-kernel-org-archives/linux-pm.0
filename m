From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/6] power/reset: at91: Register with kernel restart handler
Date: Sun, 25 Jan 2015 12:30:41 -0800
Message-ID: <1422217845-18901-3-git-send-email-linux@roeck-us.net>
References: <1422217845-18901-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45861 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbbAYUbB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 15:31:01 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YFTpk-000k8j-Ho
	for linux-pm@vger.kernel.org; Sun, 25 Jan 2015 20:31:01 +0000
In-Reply-To: <1422217845-18901-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org

Register with kernel restart handler instead of setting arm_pm_restart
directly. Register with high priority since the driver unconditionally
overwrites other restart handlers if instantiated.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/at91-reset.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 69a75d99..13584e2 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -17,8 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 
-#include <asm/system_misc.h>
-
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
 
@@ -54,7 +52,8 @@ static void __iomem *at91_ramc_base[2], *at91_rstc_base;
 * reset register it can be left driving the data bus and
 * killing the chance of a subsequent boot from NAND
 */
-static void at91sam9260_restart(enum reboot_mode mode, const char *cmd)
+static int at91sam9260_restart(struct notifier_block *this, unsigned long mode,
+			       void *cmd)
 {
 	asm volatile(
 		/* Align to cache lines */
@@ -76,9 +75,12 @@ static void at91sam9260_restart(enum reboot_mode mode, const char *cmd)
 		  "r" (1),
 		  "r" (AT91_SDRAMC_LPCB_POWER_DOWN),
 		  "r" (AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST));
+
+	return NOTIFY_DONE;
 }
 
-static void at91sam9g45_restart(enum reboot_mode mode, const char *cmd)
+static int at91sam9g45_restart(struct notifier_block *this, unsigned long mode,
+			       void *cmd)
 {
 	asm volatile(
 		/*
@@ -117,6 +119,8 @@ static void at91sam9g45_restart(enum reboot_mode mode, const char *cmd)
 		  "r" (AT91_DDRSDRC_LPCB_POWER_DOWN),
 		  "r" (AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST)
 		: "r0");
+
+	return NOTIFY_DONE;
 }
 
 static void __init at91_reset_status(struct platform_device *pdev)
@@ -161,6 +165,10 @@ static struct of_device_id at91_reset_of_match[] = {
 	{ /* sentinel */ }
 };
 
+static struct notifier_block at91_restart_nb = {
+	.priority = 192,
+};
+
 static int at91_reset_of_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -183,9 +191,8 @@ static int at91_reset_of_probe(struct platform_device *pdev)
 	}
 
 	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
-	arm_pm_restart = match->data;
-
-	return 0;
+	at91_restart_nb.notifier_call = match->data;
+	return register_restart_handler(&at91_restart_nb);
 }
 
 static int at91_reset_platform_probe(struct platform_device *pdev)
@@ -212,10 +219,11 @@ static int at91_reset_platform_probe(struct platform_device *pdev)
 	}
 
 	match = platform_get_device_id(pdev);
-	arm_pm_restart = (void (*)(enum reboot_mode, const char*))
-		match->driver_data;
+	at91_restart_nb.notifier_call =
+		(int (*)(struct notifier_block *,
+			 unsigned long, void *)) match->driver_data;
 
-	return 0;
+	return register_restart_handler(&at91_restart_nb);
 }
 
 static int at91_reset_probe(struct platform_device *pdev)
-- 
2.1.0

