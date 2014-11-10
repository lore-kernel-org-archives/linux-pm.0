From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 27/48] power/reset: vexpress-poweroff: Register with kernel power-off handler
Date: Sun,  9 Nov 2014 17:42:44 -0800
Message-ID: <1415583785-6980-28-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39087 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbaKJBoZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Nov 2014 20:44:25 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xne1p-000VUB-Jr
	for linux-pm@vger.kernel.org; Mon, 10 Nov 2014 01:44:25 +0000
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
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
- Use define to specify poweroff handler priority

 drivers/power/reset/vexpress-poweroff.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 4dc102e2..ee1bcb5 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -36,11 +36,16 @@ static void vexpress_reset_do(struct device *dev, const char *what)
 
 static struct device *vexpress_power_off_device;
 
-static void vexpress_power_off(void)
+static void vexpress_power_off(struct power_off_handler_block *this)
 {
 	vexpress_reset_do(vexpress_power_off_device, "power off");
 }
 
+static struct power_off_handler_block vexpress_power_off_hb = {
+	.handler = vexpress_power_off,
+	.priority = POWER_OFF_PRIORITY_DEFAULT,
+};
+
 static struct device *vexpress_restart_device;
 
 static void vexpress_restart(enum reboot_mode reboot_mode, const char *cmd)
@@ -92,6 +97,7 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	const struct of_device_id *match =
 			of_match_device(vexpress_reset_of_match, &pdev->dev);
 	struct regmap *regmap;
+	int ret;
 
 	if (match)
 		func = (enum vexpress_reset_func)match->data;
@@ -106,7 +112,12 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	switch (func) {
 	case FUNC_SHUTDOWN:
 		vexpress_power_off_device = &pdev->dev;
-		pm_power_off = vexpress_power_off;
+		ret = register_power_off_handler(&vexpress_power_off_hb);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to register power-off handler\n");
+			return ret;
+		}
 		break;
 	case FUNC_RESET:
 		if (!vexpress_restart_device)
-- 
1.9.1

