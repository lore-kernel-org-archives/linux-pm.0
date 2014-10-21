From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 27/47] power/reset: vexpress-poweroff: Register with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:43 -0700
Message-ID: <1413864783-3271-28-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-pm@vger.kernel.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Select default priority to reflect that the original code sets
pm_power_off unconditionally.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use define to specify poweroff handler priority

 drivers/power/reset/vexpress-poweroff.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 4dc102e2..1ea2f2e 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -36,11 +37,19 @@ static void vexpress_reset_do(struct device *dev, const char *what)
 
 static struct device *vexpress_power_off_device;
 
-static void vexpress_power_off(void)
+static int vexpress_power_off(struct notifier_block *this,
+			      unsigned long unused1, void *unused2)
 {
 	vexpress_reset_do(vexpress_power_off_device, "power off");
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block vexpress_poweroff_nb = {
+	.notifier_call = vexpress_power_off,
+	.priority = POWEROFF_PRIORITY_DEFAULT,
+};
+
 static struct device *vexpress_restart_device;
 
 static void vexpress_restart(enum reboot_mode reboot_mode, const char *cmd)
@@ -92,6 +101,7 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	const struct of_device_id *match =
 			of_match_device(vexpress_reset_of_match, &pdev->dev);
 	struct regmap *regmap;
+	int ret;
 
 	if (match)
 		func = (enum vexpress_reset_func)match->data;
@@ -106,7 +116,12 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	switch (func) {
 	case FUNC_SHUTDOWN:
 		vexpress_power_off_device = &pdev->dev;
-		pm_power_off = vexpress_power_off;
+		ret = register_power_off_handler(&vexpress_poweroff_nb);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to register poweroff handler\n");
+			return ret;
+		}
 		break;
 	case FUNC_RESET:
 		if (!vexpress_restart_device)
-- 
1.9.1
