From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [RFC PATCH 15/16] power/reset: restart-poweroff: Register with kernel poweroff handler
Date: Tue, 30 Sep 2014 11:00:55 -0700
Message-ID: <1412100056-15517-16-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412100056-15517-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Register with kernel poweroff handler instead of seting pm_power_off
directly.  Register as poweroff handler of last resort since the driver
does not really power off the system but executes a restart.

Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/power/reset/restart-poweroff.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index edd707e..82d058f 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -12,35 +12,33 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
 #include <linux/reboot.h>
-#include <asm/system_misc.h>
 
-static void restart_poweroff_do_poweroff(void)
+static int restart_poweroff_do_poweroff(struct notifier_block *this,
+					unsigned long unused1, void *unused2)
 {
 	reboot_mode = REBOOT_HARD;
 	machine_restart(NULL);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block restart_poweroff_handler = {
+	.notifier_call = restart_poweroff_do_poweroff,
+};
+
 static int restart_poweroff_probe(struct platform_device *pdev)
 {
-	/* If a pm_power_off function has already been added, leave it alone */
-	if (pm_power_off != NULL) {
-		dev_err(&pdev->dev,
-			"pm_power_off function already registered");
-		return -EBUSY;
-	}
-
-	pm_power_off = &restart_poweroff_do_poweroff;
-	return 0;
+	return register_restart_handler(&restart_poweroff_handler);
 }
 
 static int restart_poweroff_remove(struct platform_device *pdev)
 {
-	if (pm_power_off == &restart_poweroff_do_poweroff)
-		pm_power_off = NULL;
+	unregister_restart_handler(&restart_poweroff_handler);
 
 	return 0;
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
