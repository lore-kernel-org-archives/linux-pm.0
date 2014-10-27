From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 28/47] power/reset: at91-poweroff: Register with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:35 -0700
Message-ID: <1414425354-10359-29-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Select default priority to reflect that the original code sets
pm_power_off unconditionally.

Acked-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Added patch

 drivers/power/reset/at91-poweroff.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index c610003..0894b45 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -12,8 +12,10 @@
 
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/printk.h>
 
 #define AT91_SHDW_CR	0x00		/* Shut Down Control Register */
@@ -66,11 +68,19 @@ static void __init at91_wakeup_status(void)
 	pr_info("AT91: Wake-Up source: %s\n", reason);
 }
 
-static void at91_poweroff(void)
+static int at91_poweroff(struct notifier_block *this, unsigned long unused1,
+			 void *unused2)
 {
 	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc_base + AT91_SHDW_CR);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block at91_power_off_nb = {
+	.notifier_call = at91_poweroff,
+	.priority = POWER_OFF_PRIORITY_DEFAULT,
+};
+
 const enum wakeup_type at91_poweroff_get_wakeup_mode(struct device_node *np)
 {
 	const char *pm;
@@ -134,9 +144,7 @@ static int at91_poweroff_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		at91_poweroff_dt_set_wakeup_mode(pdev);
 
-	pm_power_off = at91_poweroff;
-
-	return 0;
+	return devm_register_power_off_handler(&pdev->dev, &at91_power_off_nb);
 }
 
 static struct of_device_id at91_poweroff_of_match[] = {
-- 
1.9.1
