From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 28/48] power/reset: at91-poweroff: Register with kernel power-off handler
Date: Thu,  6 Nov 2014 08:43:12 -0800
Message-ID: <1415292213-28652-29-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56361 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbaKFQor (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 11:44:47 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XmQAx-000U56-4k
	for linux-pm@vger.kernel.org; Thu, 06 Nov 2014 16:44:47 +0000
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>

Register with kernel power-off handler instead of setting pm_power_off
directly. Select default priority to reflect that the original code sets
pm_power_off unconditionally.

Acked-by: Sebastian Reichel <sre@kernel.org>
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
- Added patch

 drivers/power/reset/at91-poweroff.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index c610003..6fc5944 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/printk.h>
 
 #define AT91_SHDW_CR	0x00		/* Shut Down Control Register */
@@ -66,11 +67,16 @@ static void __init at91_wakeup_status(void)
 	pr_info("AT91: Wake-Up source: %s\n", reason);
 }
 
-static void at91_poweroff(void)
+static void at91_poweroff(struct power_off_handler_block *this)
 {
 	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc_base + AT91_SHDW_CR);
 }
 
+static struct power_off_handler_block at91_power_off_hb = {
+	.handler = at91_poweroff,
+	.priority = POWER_OFF_PRIORITY_DEFAULT,
+};
+
 const enum wakeup_type at91_poweroff_get_wakeup_mode(struct device_node *np)
 {
 	const char *pm;
@@ -134,9 +140,7 @@ static int at91_poweroff_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		at91_poweroff_dt_set_wakeup_mode(pdev);
 
-	pm_power_off = at91_poweroff;
-
-	return 0;
+	return devm_register_power_off_handler(&pdev->dev, &at91_power_off_hb);
 }
 
 static struct of_device_id at91_poweroff_of_match[] = {
-- 
1.9.1

