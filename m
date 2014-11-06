From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 26/48] power/reset: msm-poweroff: Register with kernel power-off handler
Date: Thu,  6 Nov 2014 08:43:10 -0800
Message-ID: <1415292213-28652-27-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56337 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbaKFQoo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 11:44:44 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XmQAt-000U17-T3
	for linux-pm@vger.kernel.org; Thu, 06 Nov 2014 16:44:44 +0000
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>

Register with kernel power-off handler instead of setting pm_power_off
directly. Select fallback priority since the code does not really poweroff
the system but resets it instead.

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
- Use define to specify poweroff handler priority
- Fix headline and description
- Merge with restart handler code now used in same driver
- Use dev_warn instead of dev_err

 drivers/power/reset/msm-poweroff.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index 4702efd..822f358 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -23,11 +23,17 @@
 #include <linux/pm.h>
 
 static void __iomem *msm_ps_hold;
-static int do_msm_restart(struct notifier_block *nb, unsigned long action,
-			   void *data)
+
+static void _do_msm_restart(void)
 {
 	writel(0, msm_ps_hold);
 	mdelay(10000);
+}
+
+static int do_msm_restart(struct notifier_block *nb, unsigned long action,
+			  void *data)
+{
+	_do_msm_restart();
 
 	return NOTIFY_DONE;
 }
@@ -37,12 +43,17 @@ static struct notifier_block restart_nb = {
 	.priority = 128,
 };
 
-static void do_msm_poweroff(void)
+static void do_msm_power_off(struct power_off_handler_block *this)
 {
-	/* TODO: Add poweroff capability */
-	do_msm_restart(&restart_nb, 0, NULL);
+	/* TODO: Add power-off capability */
+	_do_msm_restart();
 }
 
+static struct power_off_handler_block power_off_hb = {
+	.handler = do_msm_power_off,
+	.priority = POWER_OFF_PRIORITY_FALLBACK,
+};
+
 static int msm_restart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -55,7 +66,8 @@ static int msm_restart_probe(struct platform_device *pdev)
 
 	register_restart_handler(&restart_nb);
 
-	pm_power_off = do_msm_poweroff;
+	if (register_power_off_handler(&power_off_hb))
+		dev_warn(&pdev->dev, "Failed to register power-off handler\n");
 
 	return 0;
 }
-- 
1.9.1

