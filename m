From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 22/48] power/reset: restart-poweroff: Register with kernel power-off handler
Date: Sun,  9 Nov 2014 17:42:39 -0800
Message-ID: <1415583785-6980-23-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
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
v6:
- This patch: No change.
  Global: Replaced priority defines with enum.
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
- Use define to sepcify poweroff handler priority
- Use devm_register_power_off_handler
- Drop remove function since it is no longer needed

 drivers/power/reset/restart-poweroff.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index edd707e..ef2a602 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -15,34 +15,24 @@
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
-#include <asm/system_misc.h>
 
-static void restart_poweroff_do_poweroff(void)
+static void restart_poweroff_do_poweroff(struct power_off_handler_block *this)
 {
 	reboot_mode = REBOOT_HARD;
 	machine_restart(NULL);
 }
 
-static int restart_poweroff_probe(struct platform_device *pdev)
-{
-	/* If a pm_power_off function has already been added, leave it alone */
-	if (pm_power_off != NULL) {
-		dev_err(&pdev->dev,
-			"pm_power_off function already registered");
-		return -EBUSY;
-	}
-
-	pm_power_off = &restart_poweroff_do_poweroff;
-	return 0;
-}
+static struct power_off_handler_block restart_power_off_handler = {
+	.handler = restart_poweroff_do_poweroff,
+	.priority = POWER_OFF_PRIORITY_FALLBACK,
+};
 
-static int restart_poweroff_remove(struct platform_device *pdev)
+static int restart_poweroff_probe(struct platform_device *pdev)
 {
-	if (pm_power_off == &restart_poweroff_do_poweroff)
-		pm_power_off = NULL;
-
-	return 0;
+	return devm_register_power_off_handler(&pdev->dev,
+					      &restart_power_off_handler);
 }
 
 static const struct of_device_id of_restart_poweroff_match[] = {
@@ -52,7 +42,6 @@ static const struct of_device_id of_restart_poweroff_match[] = {
 
 static struct platform_driver restart_poweroff_driver = {
 	.probe = restart_poweroff_probe,
-	.remove = restart_poweroff_remove,
 	.driver = {
 		.name = "poweroff-restart",
 		.owner = THIS_MODULE,
-- 
1.9.1
