From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 26/47] power/reset: msm-poweroff: Register with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:33 -0700
Message-ID: <1414425354-10359-27-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Select fallback priority since the code does not really poweroff
the system but resets it instead.

Acked-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Fix headline and description
- Merge with restart handler code now used in same driver
- Use dev_warn instead of dev_err

 drivers/power/reset/msm-poweroff.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index 4702efd..c63c070 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -19,10 +19,12 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/pm.h>
 
 static void __iomem *msm_ps_hold;
+
 static int do_msm_restart(struct notifier_block *nb, unsigned long action,
 			   void *data)
 {
@@ -37,11 +39,11 @@ static struct notifier_block restart_nb = {
 	.priority = 128,
 };
 
-static void do_msm_poweroff(void)
-{
+static struct notifier_block msm_power_off_nb = {
 	/* TODO: Add poweroff capability */
-	do_msm_restart(&restart_nb, 0, NULL);
-}
+	.notifier_call = do_msm_restart,
+	.priority = POWER_OFF_PRIORITY_FALLBACK,
+};
 
 static int msm_restart_probe(struct platform_device *pdev)
 {
@@ -55,7 +57,8 @@ static int msm_restart_probe(struct platform_device *pdev)
 
 	register_restart_handler(&restart_nb);
 
-	pm_power_off = do_msm_poweroff;
+	if (register_power_off_handler(&msm_power_off_nb))
+		dev_warn(&pdev->dev, "Failed to register power-off handler\n");
 
 	return 0;
 }
-- 
1.9.1
