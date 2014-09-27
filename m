From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/10] power/reset: axxia: Register with kernel restart handler
Date: Fri, 26 Sep 2014 17:57:15 -0700
Message-ID: <1411779438-23127-8-git-send-email-linux@roeck-us.net>
References: <1411779438-23127-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411779438-23127-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Anders Berg <anders.berg@lsi.com>
List-Id: linux-pm@vger.kernel.org

Register with kernel restart handler instead of setting arm_pm_restart
directly.

Cc: Anders Berg <anders.berg@lsi.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/axxia-reset.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/axxia-reset.c b/drivers/power/reset/axxia-reset.c
index 3b1f8d6..2a772d9 100644
--- a/drivers/power/reset/axxia-reset.c
+++ b/drivers/power/reset/axxia-reset.c
@@ -19,14 +19,12 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 
-#include <asm/system_misc.h>
-
-
 #define SC_CRIT_WRITE_KEY	0x1000
 #define SC_LATCH_ON_RESET	0x1004
 #define SC_RESET_CONTROL	0x1008
@@ -39,7 +37,8 @@
 
 static struct regmap *syscon;
 
-static void do_axxia_restart(enum reboot_mode reboot_mode, const char *cmd)
+static int axxia_restart_handler(struct notifier_block *this,
+				 unsigned long mode, void *cmd)
 {
 	/* Access Key (0xab) */
 	regmap_write(syscon, SC_CRIT_WRITE_KEY, 0xab);
@@ -50,11 +49,19 @@ static void do_axxia_restart(enum reboot_mode reboot_mode, const char *cmd)
 	/* Assert chip reset */
 	regmap_update_bits(syscon, SC_RESET_CONTROL,
 			   RSTCTL_RST_CHIP, RSTCTL_RST_CHIP);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block axxia_restart_nb = {
+	.notifier_call = axxia_restart_handler,
+	.priority = 128,
+};
+
 static int axxia_reset_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	int err;
 
 	syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
 	if (IS_ERR(syscon)) {
@@ -62,7 +69,9 @@ static int axxia_reset_probe(struct platform_device *pdev)
 		return PTR_ERR(syscon);
 	}
 
-	arm_pm_restart = do_axxia_restart;
+	err = register_restart_handler(&axxia_restart_nb);
+	if (err)
+		dev_err(dev, "cannot register restart handler (err=%d)\n", err);
 
 	return 0;
 }
-- 
1.9.1
