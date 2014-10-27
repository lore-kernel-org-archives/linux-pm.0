From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 22/47] power/reset: restart-poweroff: Register with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:29 -0700
Message-ID: <1414425354-10359-23-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly.  Register as power-off handler of last resort since the driver
does not really power off the system but executes a restart.

Drop remove function since it is no longer needed.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to sepcify poweroff handler priority
- Use devm_register_power_off_handler
- Drop remove function since it is no longer needed

 drivers/power/reset/restart-poweroff.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index edd707e..bdd1d6e 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -12,37 +12,31 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
-#include <asm/system_misc.h>
 
-static void restart_poweroff_do_poweroff(void)
+static int restart_poweroff_do_poweroff(struct notifier_block *this,
+					unsigned long unused1, void *unused2)
 {
 	reboot_mode = REBOOT_HARD;
 	machine_restart(NULL);
-}
-
-static int restart_poweroff_probe(struct platform_device *pdev)
-{
-	/* If a pm_power_off function has already been added, leave it alone */
-	if (pm_power_off != NULL) {
-		dev_err(&pdev->dev,
-			"pm_power_off function already registered");
-		return -EBUSY;
-	}
 
-	pm_power_off = &restart_poweroff_do_poweroff;
-	return 0;
+	return NOTIFY_DONE;
 }
 
-static int restart_poweroff_remove(struct platform_device *pdev)
-{
-	if (pm_power_off == &restart_poweroff_do_poweroff)
-		pm_power_off = NULL;
+static struct notifier_block restart_power_off_handler = {
+	.notifier_call = restart_poweroff_do_poweroff,
+	.priority = POWER_OFF_PRIORITY_FALLBACK,
+};
 
-	return 0;
+static int restart_poweroff_probe(struct platform_device *pdev)
+{
+	return devm_register_power_off_handler(&pdev->dev,
+					      &restart_power_off_handler);
 }
 
 static const struct of_device_id of_restart_poweroff_match[] = {
@@ -52,7 +46,6 @@ static const struct of_device_id of_restart_poweroff_match[] = {
 
 static struct platform_driver restart_poweroff_driver = {
 	.probe = restart_poweroff_probe,
-	.remove = restart_poweroff_remove,
 	.driver = {
 		.name = "poweroff-restart",
 		.owner = THIS_MODULE,
-- 
1.9.1
